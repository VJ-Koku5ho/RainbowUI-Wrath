--[[----------------------------------------------------------------------------

    LiteButtonAuras
    Copyright 2021 Mike "Xodiv" Battersby

    Slash command just allows setting and displaying the options since
    there is no GUI for it.

----------------------------------------------------------------------------]]--

local addonName, LBA = ...

local function TrueStr(x)
    return x and "on" or "off"
end

local header = ORANGE_FONT_COLOR:WrapTextInColorCode('快捷列光環時間: ')

local function printf(...)
    local msg = string.format(...)
    SELECTED_CHAT_FRAME:AddMessage(header .. msg)
end

local function PrintUsage()
    printf(GAMEMENU_HELP .. ":")
    printf("  /lba options")
    printf("  /lba stacks on|off|default")
    printf("  /lba timers on|off|default")
    printf("  /lba colortimers on|off|default")
    printf("  /lba decimaltimers on|off|default")
    printf("  /lba font FontName|default")
    printf("  /lba font path [ size [ flags ] ]")
    printf("  /lba aura help")
    printf("  /lba deny help")
end

local function PrintAuraUsage()
    printf(GAMEMENU_HELP .. ":")
    printf("  /lba aura default，恢復成預設的光環清單。")
    printf("  /lba aura list，顯示光環清單。")
    printf("  /lba aura wipe，清空光環清單。")
    printf("  /lba aura hide <光環的法術ID> on <技能>，隱藏技能的光環時間。")
    printf("  /lba aura show <光環的法術ID> on <技能>，在技能顯示光環時間。")
end

local function PrintDenyUsage()
    printf(GAMEMENU_HELP .. ":")
    printf("  /lba deny defaults，恢復成預設的技能清單。")
    printf("  /lba deny list，不顯示時間的技能清單。")
    printf("  /lba deny wipe，清空不顯示時間的技能清單。")
    printf("  /lba deny add <技能>，新增不顯示時間的技能。")
    printf("  /lba deny remove <技能>，移除不顯示時間的技能。")
end

local function PrintOptions()
    printf(SETTINGS .. ':')
    printf("  stacks = " .. TrueStr(LBA.db.profile.showStacks))
    printf("  timers = " .. TrueStr(LBA.db.profile.showTimers))
    printf("  colortimers = " .. TrueStr(LBA.db.profile.colorTimers))
    printf("  decimaltimers = " .. TrueStr(LBA.db.profile.decimalTimers))
    printf("  font = [ '%s', %.1f, '%s' ]",
                        LBA.db.profile.fontPath,
                        LBA.db.profile.fontSize,
                        LBA.db.profile.fontFlags)
end

local function SetFont(args)
    for _,arg in ipairs(args) do
        if arg == 'default' then
            path, size, flags = arg, arg, arg
        elseif _G[arg] and _G[arg].GetFont then
            fontName = arg
            path, size, flags = _G[arg]:GetFont()
        elseif tonumber(arg) then
            size = math.floor(tonumber(arg) + 0.5)
        elseif arg:find("\\") then
            name = arg
        else
            flags = arg
        end
    end
    if path then LBA.SetOption('fontPath', path) end
    if size then LBA.SetOption('fontSize', size) end
    if flags then LBA.SetOption('fontFlags', flags) end
end

local function ParseAuraMap(cmdarg)
    local aura, ability = cmdarg:match('^(.+) on (.+)$')
    local auraName, _, _, _, _, _, auraID = GetSpellInfo(aura)
    local abilityName, _, _, _, _, _, abilityID = GetSpellInfo(ability)
    return auraID, auraName or aura, abilityID, abilityName or ability
end

local function PrintAuraMapList()
    printf("光環清單:")
    for i, entry in ipairs(LBA.GetAuraMapList()) do
        printf("%3d. %s", i, LBA.AuraMapString(unpack(entry)))
    end
end

local function AuraCommand(argstr)
    local _, cmd, cmdarg = strsplit(" ", argstr, 3)
    if cmd == 'list' then
        PrintAuraMapList()
    elseif cmd == 'show' and cmdarg then
        local aura, auraName, ability, abilityName = ParseAuraMap(cmdarg)
        if not aura then
            printf("錯誤: 未知的光環法術: %s", NORMAL_FONT_COLOR:WrapTextInColorCode(auraName))
        elseif not ability then
            printf("錯誤: 未知的技能法術: %s", NORMAL_FONT_COLOR:WrapTextInColorCode(abilityName))
        else
            printf("顯示 %s", LBA.AuraMapString(aura, auraName, ability, abilityName))
            LBA.AddAuraMap(aura, ability)
        end
    elseif cmd == 'hide' and cmdarg then
        local aura, auraName, ability, abilityName = ParseAuraMap(cmdarg)
        if not aura then
            printf("錯誤: 未知的光環法術。")
        elseif not ability then
            printf("錯誤: 未知的技能法術。")
        else
            printf("隱藏 %s", LBA.AuraMapString(aura, auraName, ability, abilityName))
            LBA.RemoveAuraMap(aura, ability)
        end
    elseif cmd == 'wipe' then
        printf("正在清空光環清單。")
        LBA.WipeAuraMap()
    elseif cmd == 'default' then
        printf("將光環清單恢復成預設值。")
        LBA.WipeAuraMap()
        LBA.DefaultAuraMap()
    else
        PrintAuraUsage()
    end

    return true
end

local function PrintDenyList()
    local spells = { }
    for spellID in pairs(LBA.db.profile.denySpells) do
        local spell = Spell:CreateFromSpellID(spellID)
        if not spell:IsSpellEmpty() then
            spell:ContinueOnSpellLoad(function () table.insert(spells, spell) end)
        end
    end
    table.sort(spells, function (a, b) return a:GetSpellName() < b:GetSpellName() end)
    printf("不顯示時間的技能清單:")
    for i, spell in ipairs(spells) do
        printf("%3d. %s (%d)", i, spell:GetSpellName() or "?", spell:GetSpellID())
    end
end

local function DenyCommand(argstr)
    local _, cmd, spell = strsplit(" ", argstr, 3)
    if cmd == 'list' then
        PrintDenyList()
    elseif cmd == 'default' then
        LBA.DefaultDenyList()
    elseif cmd == 'wipe' then
        LBA.WipeDenyList()
    elseif cmd == 'add' and spell then
        local id = select(7, GetSpellInfo(spell))
        if id then
            LBA.AddDenySpell(id)
        else
            printf("錯誤: 未知的法術: " .. spell)
        end
    elseif cmd == 'remove' and spell then
        local id = select(7, GetSpellInfo(spell))
        if id then
            LBA.RemoveDenySpell(id)
        else
            printf("錯誤: 未知的法術: " .. spell)
        end
    else
        PrintDenyUsage()
    end
    return true
end

local function SlashCommand(argstr)
    local args = { strsplit(" ", argstr) }
    local cmd = table.remove(args, 1)
    local n = cmd:len()

    if cmd == '' then
        PrintOptions()
    elseif cmd == ('options'):sub(1,n) then
        LBA.OpenOptions()
    elseif cmd:lower() == 'stacks' and #args == 1 then
        LBA.SetOption('showStacks', args[1])
    elseif cmd:lower() == 'timers' and #args == 1 then
        LBA.SetOption('showTimers', args[1])
    elseif cmd:lower() == 'colortimers' and #args == 1 then
        LBA.SetOption('colorTimers', args[1])
    elseif cmd:lower() == 'decimaltimers' and #args == 1 then
        LBA.SetOption('decimalTimers', args[1])
    elseif cmd:lower() == 'font' and #args >= 1 then
        SetFont(args)
    elseif cmd:lower() == 'aura' then
        AuraCommand(argstr)
    elseif cmd:lower() == 'deny' then
        DenyCommand(argstr)
	elseif cmd:lower() == 'dump' then
        LiteButtonAurasController:DumpAllOverlays()
    else
        PrintUsage()
    end
    return true
end

function LBA.SetupSlashCommand()
    SlashCmdList['LiteButtonAuras'] = SlashCommand
    _G.SLASH_LiteButtonAuras1 = "/litebuttonauras"
    _G.SLASH_LiteButtonAuras1 = "/lba"
end
