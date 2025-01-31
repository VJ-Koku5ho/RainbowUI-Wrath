local isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
local isBCC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)
local catID
if isBCC or isClassic then
	catID = 3
else--retail or wrath classic and later
	catID = 2
end
local mod	= DBM:NewMod("AQ20Trash", "DBM-Raids-Vanilla", catID)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240108061725")
if not mod:IsClassic() then
	mod:SetModelID(15741)-- Qiraji Gladiator
end
mod:SetMinSyncRevision(20200710000000)--2020, 7, 10

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 22997 25698 26079",
	"SPELL_AURA_REMOVED 22997",
	"SPELL_MISSED"
)

mod:AddRangeFrameOption(10, 22997)

--local eventsRegistered = false

do-- Anubisath Plague/Explode - keep in sync - AQ40/AQ40Trash.lua AQ20/AQ20Trash.lua
	local warnPlague                    = mod:NewTargetAnnounce(22997, 2)
	local warnCauseInsanity             = mod:NewTargetNoFilterAnnounce(26079, 2)

	local specWarnPlague                = mod:NewSpecialWarningMoveAway(22997, nil, nil, nil, 1, 2)
	local yellPlague                    = mod:NewYell(22997)
	local specWarnExplode               = mod:NewSpecialWarningRun(25698, "Melee", nil, 3, 4, 2)

	-- aura applied didn't seem to catch the reflects and other buffs
	function mod:SPELL_AURA_APPLIED(args)
		if args:IsSpell(22997) and not self:IsTrivial() then
			if args:IsPlayer() then
				specWarnPlague:Show()
				specWarnPlague:Play("runout")
				yellPlague:Yell()
				if self.Options.RangeFrame then
					DBM.RangeCheck:Show(10)
				end
			else
				warnPlague:Show(args.destName)
			end
		elseif args:IsSpell(25698) and not self:IsTrivial() then
			specWarnExplode:Show()
			specWarnExplode:Play("justrun")
		elseif args:IsSpell(26079) then
			warnCauseInsanity:CombinedShow(0.75, args.destName)
		end
	end

	function mod:SPELL_AURA_REMOVED(args)
		if args:IsSpell(22997) then
			if args:IsPlayer() and self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

do-- Anubisath Reflect - keep in sync - AQ40/AQ40Trash.lua AQ20/AQ20Trash.lua
	local specWarnShadowFrostReflect    = mod:NewSpecialWarningReflect(19595, nil, nil, nil, 1, 2)
	local specWarnFireArcaneReflect     = mod:NewSpecialWarningReflect(13022, nil, nil, nil, 1, 2)

	-- todo: thorns, shadow storm

	local playerGUID = UnitGUID("player")
	function mod:SPELL_MISSED(sourceGUID, _, _, _, destGUID, destName, _, _, _, _, spellSchool, missType)
		if (missType == "REFLECT" or missType == "DEFLECT") and sourceGUID == playerGUID and not self:IsTrivial() then
			if (spellSchool == 32 or spellSchool == 16) and self:AntiSpam(3, 1) then
				specWarnShadowFrostReflect:Show(destName)
				specWarnShadowFrostReflect:Play("stopattack")
			elseif (spellSchool == 4 or spellSchool == 64) and self:AntiSpam(3, 2) then
				specWarnFireArcaneReflect:Show(destName)
				specWarnFireArcaneReflect:Play("stopattack")
			end
		end
--		if eventsRegistered then-- for AQ40 timer
--			self:SPELL_DAMAGE(nil, nil, nil, nil, destGUID)
--		end
	end
end
