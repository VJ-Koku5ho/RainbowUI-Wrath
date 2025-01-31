local myname, ns = ...

local GetPlayerAuraBySpellID = C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID or _G.GetPlayerAuraBySpellID

ns.defaults = {
    profile = {
        default_icon = "VignetteLoot",
        show_on_world = true,
        show_on_minimap = false,
        show_npcs = true,
        show_npcs_onlynotable = false,
        show_treasure = true,
        show_routes = true,
        upcoming = true,
        found = false,
        collectablefound = true,
        achievedfound = true,
        questfound = true,
        icon_scale = 1.0,
        icon_alpha = 1.0,
        icon_item = false,
        tooltip_charloot = true,
        tooltip_pointanchor = false,
        tooltip_item = true,
        tooltip_questid = false,
        groupsHidden = {},
        groupsHiddenByZone = {['*']={},},
        zonesHidden = {},
        achievementsHidden = {},
        worldmapoverlay = true,
    },
    char = {
        hidden = {
            ['*'] = {},
        },
    },
}

ns.options = {
    type = "group",
    name = "巫妖王",
    get = function(info) return ns.db[info[#info]] end,
    set = function(info, v)
        ns.db[info[#info]] = v
        ns.HL:Refresh()
    end,
    hidden = function(info)
        return ns.hiddenConfig[info[#info]]
    end,
    args = {
        icon = {
            type = "group",
            name = "圖示設定",
            inline = true,
            order = 10,
            args = {
                desc = {
                    name = "這些設定控制圖示的外觀和看起來的樣子。",
                    type = "description",
                    order = 0,
                },
                icon_scale = {
                    type = "range",
                    name = "圖示大小",
                    desc = "圖示的縮放大小",
                    min = 0.25, max = 2, step = 0.01,
                    order = 20,
                },
                icon_alpha = {
                    type = "range",
                    name = "圖示透明度",
                    desc = "圖示的透明度",
                    min = 0, max = 1, step = 0.01,
                    order = 30,
                },
                show_on_world = {
                    type = "toggle",
                    name = "世界地圖",
                    desc = "要在世界地圖上顯示圖示",
                    order = 40,
                },
                show_on_minimap = {
                    type = "toggle",
                    name = "小地圖",
                    desc = "要在小地圖上顯示圖示",
                    order = 50,
                },
                default_icon = {
                    type = "select",
                    name = "預設圖示",
                    values = {
                        VignetteLoot = CreateAtlasMarkup("VignetteLoot", 20, 20) .. " 寶箱",
                        VignetteLootElite = CreateAtlasMarkup("VignetteLootElite", 20, 20) .. " 星星寶箱",
                        Garr_TreasureIcon = CreateAtlasMarkup("Garr_TreasureIcon", 20, 20) .. " 發光寶箱",
                    },
                    order = 60,
                },
                worldmapoverlay = {
                    type = "toggle",
                    name = "世界地圖按鈕",
                    desc = "在世界地圖加上一個按鈕，方便快速使用這些選項。",
                    set = function(info, v)
                        ns.db[info[#info]] = v
                        if WorldMapFrame.RefreshOverlayFrames then
                            WorldMapFrame:RefreshOverlayFrames()
                        end
                    end,
                    hidden = function(info)
                        if not ns.SetupMapOverlay then
                            return true
                        end
                        return ns.options.hidden(info)
                    end,
                    order = 70,
                },
            },
        },
        display = {
            type = "group",
            name = "要顯示什麼",
            inline = true,
            order = 20,
            args = {
                icon_item = {
                    type = "toggle",
                    name = "顯示物品圖示",
                    desc = "可以的話顯示物品圖示，否則會顯示成就圖示。",
                    order = 0,
                },
                tooltip_item = {
                    type = "toggle",
                    name = "顯示物品浮動提示",
                    desc = "顯示完整的物品浮動提示資訊",
                    order = 10,
                },
                tooltip_charloot = {
                    type = "toggle",
                    name = "只有此角色能拾取",
                    desc = "只顯示當前角色會掉落的物品",
                    order = 12,
                },
                tooltip_pointanchor = {
                    type = "toggle",
                    name = "浮動提示貼齊圖示",
                    desc = "浮動提示資訊要對齊每一個圖示，還是在地圖上固定一個位置。",
                    order = 15,
                },
                -- the "found" cluster
                found = {
                    type = "toggle",
                    name = "顯示已有的",
                    desc = "是否要顯示你已經擁有的物品?",
                    order = 20,
                },
                achievedfound = {
                    type = "toggle",
                    name = "完成的成就視為已有",
                    desc = "可重覆的每日任務 '並且' 和成就綁定的地點，只當作是成就。",
                    order = 21,
                },
                collectablefound = {
                    type = "toggle",
                    name = "收藏品視為已有",
                    desc = "帳號共用的物品，像是坐騎、寵物、玩具，視為已經擁有。",
                    order = 22,
                },
                questfound = {
                    type = "toggle",
                    name = "追蹤的任務視為已有",
                    desc = "很多東西都有隱藏任務，可用來追蹤你今天 / 本週 / 曾經拾取過，是否能夠再次拾取。",
                    order = 23,
                },
                upcoming = {
                    type = "toggle",
                    name = "顯示無法取得的",
                    desc = "顯示你尚無法取得的 (需要滿等、有前置任務...等)，會標示為紅色。",
                    order = 25,
                },
                show_npcs = {
                    type = "toggle",
                    name = "顯示稀有怪",
                    desc = "顯示稀有的 NPC，通常會掉落物品或完成成就。",
                    order = 30,
                },
                show_npcs_onlynotable = {
                    type = "toggle",
                    name = "...只顯示值得注意的",
                    desc = "只顯示仍可取得某些東西的 NPC: 當前角色的成就、外觀。",
                    order = 31,
                },
                show_treasure = {
                    type = "toggle",
                    name = "顯示寶藏",
                    desc = "顯示可以拾取的寶藏",
                    order = 35,
                },
                show_routes = {
                    type = "toggle",
                    name = "顯示路徑",
                    desc = "顯示地點之間的相關路徑",
                    disabled = function() return not ns.RouteWorldMapDataProvider end,
                    order = 37,
                },
                tooltip_questid = {
                    type = "toggle",
                    name = "顯示任務 ID",
                    desc = "顯次和此地點關聯的任務的內部 ID，方便回報問題時使用。",
                    order = 40,
                },
                unhide = {
                    type = "execute",
                    name = "重置隱藏地點",
                    desc = "顯示所有你曾經手動點右鍵選擇 \"隱藏\" 的地點。",
                    func = function()
                        for _, coords in pairs(ns.hidden) do
                            wipe(coords)
                        end
                        ns.HL:Refresh()
                    end,
                    order = 50,
                },
            },
        },
        achievementsHidden = {
            type = "multiselect",
            name = "顯示成就",
            desc = "切換是否要顯示指定成就的地點",
            get = function(info, key) return not ns.db[info[#info]][key] end,
            set = function(info, key, value)
                ns.db[info[#info]][key] = not value
                ns.HL:Refresh()
            end,
            values = function(info)
                local values = {}
                for uiMapID, points in pairs(ns.points) do
                    for coord, point in pairs(points) do
                        if point.achievement and not values[point.achievement] then
                            local _, achievement = GetAchievementInfo(point.achievement)
                            values[point.achievement] = achievement or 'achievement:'..point.achievement
                        end
                    end
                end
                -- replace ourself with the built values table
                info.option.values = values
                return values
            end,
            hidden = function(info)
                for uiMapID, points in pairs(ns.points) do
                    for coord, point in pairs(points) do
                        if point.achievement then
                            info.option.hidden = nil
                            return ns.options.hidden(info)
                        end
                    end
                end
                info.option.hidden = true
                return true
            end,
            order = 30,
        },
        zonesHidden = {
            type = "multiselect",
            name = "顯示區域",
            desc = "切換是否要顯示指定區域的地點",
            get = function(info, key) return not ns.db[info[#info]][key] end,
            set = function(info, key, value)
                ns.db[info[#info]][key] = not value
                ns.HL:Refresh()
            end,
            values = function(info)
                local values = {}
                for uiMapID in pairs(ns.points) do
                    if not values[uiMapID] then
                        local info = C_Map.GetMapInfo(uiMapID)
                        if info and info.mapType == 3 then
                            -- zones only
                            values[uiMapID] = info.name
                        end
                    end
                end
                -- replace ourself with the built values table
                info.option.values = values
                return values
            end,
            order = 35,
        },
        groupsHidden = {
            type = "multiselect",
            name = "顯示群組",
            desc = "切換是否要顯示一整群特定的地點",
            get = function(info, key) return not ns.db[info[#info]][key] end,
            set = function(info, key, value)
                ns.db[info[#info]][key] = not value
                ns.HL:Refresh()
            end,
            values = function(info)
                local values = {}
                for uiMapID, points in pairs(ns.points) do
                    for coord, point in pairs(points) do
                        if point.group and not values[point.group] then
                            values[point.group] = ns.groups[point.group] or point.group
                        end
                    end
                end
                -- replace ourself with the built values table
                info.option.values = values
                return values
            end,
            hidden = function(info)
                for uiMapID, points in pairs(ns.points) do
                    for coord, point in pairs(points) do
                        if point.group then
                            info.option.hidden = nil
                            return ns.options.hidden(info)
                        end
                    end
                end
                info.option.hidden = true
                return true
            end,
            order = 40,
        }
    },
}

local function doTestAll(test, input, ...)
    for _, value in ipairs(input) do
        if not test(value, ...) then
            return false
        end
    end
    return true
end
local function doTestAny(test, input, ...)
    for _, value in ipairs(input) do
        if test(value, ...) then
            return true
        end
    end
    return false
end
local doTest, doTestDefaultAny
do
    local function doTestMaker(default)
        return function(test, input, ...)
            if type(input) == "table" and not input.__parent then
                if input.any then return doTestAny(test, input, ...) end
                if input.all then return doTestAll(test, input, ...) end
                return default(test, input, ...)
            else
                return test(input, ...)
            end
        end
    end
    doTest = doTestMaker(doTestAll)
    doTestDefaultAny = doTestMaker(doTestAny)
end
ns.doTest = doTest
ns.doTestDefaultAny = doTestDefaultAny
local function testMaker(test, override)
    return function(...)
        return (override or doTest)(test, ...)
    end
end

local itemInBags = testMaker(function(item) return GetItemCount(item, true) > 0 end)
local allQuestsComplete = testMaker(function(quest) return C_QuestLog.IsQuestFlaggedCompleted(quest) end)
ns.allQuestsComplete = allQuestsComplete

local temp_criteria = {}
local allCriteriaComplete = testMaker(function(criteria, achievement)
    local _, _, completed, _, _, completedBy = ns.GetCriteria(achievement, criteria)
    if not (completed and (not completedBy or completedBy == ns.playerName)) then
        return false
    end
    return true
end, function(test, input, achievement, ...)
    if input == true then
        wipe(temp_criteria)
        for i=1,GetAchievementNumCriteria(achievement) do
            table.insert(temp_criteria, i)
        end
        input = temp_criteria
    end
    return doTest(test, input, achievement, ...)
end)

local brokenItems = {
    -- itemid : {appearanceid, sourceid}
    [153268] = {25124, 90807}, -- Enclave Aspirant's Axe
    [153316] = {25123, 90885}, -- Praetor's Ornamental Edge
}
local function GetAppearanceAndSource(itemLinkOrID)
    local itemID = GetItemInfoInstant(itemLinkOrID)
    if not itemID then return end
    local appearanceID, sourceID = C_TransmogCollection.GetItemInfo(itemLinkOrID)
    if not appearanceID then
        -- sometimes the link won't actually give us an appearance, but itemID will
        -- e.g. mythic Drape of Iron Sutures from Shadowmoon Burial Grounds
        appearanceID, sourceID = C_TransmogCollection.GetItemInfo(itemID)
    end
    if not appearanceID and brokenItems[itemID] then
        -- ...and there's a few that just need to be hardcoded
        appearanceID, sourceID = unpack(brokenItems[itemID])
    end
    return appearanceID, sourceID
end
local canLearnCache = {}
local function CanLearnAppearance(itemLinkOrID)
    if not _G.C_Transmog then return false end
    local itemID = GetItemInfoInstant(itemLinkOrID)
    if not itemID then return end
    if canLearnCache[itemID] ~= nil then
        return canLearnCache[itemID]
    end
    -- First, is this a valid source at all?
    local canBeChanged, noChangeReason, canBeSource, noSourceReason = C_Transmog.CanTransmogItem(itemID)
    if canBeSource == nil or noSourceReason == 'NO_ITEM' then
        -- data loading, don't cache this
        return
    end
    if not canBeSource then
        canLearnCache[itemID] = false
        return false
    end
    local appearanceID, sourceID = GetAppearanceAndSource(itemLinkOrID)
    if not appearanceID then
        canLearnCache[itemID] = false
        return false
    end
    local hasData, canCollect = C_TransmogCollection.PlayerCanCollectSource(sourceID)
    if hasData then
        canLearnCache[itemID] = canCollect
    end
    return canLearnCache[itemID]
end
local hasAppearanceCache = {}
local function HasAppearance(itemLinkOrID)
    local itemID = GetItemInfoInstant(itemLinkOrID)
    if not itemID then return end
    if hasAppearanceCache[itemID] ~= nil then
        return hasAppearanceCache[itemID]
    end
    if C_TransmogCollection.PlayerHasTransmogByItemInfo(itemLinkOrID) then
        -- short-circuit further checks because this specific item is known
        hasAppearanceCache[itemID] = true
        return true
    end
    -- Although this isn't known, its appearance might be known from another item
    local appearanceID = GetAppearanceAndSource(itemLinkOrID)
    if not appearanceID then
        hasAppearanceCache[itemID] = false
        return
    end
    local sources = C_TransmogCollection.GetAllAppearanceSources(appearanceID)
    if not sources then return end
    for _, sourceID in ipairs(sources) do
        if C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(sourceID) then
            hasAppearanceCache[itemID] = true
            return true
        end
    end
    return false
end

local function PlayerHasMount(mountid)
    if not _G.C_MountJournal then return false end
    return (select(11, C_MountJournal.GetMountInfoByID(mountid)))
end
local function PlayerHasPet(petid)
    return (C_PetJournal.GetNumCollectedInfo(petid) > 0)
end
ns.itemRestricted = function(item)
    if type(item) ~= "table" then return false end
    if item.covenant and item.covenant ~= C_Covenants.GetActiveCovenantID() then
        return true
    end
    if item.class and ns.playerClass ~= item.class then
        return true
    end
    if item.requires and not ns.conditions.check(item.requires) then
        return true
    end
    -- TODO: profession recipes
    return false
end
ns.itemIsKnowable = function(item)
    if ns.CLASSIC then return false end
    if type(item) == "table" then
        if ns.itemRestricted(item) then
            return false
        end
        if item.set and ns.playerClassMask then
            local info = C_TransmogSets.GetSetInfo(item.set)
            if info and info.classMask then
                return bit.band(info.classMask, ns.playerClassMask) == ns.playerClassMask
            end
        end
        return (item.toy or item.mount or item.pet or item.quest or item.questComplete or item.set or item.spell or CanLearnAppearance(item[1]))
    end
    return CanLearnAppearance(item)
end
ns.itemIsKnown = function(item)
    -- returns true/false/nil for yes/no/not-knowable
    if ns.CLASSIC then return GetItemCount(ns.lootitem(item), true) > 0 end
    if type(item) == "table" then
        -- TODO: could arguably do transmog here, too. Since we're mostly
        -- considering soulbound things, the restrictions on seeing appearances
        -- known cross-armor-type wouldn't really matter...
        if item.toy then return PlayerHasToy(item[1]) end
        if item.mount then return PlayerHasMount(item.mount) end
        if item.pet then return PlayerHasPet(item.pet) end
        if item.quest then return C_QuestLog.IsQuestFlaggedCompleted(item.quest) or C_QuestLog.IsOnQuest(item.quest) end
        if item.questComplete then return C_QuestLog.IsQuestFlaggedCompleted(item.questComplete) end
        if item.set then
            local info = C_TransmogSets.GetSetInfo(item.set)
            if info then
                if info.collected then return true end
                -- we want to return nil for sets the current class can't learn:
                if info.classMask and bit.band(info.classMask, ns.playerClassMask) == ns.playerClassMask then return false end
            end
            return false
        end
        if item.spell then
            -- can't use the tradeskill functions + the recipe-spell because that data's only available after the tradeskill window has been opened...
            local info = C_TooltipInfo.GetItemByID(item[1])
            if info then
                TooltipUtil.SurfaceArgs(info)
                for _, line in ipairs(info.lines) do
                    TooltipUtil.SurfaceArgs(line)
                    if line.leftText and string.match(line.leftText, _G.ITEM_SPELL_KNOWN) then
                        return true
                    end
                end
            end
            return false
        end
        if CanLearnAppearance(item[1]) then return HasAppearance(item[1]) end
    elseif CanLearnAppearance(item) then
        return HasAppearance(item)
    end
end
local hasKnowableLoot = testMaker(ns.itemIsKnowable, doTestAny)
local allLootKnown = testMaker(function(item)
    -- This returns true if all loot is known-or-unknowable
    -- If the "no knowable loot" case matters this should be gated behind hasKnowableLoot
    local known = ns.itemIsKnown(item)
    if known == nil then
        return true
    end
    return known
end)

local function isAchieved(point)
    if point.criteria and point.criteria ~= true then
        if not allCriteriaComplete(point.criteria, point.achievement) then
            return false
        end
    else
        local completedByMe = select(13, GetAchievementInfo(point.achievement))
        if not completedByMe then
            return false
        end
    end
    return true
end
local function isNotable(point)
    -- A point is notable if it has loot you can use, or is tied to an
    -- achievement you can still earn. It ignores quest-completion, because
    -- repeatable mobs are a nightmare here.
    if point.achievement and not isAchieved(point) then
        return true
    end
    if point.loot and hasKnowableLoot(point.loot) and not allLootKnown(point.loot) then
        return true
    end
    if point.follower and not C_Garrison.IsFollowerCollected(point.follower) then
        return true
    end
end
local function everythingFound(point)
    local ret
    if ns.db.collectablefound and point.loot and hasKnowableLoot(point.loot) then
        if not allLootKnown(point.loot) then
            return false
        end
        ret = true
    end
    if (ns.db.achievedfound or not point.quest) and point.achievement and not point.achievementNotFound then
        if not isAchieved(point) then
            return false
        end
        ret = true
    end
    if point.follower then
        if not C_Garrison.IsFollowerCollected(point.follower) then
            return false
        end
        ret = true
    end
    return ret
end

local zoneHidden
zoneHidden = function(uiMapID)
    if ns.db.zonesHidden[uiMapID] then
        return true
    end
    local info = C_Map.GetMapInfo(uiMapID)
    if info and info.parentMapID then
        return zoneHidden(info.parentMapID)
    end
    return false
end
local achievementHidden = function(achievement)
    if not achievement then return false end
    return ns.db.achievementsHidden[achievement]
end

local checkPois
do
    local poi_expirations = {}
    local poi_zone_expirations = {}
    local pois_byzone = {}
    local function refreshPois(zone)
        local now = time()
        if not poi_zone_expirations[zone] or now > poi_zone_expirations[zone] then
            pois_byzone[zone] = wipe(pois_byzone[zone] or {})
            for _, poi in ipairs(C_AreaPoiInfo.GetAreaPOIForMap(zone)) do
                pois_byzone[zone][poi] = true
                poi_expirations[poi] = now + (C_AreaPoiInfo.GetAreaPOISecondsLeft(poi) or 60)
            end
            poi_zone_expirations[zone] = now + 1
        end
    end
    function checkPois(pois)
        for _, data in ipairs(pois) do
            local zone, poi = unpack(data)
            local now = time()
            if now > (poi_expirations[poi] or 0) then
                refreshPois(zone)
                poi_expirations[poi] = poi_expirations[poi] or (now + 60)
            end
            if pois_byzone[zone][poi] then
                return true
            end
        end
    end
end

local checkArt = testMaker(function(artid, uiMapID) return artid == C_Map.GetMapArtID(uiMapID) end, doTestDefaultAny)

local function showOnMapType(point, uiMapID, isMinimap)
    -- nil means to respect the preferences, but points can override
    if isMinimap then
        if point.minimap ~= nil then return point.minimap end
        if ns.map_spellids[uiMapID] then
            if ns.map_spellids[uiMapID] == true or GetPlayerAuraBySpellID(ns.map_spellids[uiMapID]) then
                return false
            end
        end
        return ns.db.show_on_minimap
    end
    if point.worldmap ~= nil then return point.worldmap end
    return ns.db.show_on_world
end

ns.should_show_point = function(coord, point, currentZone, isMinimap)
    if not coord or coord < 0 then return false end
    if not showOnMapType(point, currentZone, isMinimap) then
        return false
    end
    if zoneHidden(currentZone) then
        return false
    end
    if achievementHidden(point.achievement) then
        return false
    end
    if ns.hidden[currentZone] and ns.hidden[currentZone][coord] then
        return false
    end
    if point.group and ns.db.groupsHidden[point.group] or ns.db.groupsHiddenByZone[currentZone][point.group] then
        return false
    end
    if point.ShouldShow then
        local show = point:ShouldShow()
        if show ~= nil then
            return show
        end
    end
    if point.outdoors_only and IsIndoors() then
        return false
    end
    if point.art and not checkArt(point.art, currentZone) then
        return false
    end
    if point.poi and not checkPois(point.poi) then
        return false
    end
    if point.faction and point.faction ~= ns.playerFaction then
        return false
    end
    if not ns.db.found and not point.always then
        if everythingFound(point) == true then
            return false
        end
        if ns.db.questfound and point.quest and allQuestsComplete(point.quest) then
            return false
        end
        -- the rest are proxies for the actual "found" status:
        if point.inbag and itemInBags(point.inbag) then
            return false
        end
        if point.onquest and C_QuestLog.IsOnQuest(type(point.onquest) == "number" and point.onquest or point.quest) then
            return false
        end
        if point.hide_quest and C_QuestLog.IsQuestFlaggedCompleted(point.hide_quest) then
            -- This is distinct from point.quest as it's supposed to be for
            -- other trackers that make the point not _complete_ but still
            -- hidden (Draenor treasure maps, so far):
            return false
        end
        if point.found and ns.conditions.check(point.found) then
            return false
        end
    end
    if not point.follower then
        if point.npc then
            if not ns.db.show_npcs then
                return false
            end
            if ns.db.show_npcs_onlynotable and not isNotable(point) then
                -- Only show "notable" npcs, which we define as "has loot you can use or has an achievement"
                return false
            end
        else
            -- Not an NPC, not a follower, must be treasure
            if not ns.db.show_treasure then
                return false
            end
        end
    end
    if point.requires_buff and not doTest(GetPlayerAuraBySpellID, point.requires_buff) then
        return false
    end
    if point.requires_no_buff and doTest(GetPlayerAuraBySpellID, point.requires_no_buff) then
        return false
    end
    if point.requires_item and not itemInBags(point.requires_item) then
        return false
    end
    if point.requires_worldquest and not (C_TaskQuest.IsActive(point.requires_worldquest) or C_QuestLog.IsQuestFlaggedCompleted(point.requires_worldquest)) then
        return false
    end
    if point.requires and not ns.conditions.check(point.requires) then
        return false
    end
    if not ns.db.upcoming or point.upcoming == false then
        if not ns.point_active(point) then
            return false
        end
        if ns.point_upcoming(point) then
            return false
        end
    end
    return true
end
