local mod	= DBM:NewMod("Malacrass", "DBM-Raids-BC", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240108061725")
mod:SetCreatureID(24239)
mod:SetEncounterID(1193, 2486)
mod:SetZone()

mod:RegisterCombat("combat_yell", L.YellPull)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 43501 43421 43442 43440 43429",
	"SPELL_CAST_START 43548 43451 43431",
	"SPELL_CAST_SUCCESS 43383 43429",
	"SPELL_SUMMON 43436"
)

local warnSiphon			= mod:NewTargetNoFilterAnnounce(43501, 3)
local warnBoltSoon			= mod:NewPreWarnAnnounce(43383, 5, 3)
local warnHealingWave		= mod:NewCastAnnounce(43548, 3)
local warnHolyLight			= mod:NewCastAnnounce(43451, 3)
local warnFlashHeal			= mod:NewCastAnnounce(43431, 3)
local warnLifebloom			= mod:NewTargetNoFilterAnnounce(43421, 3)
local warnConsecration		= mod:NewSpellAnnounce(43429, 3)
local warnWhirlwind			= mod:NewSpellAnnounce(43442, 4)

local specWarnBolt			= mod:NewSpecialWarningSpell(43383, nil, nil, nil, 2, 2)
local specWarnHealingWave	= mod:NewSpecialWarningInterrupt(43548, "HasInterrupt", nil, nil, 1, 2)
local specWarnHolyLight		= mod:NewSpecialWarningInterrupt(43451, "HasInterrupt", nil, nil, 1, 2)
local specWarnFlashHeal		= mod:NewSpecialWarningInterrupt(43431, "HasInterrupt", nil, nil, 1, 2)
local specWarnLifebloom		= mod:NewSpecialWarningDispel(43421, "MagicDispeller", nil, nil, 1, 2)
local specWarnTotem			= mod:NewSpecialWarningSwitch(43436, "Dps", nil, nil, 1, 2)
local specWarnGTFO			= mod:NewSpecialWarningGTFO(43429, nil, nil, nil, 8, 2)

local timerSiphon			= mod:NewTargetTimer(30, 43501, nil, nil, nil, 6)
local timerBoltCD			= mod:NewCDTimer(41, 43383, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerBolt				= mod:NewCastTimer(10, 43383, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerConsecration		= mod:NewBuffActiveTimer(20, 43429, nil, false, nil, 3)

function mod:OnCombatStart(delay)
	timerBoltCD:Start(30)
	warnBoltSoon:Schedule(25)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(43501) then
		warnSiphon:Show(args.destName)
		timerSiphon:Show(args.destName)
	elseif args:IsSpellID(43421) and not args:IsDestTypePlayer() then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnLifebloom:Show(args.destName)
			specWarnLifebloom:Play("dispelboss")
		else
			warnLifebloom:Show(args.destName)
		end
	elseif args:IsSpellID(43440, 43429) and args:IsPlayer() then--Rain of Fire, Consecration
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif args.spellId == 43442 then
		warnWhirlwind:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(43548) then
		if self.Options.SpecWarn43548interrupt and self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHealingWave:Show(args.sourceName)
			specWarnHealingWave:Play("kickcast")
		else
			warnHealingWave:Show()
		end
	elseif args:IsSpellID(43451) then
		if self.Options.SpecWarn43451interrupt and self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHolyLight:Show(args.sourceName)
			specWarnHolyLight:Play("kickcast")
		else
			warnHolyLight:Show()
		end
	elseif args:IsSpellID(43431) then
		if self.Options.SpecWarn43431interrupt and self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnFlashHeal:Show(args.sourceName)
			specWarnFlashHeal:Play("kickcast")
		else
			warnFlashHeal:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(43383) then
		specWarnBolt:Show()
		specWarnBolt:Play("aesoon")
		warnBoltSoon:Schedule(35)
		timerBolt:Start()
		timerBoltCD:Start()
	elseif args:IsSpellID(43429) then
		warnConsecration:Show()
		timerConsecration:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(43436) then
		specWarnTotem:Show()
		specWarnTotem:Play("attacktotem")
	end
end
