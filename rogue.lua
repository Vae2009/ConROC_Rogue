local printTalentsMode = false

-- Slash command for printing talent tree with talent names and ID numbers
SLASH_CONROCPRINTTALENTS1 = "/ConROCPT"
SlashCmdList["CONROCPRINTTALENTS"] = function()
    printTalentsMode = not printTalentsMode
    ConROC:PopulateTalentIDs()
end

ConROC.Rogue = {}

local ConROC_Rogue, ids = ...;
local optionMaxIds = ...;
local _tickerVar = 10;
local _mhP = nil;
local _ohP = nil;
local _mhNameMax, _mhTexture;
local _ohNameMax, _ohTexture;
local _mhAlpha = 1;
local _ohAlpha = 1;
local currentSpecName;
local currentSpecID;
local plvl = UnitLevel("player")

function ConROC:EnableDefenseModule()
    self.NextDef = ConROC.Rogue.Defense
end
function ConROC:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
    if unitID == "player" then
        self.lastSpellId = spellID
    end
end

function ConROC:PopulateTalentIDs()
    local numTabs = GetNumTalentTabs()
    
    for tabIndex = 1, numTabs do
        local tabName = GetTalentTabInfo(tabIndex)
        tabName = string.gsub(tabName, "[^%w]", "") .. "_Talent" -- Remove spaces from tab name
        print("ids."..tabName.." = {")
        local numTalents = GetNumTalents(tabIndex)

        for talentIndex = 1, numTalents do
            local name, _, _, _, _ = GetTalentInfo(tabIndex, talentIndex)

            if name then
                local talentID = string.gsub(name, "[^%w]", "") -- Remove spaces from talent name
                    print(talentID .." = ", talentIndex ..",")
            end
        end
        print("}")
    end
end

local Racial, Spec, Ass_Ability, Ass_Talent, Com_Ability, Com_Talent, Sub_Ability, Sub_Talent, Poisons, Player_Buff, Player_Debuff, Target_Debuff = ids.Racial, ids.Spec, ids.Ass_Ability, ids.Assassination_Talent, ids.Com_Ability, ids.Combat_Talent, ids.Sub_Ability, ids.Subtlety_Talent, ids.Poisons, ids.Player_Buff, ids.Player_Debuff, ids.Target_Debuff

function ConROC:SpecUpdate()
    currentSpecName = ConROC:currentSpec()
    currentSpecID = ConROC:currentSpec("ID")
    if currentSpecName then
       ConROC:Print(self.Colors.Info .. "Current spec:", self.Colors.Success ..  currentSpecName)
    else
       ConROC:Print(self.Colors.Error .. "You do not currently have a spec.")
    end
end
ConROC:SpecUpdate()
--Ranks
--Assassination
local _Ambush = Ass_Ability.AmbushRank1
local _Eviscerate = Ass_Ability.EviscerateRank1
local _ExposeArmor = Ass_Ability.ExposeArmorRank1
local _Garrote = Ass_Ability.GarroteRank1
local _KidneyShot = Ass_Ability.KidneyShotRank1
local _Rupture = Ass_Ability.RuptureRank1
local _SliceandDice = Ass_Ability.SliceandDiceRank1
local _CheapShot = Ass_Ability.CheapShot
--Combat
local _Backstab = Com_Ability.BackstabRank1
local _BladeFlurry = Com_Ability.BladeFlurry
local _Evasion = Com_Ability.Evasion
local _Feint = Com_Ability.FeintRank1
local _Gouge = Com_Ability.GougeRank1
local _Kick = Com_Ability.KickRank1
local _SinisterStrike = Com_Ability.SinisterStrikeRank1
local _Sprint = Com_Ability.SprintRank1
--Subtley
local _GhostlyStrike = Sub_Ability.GhostlyStrike
local _Hemorrhage = Sub_Ability.HemorrhageRank1
local _Sap = Sub_Ability.SapRank1
local _Stealth = Sub_Ability.StealthRank1
local _Vanish = Sub_Ability.VanishRank1
local _Blind = Sub_Ability.Blind
--Poisons
local _InstantPoison = Poisons.InstantPoisonRank1
local _CripplingPoison = Poisons.CripplingPoisonRank1
local _DeadlyPoison = Poisons.DeadlyPoisonRank1
local _MindnumbingPoison = Poisons.MindnumbingPoisonRank1
local _WoundPoison = Poisons.WoundPoisonRank1
--Runes
local _Shadowstrike = ids.Runes.Shadowstrike
local _SaberSlash = ids.Runes.SaberSlash
local _Envenom = ids.Runes.Envenom
local _Mutilate = ids.Runes.Mutilate
local _Tease = ids.Runes.Tease
local _QuickDraw = ids.Runes.QuickDraw
local _MainGauche = ids.Runes.MainGauche
local _BladeDance = ids.Runes.BladeDance

function ConROC:UpdateSpellID()
--Ranks
if IsSpellKnown(Ass_Ability.AmbushRank6) then _Ambush = Ass_Ability.AmbushRank6
elseif IsSpellKnown(Ass_Ability.AmbushRank5) then _Ambush = Ass_Ability.AmbushRank5
elseif IsSpellKnown(Ass_Ability.AmbushRank4) then _Ambush = Ass_Ability.AmbushRank4
elseif IsSpellKnown(Ass_Ability.AmbushRank3) then _Ambush = Ass_Ability.AmbushRank3
elseif IsSpellKnown(Ass_Ability.AmbushRank2) then _Ambush = Ass_Ability.AmbushRank2 end

if IsSpellKnown(Ass_Ability.EviscerateRank8) then _Eviscerate = Ass_Ability.EviscerateRank8
elseif IsSpellKnown(Ass_Ability.EviscerateRank7) then _Eviscerate = Ass_Ability.EviscerateRank7
elseif IsSpellKnown(Ass_Ability.EviscerateRank6) then _Eviscerate = Ass_Ability.EviscerateRank6
elseif IsSpellKnown(Ass_Ability.EviscerateRank5) then _Eviscerate = Ass_Ability.EviscerateRank5
elseif IsSpellKnown(Ass_Ability.EviscerateRank4) then _Eviscerate = Ass_Ability.EviscerateRank4
elseif IsSpellKnown(Ass_Ability.EviscerateRank3) then _Eviscerate = Ass_Ability.EviscerateRank3
elseif IsSpellKnown(Ass_Ability.EviscerateRank2) then _Eviscerate = Ass_Ability.EviscerateRank2 end

if IsSpellKnown(Ass_Ability.ExposeArmorRank5) then _ExposeArmor = Ass_Ability.ExposeArmorRank5;
elseif IsSpellKnown(Ass_Ability.ExposeArmorRank4) then _ExposeArmor = Ass_Ability.ExposeArmorRank4;
elseif IsSpellKnown(Ass_Ability.ExposeArmorRank3) then _ExposeArmor = Ass_Ability.ExposeArmorRank3;
elseif IsSpellKnown(Ass_Ability.ExposeArmorRank2) then _ExposeArmor = Ass_Ability.ExposeArmorRank2; end

if IsSpellKnown(Ass_Ability.GarroteRank6) then _Garrote = Ass_Ability.GarroteRank6
elseif IsSpellKnown(Ass_Ability.GarroteRank5) then _Garrote = Ass_Ability.GarroteRank5
elseif IsSpellKnown(Ass_Ability.GarroteRank4) then _Garrote = Ass_Ability.GarroteRank4
elseif IsSpellKnown(Ass_Ability.GarroteRank3) then _Garrote = Ass_Ability.GarroteRank3
elseif IsSpellKnown(Ass_Ability.GarroteRank2) then _Garrote = Ass_Ability.GarroteRank2 end

if IsSpellKnown(Ass_Ability.KidneyShotRank2) then _KidneyShot = Ass_Ability.KidneyShotRank2 end

if IsSpellKnown(Ass_Ability.RuptureRank6) then _Rupture = Ass_Ability.RuptureRank6
elseif IsSpellKnown(Ass_Ability.RuptureRank5) then _Rupture = Ass_Ability.RuptureRank5
elseif IsSpellKnown(Ass_Ability.RuptureRank4) then _Rupture = Ass_Ability.RuptureRank4
elseif IsSpellKnown(Ass_Ability.RuptureRank3) then _Rupture = Ass_Ability.RuptureRank3
elseif IsSpellKnown(Ass_Ability.RuptureRank2) then _Rupture = Ass_Ability.RuptureRank2 end

if IsSpellKnown(Ass_Ability.SliceandDiceRank2) then _SliceandDice = Ass_Ability.SliceandDiceRank2 end

if IsSpellKnown(Com_Ability.BackstabRank8) then _Backstab = Com_Ability.BackstabRank8
elseif IsSpellKnown(Com_Ability.BackstabRank7) then _Backstab = Com_Ability.BackstabRank7
elseif IsSpellKnown(Com_Ability.BackstabRank6) then _Backstab = Com_Ability.BackstabRank6
elseif IsSpellKnown(Com_Ability.BackstabRank5) then _Backstab = Com_Ability.BackstabRank5
elseif IsSpellKnown(Com_Ability.BackstabRank4) then _Backstab = Com_Ability.BackstabRank4
elseif IsSpellKnown(Com_Ability.BackstabRank3) then _Backstab = Com_Ability.BackstabRank3
elseif IsSpellKnown(Com_Ability.BackstabRank2) then _Backstab = Com_Ability.BackstabRank2 end

if IsSpellKnown(Com_Ability.FeintRank4) then _Feint = Com_Ability.FeintRank4
elseif IsSpellKnown(Com_Ability.FeintRank3) then _Feint = Com_Ability.FeintRank3
elseif IsSpellKnown(Com_Ability.FeintRank2) then _Feint = Com_Ability.FeintRank2 end

if IsSpellKnown(Com_Ability.GougeRank5) then _Gouge = Com_Ability.GougeRank5;
elseif IsSpellKnown(Com_Ability.GougeRank4) then _Gouge = Com_Ability.GougeRank4;
elseif IsSpellKnown(Com_Ability.GougeRank3) then _Gouge = Com_Ability.GougeRank3;
elseif IsSpellKnown(Com_Ability.GougeRank2) then _Gouge = Com_Ability.GougeRank2; end

if IsSpellKnown(Com_Ability.KickRank4) then _Kick = Com_Ability.KickRank4;
elseif IsSpellKnown(Com_Ability.KickRank3) then _Kick = Com_Ability.KickRank3;
elseif IsSpellKnown(Com_Ability.KickRank2) then _Kick = Com_Ability.KickRank2; end

if IsSpellKnown(Com_Ability.SinisterStrikeRank8) then _SinisterStrike = Com_Ability.SinisterStrikeRank8
elseif IsSpellKnown(Com_Ability.SinisterStrikeRank7) then _SinisterStrike = Com_Ability.SinisterStrikeRank7
elseif IsSpellKnown(Com_Ability.SinisterStrikeRank6) then _SinisterStrike = Com_Ability.SinisterStrikeRank6
elseif IsSpellKnown(Com_Ability.SinisterStrikeRank5) then _SinisterStrike = Com_Ability.SinisterStrikeRank5
elseif IsSpellKnown(Com_Ability.SinisterStrikeRank4) then _SinisterStrike = Com_Ability.SinisterStrikeRank4
elseif IsSpellKnown(Com_Ability.SinisterStrikeRank3) then _SinisterStrike = Com_Ability.SinisterStrikeRank3
elseif IsSpellKnown(Com_Ability.SinisterStrikeRank2) then _SinisterStrike = Com_Ability.SinisterStrikeRank2 end

if IsSpellKnown(Com_Ability.SprintRank3) then _Sprint = Com_Ability.SprintRank3
elseif IsSpellKnown(Com_Ability.SprintRank2) then _Sprint = Com_Ability.SprintRank2 end

if IsSpellKnown(Sub_Ability.HemorrhageRank3) then _Hemorrhage = Sub_Ability.HemorrhageRank3
elseif IsSpellKnown(Sub_Ability.HemorrhageRank2) then _Hemorrhage = Sub_Ability.HemorrhageRank2 end

if IsSpellKnown(Sub_Ability.SapRank3) then _Sap = Sub_Ability.SapRank3
elseif IsSpellKnown(Sub_Ability.SapRank2) then _Sap = Sub_Ability.SapRank2 end

if IsSpellKnown(Sub_Ability.VanishRank2) then _Vanish = Sub_Ability.VanishRank2 end

if plvl >= 50 then
    _CripplingPoison = Poisons.CripplingPoisonRank2
end

if plvl >= 54 then
    _DeadlyPoison = Poisons.DeadlyPoisonRank4
elseif plvl >= 46 then
    _DeadlyPoison = Poisons.DeadlyPoisonRank3
elseif plvl >= 38 then
    _DeadlyPoison = Poisons.DeadlyPoisonRank2
end

if plvl >= 60 then
    _InstantPoison = Poisons.InstantPoisonRank6
elseif plvl >= 52 then
    _InstantPoison = Poisons.InstantPoisonRank5
elseif plvl >= 44 then
    _InstantPoison = Poisons.InstantPoisonRank4
elseif plvl >= 36 then
    _InstantPoison = Poisons.InstantPoisonRank3
elseif plvl >= 28 then
    _InstantPoison = Poisons.InstantPoisonRank2
end

if plvl >= 52 then
    _MindnumbingPoison = Poisons.MindnumbingPoisonRank3
elseif plvl >= 38 then
    _MindnumbingPoison = Poisons.MindnumbingPoisonRank2
end

if plvl >= 56 then
    _WoundPoison = Poisons.WoundPoisonRank4
elseif plvl >= 48 then
    _WoundPoison = Poisons.WoundPoisonRank3
elseif plvl >= 40 then
    _WoundPoison = Poisons.WoundPoisonRank2
end

--OptionIDs defaults
ids.optionMaxIds = {
    InstantPoison = _InstantPoison,
    CripplingPoison = _CripplingPoison,
    DeadlyPoison = _DeadlyPoison,
    MindnumbingPoison = _MindnumbingPoison,
    WoundPoison = _WoundPoison,
    SliceandDice = _SliceandDice,
    Garrote = _Garrote,
    ExposeArmor = _ExposeArmor,
    Rupture = _Rupture,
    GhostlyStrike = _GhostlyStrike,
    Hemorrhage = _Hemorrhage,
    BladeFlurry = _BladeFlurry,
    Gouge = _Gouge,
    CheapShot = _CheapShot,
    KidneyShot = _KidneyShot,
    Blind = _Blind
}
end
ConROC:UpdateSpellID()

function ConROC:EnableRotationModule()
    self.Description = "Rogue"
    self.NextSpell = ConROC.Rogue.Damage

    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
    self:RegisterEvent("PLAYER_TALENT_UPDATE");
    self.lastSpellId = 0

    ConROC:SpellmenuClass()
    --  ConROCSpellmenuFrame:Hide();
end

function ConROC:PLAYER_TALENT_UPDATE()
    ConROC:SpecUpdate();
    ConROC:closeSpellmenu();
end

function ConROC.Rogue.Damage(_, timeShift, currentSpell, gcd)
ConROC:UpdateSpellID()
    --Character
    plvl = UnitLevel("player")

    --Racials

    --Resources
    local energy = UnitPower("player", Enum.PowerType.Energy)
    local energyMax = UnitPowerMax("player", Enum.PowerType.Energy)
    local energyPercent = math.max(0, energy) / math.max(1, energyMax) * 100
    local combo = UnitPower("player", Enum.PowerType.ComboPoints)
    local comboMax = UnitPowerMax("player", Enum.PowerType.ComboPoints)

    
--print("ids.optionMaxIds.MindnumbingPoison",ids.optionMaxIds.MindnumbingPoison);
--print("ids.optionMaxIds.MindnumbingPoison.id",ids.optionMaxIds.MindnumbingPoison.id);
--print("ids.optionMaxIds.MindnumbingPoison.name",ids.optionMaxIds.MindnumbingPoison.name);
    --Abilities
    local ambushRDY = ConROC:AbilityReady(_Ambush, timeShift);
    local cShotRDY = ConROC:AbilityReady(Ass_Ability.CheapShot, timeShift);
    local kShotRDY = ConROC:AbilityReady(_KidneyShot, timeShift);
    local evisRDY = ConROC:AbilityReady(_Eviscerate, timeShift);
    local cBloodRDY = ConROC:AbilityReady(Ass_Ability.ColdBlood, timeShift);
    local cBloodBUFF = ConROC:Buff(Ass_Ability.ColdBlood, timeShift);
    local exArmorRDY = ConROC:AbilityReady(_ExposeArmor, timeShift);
    local exArmorDEBUFF = ConROC:TargetDebuff(_ExposeArmor, timeShift);
    local garRDY = ConROC:AbilityReady(_Garrote, timeShift);
    local garDEBUFF, _, garDUR = ConROC:TargetDebuff(_Garrote, timeShift);
    local rupRDY = ConROC:AbilityReady(_Rupture, timeShift);
    local rupDEBUFF, _, rupDUR = ConROC:TargetDebuff(_Rupture, timeShift);
    local sndRDY = ConROC:AbilityReady(_SliceandDice, timeShift);
    local sndBUFF, _, sndDUR = ConROC:Buff(_SliceandDice, timeShift);
    local aRushRDY = ConROC:AbilityReady(Com_Ability.AdrenalineRush, timeShift);
    local aRushBUFF = ConROC:Buff(Com_Ability.AdrenalineRush, timeShift);
    local bStabRDY = ConROC:AbilityReady(_Backstab, timeShift);
    local bFlurryRDY = ConROC:AbilityReady(_BladeFlurry, timeShift);
    local gougeRDY = ConROC:AbilityReady(_Gouge, timeShift);
    local kickRDY = ConROC:AbilityReady(_Kick, timeShift);
    local sStrikeRDY = ConROC:AbilityReady(_SinisterStrike, timeShift);
    local sprintRDY = ConROC:AbilityReady(_Sprint, timeShift);
    local gStrikeRDY = ConROC:AbilityReady(_GhostlyStrike, timeShift);
    local hemoRDY = ConROC:AbilityReady(_Hemorrhage, timeShift);
    local hemoDEBUFF = ConROC:TargetDebuff(_Hemorrhage, timeShift);
    local premRDY = ConROC:AbilityReady(Sub_Ability.Premeditation, timeShift);
    local prepRDY = ConROC:AbilityReady(Sub_Ability.Preparation, timeShift);
    local vanishRDY = ConROC:AbilityReady(_Vanish, timeShift);
    local ripRDY = ConROC:AbilityReady(Com_Ability.Riposte, timeShift);
    local blindRDY = ConROC:AbilityReady(Sub_Ability.Blind, timeShift);
    --Runes
    local ShadowstrikeRDY = ConROC:AbilityReady(_Shadowstrike, timeShift);
    local SaberSlashRDY = ConROC:AbilityReady(_SaberSlash, timeShift);
    local SaberSlashDEBUFF = ConROC:TargetDebuff(ids.Target_Debuff.SaberSlash, timeShift);
    local MutilateRDY = ConROC:AbilityReady(_Mutilate, timeShift);
    local EnvenomRDY = ConROC:AbilityReady(_Envenom, timeShift);
    local TeaseRDY = ConROC:AbilityReady(_Tease, timeShift);
    local QuickDrawRDY = ConROC:AbilityReady(_QuickDraw, timeShift);
    local MainGaucheRDY = ConROC:AbilityReady(_MainGauche, timeShift);
        local MainGaucheBUFF = ConROC:Buff(_MainGauche, timeShift);
    local bDanceRDY = ConROC:AbilityReady(_BladeDance, timeShift);
        local bDanceBUFF = ConROC:Buff(_BladeDance, timeShift);

    --Conditions
    local incombat = UnitAffectingCombat("player")
    local stealthed = IsStealthed()
    local resting = IsResting()
    local mounted = IsMounted()
    local targetPh = ConROC:PercentHealth("target")
    --local inMelee = CheckInteractDistance("target", 3)
    local inClose = IsSpellInRange(select(1,GetSpellInfo(_SinisterStrike)), "target")
    local hasDagger = ConROC:Equipped("Daggers", "MAINHANDSLOT")
    local dualWielding = ConROC:Equipped("wpn", "MAINHANDSLOT") and ConROC:Equipped("wpn", "SECONDARYHANDSLOT")
    local tarInMelee = ConROC:Targets(_SinisterStrike)
    local poisonMH, _, _, _, poisonOH = GetWeaponEnchantInfo()
    local mhExp = 0
    local ohExp = 0

    --Indicators
    ConROC:AbilityBurst(Com_Ability.AdrenalineRush, aRushRDY and incombat and energyPercent <= 40)
    ConROC:AbilityBurst(Ass_Ability.ColdBlood, cBloodRDY and ((stealthed and hasDagger) or combo == comboMax))
    --  ConROC:AbilityBurst(Sub_Ability.Preparation, prepRDY and incombat);
    ConROC:AbilityBurst(_Gouge, ConROC:CheckBox(ConROC_SM_Stun_Gouge) and gougeRDY and not rupDEBUFF and not garDEBUFF and incombat and ConROC:TarYou())
    ConROC:AbilityBurst(Sub_Ability.Blind, ConROC:CheckBox(ConROC_SM_Stun_Blind) and blindRDY and not rupDEBUFF and not garDEBUFF and incombat and ConROC:TarYou())

    ConROC:AbilityInterrupt(_Kick, ConROC:Interrupt() and kickRDY)

    --Warnings
    _tickerVar = _tickerVar + 1
    local hasMainHandEnchant,
        mainHandExpiration,
        mainHandCharges,
        mainHandEnchantID,
        hasOffHandEnchant,
        offHandExpiration,
        offHandCharges,
        offHandEnchantId = GetWeaponEnchantInfo()
    if mainHandExpiration then
        mhExp = mainHandExpiration / 1000
    else
        mhExp = 0
    end
    if offHandExpiration then
        ohExp = offHandExpiration / 1000
    else
        ohExp = 0
    end

    if _tickerVar >= 1 then
        if not mounted and (not resting or stealthed) then
            if ConROC:CheckBox(ConROC_SM_PoisonMH_Instant) then
                if ids.ActivePoison[mainHandEnchantID] == ids.optionMaxIds.InstantPoison.name then
                    _mhAlpha = .5
                end
                _mhP = ids.optionMaxIds.InstantPoison
                _mhNameMax = ids.optionMaxIds.InstantPoison.name
                local pName = Poisons.InstantPoisonRank1.name
                local pCount = GetItemCount(_mhP.id)
                if ids.ActivePoison[mainHandEnchantID] ~= _mhNameMax then
                    _mhAlpha = 1
                    poisonErrorMessage(pCount, pName, _mhNameMax, "mainhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonMH_Crippling) then
                if ids.ActivePoison[mainHandEnchantID] == ids.optionMaxIds.CripplingPoison.name then
                    _mhAlpha = .5
                end
                _mhP = ids.optionMaxIds.CripplingPoison
                _mhNameMax = ids.optionMaxIds.CripplingPoison.name
                local pName = Poisons.CripplingPoisonRank1.name
                local pCount = GetItemCount(_mhP.id)
                if ids.ActivePoison[mainHandEnchantID] ~= _mhNameMax then
                    _mhAlpha = 1
                    poisonErrorMessage(pCount, pName, _mhNameMax, "mainhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonMH_Mindnumbing) then
                if ids.ActivePoison[mainHandEnchantID] == ids.optionMaxIds.MindnumbingPoison.name then
                    _mhAlpha = .5
                end
                _mhP = ids.optionMaxIds.MindnumbingPoison
                _mhNameMax = ids.optionMaxIds.MindnumbingPoison.name
                local pName = Poisons.MindnumbingPoisonRank1.name
                local pCount = GetItemCount(_mhP.id)
                if ids.ActivePoison[mainHandEnchantID] ~= _mhNameMax then
                    _mhAlpha = 1
                    poisonErrorMessage(pCount, pName, _mhNameMax, "mainhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonMH_Deadly) then
                if ids.ActivePoison[mainHandEnchantID] == ids.optionMaxIds.DeadlyPoison.name then
                    _mhAlpha = .5
                end
                _mhP = ids.optionMaxIds.DeadlyPoison
                _mhNameMax = ids.optionMaxIds.DeadlyPoison.name
                local pName = Poisons.DeadlyPoisonRank1.name
                local pCount = GetItemCount(_mhP.id)
                if ids.ActivePoison[mainHandEnchantID] ~= _mhNameMax then
                    _mhAlpha = 1
                    poisonErrorMessage(pCount, pName, _mhNameMax, "mainhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonMH_Wound) then
                if ids.ActivePoison[mainHandEnchantID] == ids.optionMaxIds.WoundPoison.name then
                    _mhAlpha = .5
                end
                _mhP = ids.optionMaxIds.WoundPoison
                _mhNameMax = ids.optionMaxIds.WoundPoison.name
                local pName = Poisons.WoundPoisonRank1.name
                local pCount = GetItemCount(_mhP.id)
                if ids.ActivePoison[mainHandEnchantID] ~= _mhNameMax then
                    _mhAlpha = 1
                    poisonErrorMessage(pCount, pName, _mhNameMax, "mainhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonMH_Anesthetic) then
                if ids.ActivePoison[mainHandEnchantID] == ids.optionMaxIds.AnestheticPoison.name then
                    _mhAlpha = .5
                end
                _mhP = ids.optionMaxIds.AnestheticPoison
                _mhNameMax = ids.optionMaxIds.AnestheticPoison.name
                local pName = Poisons.AnestheticPoisonRank1.name
                local pCount = GetItemCount(_mhP.id)
                if ids.ActivePoison[mainHandEnchantID] ~= _mhNameMax then
                    _mhAlpha = 1
                    poisonErrorMessage(pCount, pName, _mhNameMax, "mainhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonOH_Instant) then
                if ids.ActivePoison[offHandEnchantId] == ids.optionMaxIds.InstantPoison.name then
                    _ohAlpha = .5
                end
                _ohP = ids.optionMaxIds.InstantPoison
                _ohNameMax = ids.optionMaxIds.InstantPoison.name
                local pName = Poisons.InstantPoisonRank1.name
                local pCount = GetItemCount(_ohP.id)
                if ids.ActivePoison[offHandEnchantId] ~= _ohNameMax then
                    _ohAlpha = 1
                    poisonErrorMessage(pCount, pName, _ohNameMax, "offhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonOH_Crippling) then
                if ids.ActivePoison[offHandEnchantId] == ids.optionMaxIds.CripplingPoison.name then
                    _ohAlpha = .5
                end
                _ohP = ids.optionMaxIds.CripplingPoison
                _ohNameMax = ids.optionMaxIds.CripplingPoison.name
                local pName = Poisons.CripplingPoisonRank1.name
                local pCount = GetItemCount(_ohP.id)
                if ids.ActivePoison[offHandEnchantId] ~= _ohNameMax then
                    _ohAlpha = 1
                    poisonErrorMessage(pCount, pName, _ohNameMax, "offhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonOH_Mindnumbing) then
                if ids.ActivePoison[offHandEnchantId] == ids.optionMaxIds.MindnumbingPoison.name then
                    _ohAlpha = .5
                end
                _ohP = ids.optionMaxIds.MindnumbingPoison
                _ohNameMax = ids.optionMaxIds.MindnumbingPoison.name
                local pName = Poisons.MindnumbingPoisonRank1.name
                local pCount = GetItemCount(_ohP.id)
                if ids.ActivePoison[offHandEnchantId] ~= _ohNameMax then
                    _ohAlpha = 1
                    poisonErrorMessage(pCount, pName, _ohNameMax, "offhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonOH_Deadly) then
                if ids.ActivePoison[offHandEnchantId] == ids.optionMaxIds.DeadlyPoison.name then
                    _ohAlpha = .5
                end
                _ohP = ids.optionMaxIds.DeadlyPoison
                _ohNameMax = ids.optionMaxIds.DeadlyPoison.name
                local pName = Poisons.DeadlyPoisonRank1.name
                local pCount = GetItemCount(_ohP.id)
                if ids.ActivePoison[offHandEnchantId] ~= _ohNameMax then
                    _ohAlpha = 1
                    poisonErrorMessage(pCount, pName, _ohNameMax, "offhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonOH_Wound) then
                if ids.ActivePoison[offHandEnchantId] == ids.optionMaxIds.WoundPoison.name then
                    _ohAlpha = .5
                end
                _ohP = ids.optionMaxIds.WoundPoison
                _ohNameMax = ids.optionMaxIds.WoundPoison.name
                local pName = Poisons.WoundPoisonRank1.name
                local pCount = GetItemCount(_ohP.id)
                if ids.ActivePoison[offHandEnchantId] ~= _ohNameMax then
                    _ohAlpha = 1
                    poisonErrorMessage(pCount, pName, _ohNameMax, "offhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonOH_Anesthetic) then
                if ids.ActivePoison[offHandEnchantId] ~= ids.optionMaxIds.AnestheticPoison.name then
                    _ohAlpha = .5
                end
                _ohP = ids.optionMaxIds.AnestheticPoison
                _ohNameMax = ids.optionMaxIds.AnestheticPoison.name
                local pName = Poisons.AnestheticPoisonRank1.name
                local pCount = GetItemCount(_ohP.id)
                if ids.ActivePoison[offHandEnchantId] ~= _ohNameMax then
                    _ohAlpha = 1
                    poisonErrorMessage(pCount, pName, _ohNameMax, "offhand")
                end
            end
            if ConROC:CheckBox(ConROC_SM_PoisonMH_None) then
                _mhP = "none"
                _mhNameMax = false
            end
            if ConROC:CheckBox(ConROC_SM_PoisonOH_None) then
                _ohP = "none"
                _ohNameMax = false
            end
        end
        _tickerVar = 0

        if _mhP == nil then
            _mhP = "none"
        end
        if _ohP == nil then
            _ohp = "none"
        end

        if
            (ids.ActivePoison[mainHandEnchantID] ~= _mhNameMax or ids.ActivePoison[offHandEnchantId] ~= _ohNameMax) and
                (_mhP ~= "none" or _ohP ~= "none")
         then
            if not (resting or incombat or mounted) then
                --print("showing apply poison")
                ConROC:ApplyPoison(_mhP, _ohP)
                if not ConROCApplyPoisonFrame:IsShown() then
                    ConROCApplyPoisonFrame:Show()
                end
            end
        end
        if ConROCApplyPoisonFrame:IsShown() then
            if
                (resting or mounted and not incombat) or (_mhP == "none" and _ohP == "none") or
                    (ids.ActivePoison[mainHandEnchantID] == _mhNameMax and
                        ids.ActivePoison[offHandEnchantId] == _ohNameMax) or
                    (ids.ActivePoison[mainHandEnchantID] == _mhNameMax and _ohP == "none") or
                    (ids.ActivePoison[offHandEnchantId] == _ohNameMax and _mhP == "none")
             then
                ConROCApplyPoisonFrame:Hide()
            end
        end
    end

    --Rotations
    if ConROC.Seasons.IsSoD then --DPS rotation for SoD
    --print("IsSpellKnown - Slaugther from the shadows)",IsSpellKnownOrOverridesKnown(424925))
        if ConROC:CheckBox(ConROC_SM_Role_Tank) then
            if stealthed then
                if ConROC:CheckBox(ConROC_SM_Debuff_Garrote) and inClose == 1 and garRDY and not garDEBUFF then
                    return _Garrote;
                end
                if ambushRDY and hasDagger then
                    return _Ambush;
                end
                if bStabRDY and hasDagger and not ConROC:TarYou() then
                    return _Backstab;
                end
                if ShadowstrikeRDY and inClose ~= 1 and not (ambushRDY and bStabRDY) then
                    return _Shadowstrike
                end
                return nil;
            else
                if ripRDY then
                    return Com_Ability.Riposte;
                end
                if MainGaucheRDY and not MainGaucheBUFF then
                    return _MainGauche;
                end
                if sStrikeRDY and (combo < 1) then
                    return _SinisterStrike;
                end
                if bDanceRDY and not bDanceBUFF then
                    return _BladeDance;
                end
                if sStrikeRDY and not combo ~= comboMax then
                    return _SinisterStrike;
                end
                if bDanceRDY and not bDanceBUFF then
                    return _BladeDance;
                end
                if sndRDY and not sndBUFF then
                    return _SliceandDice
                end
            end
            return nil
        end
        if plvl < 10 or not currentSpecID then
            if stealthed then
                if ShadowstrikeRDY and inClose ~= 1 and not (ambushRDY and bStabRDY) then
                    return _Shadowstrike
                end
                if premRDY then
                    return Sub_Ability.Premeditation;
                end

                if ConROC:CheckBox(ConROC_SM_Stun_CheapShot) and cShotRDY and not cBloodBUFF then
                    return Ass_Ability.CheapShot;
                end
                
                if ambushRDY and hasDagger then
                    return _Ambush;
                end
                
                if ConROC:CheckBox(ConROC_SM_Debuff_Garrote) and garRDY and not garDEBUFF then
                    return _Garrote;
                end

                if bStabRDY and hasDagger and not ConROC:TarYou() then
                    return _Backstab;
                end
            
                if sStrikeRDY and not hasDagger then
                    return _SinisterStrike;
                end
            end

            if ripRDY then
                return Com_Ability.Riposte;
            end

            if SaberSlashRDY and combo ~= comboMax then
                return _SaberSlash
            end
            if MutilateRDY and combo ~= comboMax then
                return _Mutilate
            end
            
            if ConROC:CheckBox(ConROC_SM_Debuff_SliceandDice) and sndRDY and ((combo >= 1 and not sndBUFF) or (combo == comboMax and ((sndDUR <= 10 and not aRushBUFF) or (aRushBUFF and sndDUR <= 5)))) then
                return _SliceandDice;
            end

            if EnvenomRDY and sndBUFF and combo == comboMax then
                return _Envenom
            end

            if ConROC:CheckBox(ConROC_SM_Stun_KidneyShot) and kShotRDY and combo == comboMax then
                return _KidneyShot;
            end
            
            if ConROC:CheckBox(ConROC_SM_Debuff_SliceandDice) and sndRDY and ((combo >= 1 and not sndBUFF) or (combo == comboMax and ((sndDUR <= 10 and not aRushBUFF) or (aRushBUFF and sndDUR <= 5)))) then
                return _SliceandDice;
            end
            
            if ConROC:CheckBox(ConROC_SM_Debuff_ExposeArmor) and exArmorRDY and not exArmorDEBUFF and combo == comboMax and targetPh >= 20 then
                return _ExposeArmor;
            end
            
            if ConROC:CheckBox(ConROC_SM_Debuff_Rupture) and rupRDY and not rupDEBUFF and combo == comboMax and targetPh >= 15 then
                return _Rupture;
            end
            
            if bFlurryRDY and tarInMelee >= 2 then
                return Com_Ability.BladeFlurry;
            end
            
            if evisRDY and (combo == comboMax or (combo >= 1 and ((targetPh <= 5 and ConROC:Raidmob()) or (targetPh <= 20 and not ConROC:Raidmob())))) then
                return _Eviscerate;
            end
            
            if ConROC:CheckBox(ConROC_SM_Debuff_Hemorrhage) and hemoRDY and not hemoDEBUFF then
                return _Hemorrhage;
            end
            
            if bStabRDY and hasDagger and not ConROC:TarYou() and incombat then
                return _Backstab;
            end
            
            if gStrikeRDY and ConROC:TarYou() then
                return Sub_Ability.GhostlyStrike;
            end
            if sStrikeRDY and (not hasDagger or ConROC:TarYou()) then
                return _SinisterStrike;
            end

            return nil;
        elseif (currentSpecID == ids.Spec.Assassination) then
            if stealthed then
                if ConROC:CheckBox(ConROC_SM_Debuff_Garrote) and inClose == 1 and garRDY and not garDEBUFF then
                    return _Garrote;
                end
                if ambushRDY and hasDagger then
                    return _Ambush;
                end
                if bStabRDY and hasDagger and not ConROC:TarYou() then
                    return _Backstab;
                end
                if ShadowstrikeRDY and inClose ~= 1 and not (ambushRDY and bStabRDY) then
                    return _Shadowstrike
                end
                return nil;
            else
                if ConROC:CheckBox(ConROC_SM_Debuff_SliceandDice) and sndRDY and ((combo >= 1 and not sndBUFF) or (combo == comboMax and ((sndDUR <= 10 and not aRushBUFF) or (aRushBUFF and sndDUR <= 5)))) then
                    return _SliceandDice;
                end
                if SaberSlashRDY and combo ~= comboMax then
                    return _SaberSlash
                end
                if MutilateRDY and combo ~= comboMax then
                    return _Mutilate
                end
                if sStrikeRDY and combo ~= comboMax and (not (IsSpellKnownOrOverridesKnown(_SaberSlash) or IsSpellKnownOrOverridesKnown(_Mutilate))) then
                    return _SinisterStrike;
                end
                if EnvenomRDY and sndBUFF and combo == comboMax then
                    return _Envenom
                end
                return nil;
            end
        elseif (currentSpecID == ids.Spec.Combat) then
            if stealthed then
                if ConROC:CheckBox(ConROC_SM_Debuff_Garrote) and inClose == 1 and garRDY and not garDEBUFF then
                    return _Garrote;
                end
                if ambushRDY and hasDagger then
                    return _Ambush;
                end
                if bStabRDY and hasDagger and not ConROC:TarYou() then
                    return _Backstab;
                end
                if ShadowstrikeRDY and inClose ~= 1 and not (ambushRDY and bStabRDY) then
                    return _Shadowstrike
                end
                return nil;
            else
                if ConROC:CheckBox(ConROC_SM_Debuff_SliceandDice) and sndRDY and ((combo >= 1 and not sndBUFF) or (combo == comboMax and ((sndDUR <= 10 and not aRushBUFF) or (aRushBUFF and sndDUR <= 5)))) then
                    return _SliceandDice;
                end
                if SaberSlashRDY and combo ~= comboMax then
                    return _SaberSlash
                end
                if MutilateRDY and combo ~= comboMax then
                    return _Mutilate
                end
                if sStrikeRDY and combo ~= comboMax and (not (IsSpellKnownOrOverridesKnown(_SaberSlash) or IsSpellKnownOrOverridesKnown(_Mutilate))) then
                    return _SinisterStrike;
                end
                if EnvenomRDY and sndBUFF and combo == comboMax then
                    return _Envenom
                end
                return nil;
            end

        elseif (currentSpecID == ids.Spec.Subtlety) then
            if stealthed then
                if ambushRDY and hasDagger then
                    return _Ambush;
                end
                if bStabRDY and hasDagger and not ConROC:TarYou() then
                    return _Backstab;
                end
                if ShadowstrikeRDY and inClose ~= 1 and not (ambushRDY and bStabRDY) then
                    return _Shadowstrike
                end
                return nil;
            else
                if ConROC:CheckBox(ConROC_SM_Debuff_SliceandDice) and sndRDY and ((combo >= 1 and not sndBUFF) or (combo == comboMax and ((sndDUR <= 10 and not aRushBUFF) or (aRushBUFF and sndDUR <= 5)))) then
                    return _SliceandDice;
                end
                if MutilateRDY and combo ~= comboMax then
                    return _Mutilate
                end
                if SaberSlashRDY and combo ~= comboMax then
                    return _SaberSlash
                end
                if sStrikeRDY and combo ~= comboMax and (not (IsSpellKnownOrOverridesKnown(_SaberSlash) or IsSpellKnownOrOverridesKnown(_Mutilate))) then
                    return _SinisterStrike;
                end
                if EnvenomRDY and sndBUFF and combo == comboMax then
                    return _Envenom
                end
                return nil;
            end

        end
    end
    --if not SoD
    if stealthed then
        if premRDY then
            return Sub_Ability.Premeditation;
        end

        if ConROC:CheckBox(ConROC_SM_Stun_CheapShot) and cShotRDY and not cBloodBUFF then
            return Ass_Ability.CheapShot;
        end
        
        if ambushRDY and hasDagger then
            return _Ambush;
        end
        
        if ConROC:CheckBox(ConROC_SM_Debuff_Garrote) and garRDY and not garDEBUFF then
            return _Garrote;
        end

        if bStabRDY and hasDagger and not ConROC:TarYou() then
            return _Backstab;
        end
    
        if sStrikeRDY and not hasDagger then
            return _SinisterStrike;
        end
    end
    if ripRDY then
        return Com_Ability.Riposte;
    end

    if ConROC:CheckBox(ConROC_SM_Stun_KidneyShot) and kShotRDY and combo == comboMax then
        return _KidneyShot;
    end
    
    if ConROC:CheckBox(ConROC_SM_Debuff_SliceandDice) and sndRDY and ((combo >= 1 and not sndBUFF) or (combo == comboMax and ((sndDUR <= 10 and not aRushBUFF) or (aRushBUFF and sndDUR <= 5)))) then
        return _SliceandDice;
    end
    
    if ConROC:CheckBox(ConROC_SM_Debuff_ExposeArmor) and exArmorRDY and not exArmorDEBUFF and combo == comboMax and targetPh >= 20 then
        return _ExposeArmor;
    end
    
    if ConROC:CheckBox(ConROC_SM_Debuff_Rupture) and rupRDY and not rupDEBUFF and combo == comboMax and targetPh >= 15 then
        return _Rupture;
    end
    
    if bFlurryRDY and tarInMelee >= 2 then
        return Com_Ability.BladeFlurry;
    end
    
    if evisRDY and (combo == comboMax or (combo >= 1 and ((targetPh <= 5 and ConROC:Raidmob()) or (targetPh <= 20 and not ConROC:Raidmob())))) then
        return _Eviscerate;
    end
    
    if ConROC:CheckBox(ConROC_SM_Debuff_Hemorrhage) and hemoRDY and not hemoDEBUFF then
        return _Hemorrhage;
    end
    
    if bStabRDY and hasDagger and not ConROC:TarYou() and incombat then
        return _Backstab;
    end
    
    if gStrikeRDY and ConROC:TarYou() then
        return Sub_Ability.GhostlyStrike;
    end

    if sStrikeRDY and (not hasDagger or ConROC:TarYou()) then
        return _SinisterStrike;
    end

    return nil;
end

function ConROC.Rogue.Defense(_, timeShift, currentSpell, gcd) --
    --Ranks
    if IsSpellKnown(Sub_Ability.StealthRank4) then _Stealth = Sub_Ability.StealthRank4;
    elseif IsSpellKnown(Sub_Ability.StealthRank3) then _Stealth = Sub_Ability.StealthRank3;
    elseif IsSpellKnown(Sub_Ability.StealthRank2) then _Stealth = Sub_Ability.StealthRank2; end
    --Abilities
    local stealthRDY = ConROC:AbilityReady(_Stealth, timeShift)
    local evasionRDY = ConROC:AbilityReady(_Evasion, timeShift)
    
    --Conditions
    local ph = ConROC:PercentHealth("player")
    local stealthed = IsStealthed()
    local incombat = UnitAffectingCombat("player")
    
    --Rotations
    if stealthRDY and not stealthed and not incombat then
        return _Stealth
    end

    if evasionRDY and incombat and ConROC:TarYou() and ph <= 75 then
        return _Evasion
    end

    return nil
end

function ConROC:GetItemNameFromID(_itemID)
    local itemName, _, _, _, _, _, _, _, _, _ = GetItemInfo(_itemID)
    return itemName
end
function ConROC:GetItemTextureFromID(_itemID)
    local _, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(_itemID)
    return itemTexture
end

function ConROC:ApplyPoison(_mhPoison, _ohPoison)
    local _, Class, classId = UnitClass("player")
    local Color = RAID_CLASS_COLORS[Class]
    if _mhPoison ~= "none" then
        local mhName = _mhPoison.name;
        local mhTexture = select(5, GetItemInfoInstant(_mhPoison.id))
        local mhIC = 0
        if GetItemCount(_mhPoison.id) >= 1 then
            mhIC = GetItemCount(_mhPoison.id)
        end
        ConROCMainHandBGFrame:Show();
        --ConROCMainHandFrame:Show();
        if _mhAlpha == 1 then
            ConROCMainHandFrame:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square","ADD");
            ConROCMainHandFrame:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress","ADD");
            ConROCMainHandFrame:SetAttribute("macrotext", "/use  " .. mhName .. ";\n/use 16;\n/click StaticPopup1Button1;")
        else
            ConROCMainHandFrame:SetAttribute("macrotext", "")
        end
        mhIcText:SetText(mhIC);
        ConROCMainHandBGFrame:SetNormalTexture(mhTexture);
    else
        ConROCMainHandBGFrame:Hide();
        ConROCMainHandBGFrame:SetNormalTexture("");
        ConROCMainHandFrame:SetHighlightTexture("", "MOD");
        ConROCMainHandFrame:SetPushedTexture("", "MOD");
        ConROCMainHandFrame:SetAttribute("macrotext", "")
        mhIcText:SetText("")
    end
    ConROCMainHandBGFrame:SetAlpha(_mhAlpha);
    ConROCMainHandFrame:SetAlpha(_mhAlpha);

    
    if _ohPoison ~= "none" then
    local ohName = _ohPoison.name;
    local ohTexture = select(5, GetItemInfoInstant(_ohPoison.id))
    local ohIC = 0
        if GetItemCount(_ohPoison.id) >= 1 then
            ohIC = GetItemCount(_ohPoison.id)
        end
        ConROCOffHandBGFrame:Show();
        ConROCOffHandFrame:Show();
        if _ohAlpha == 1 then
            ConROCOffHandFrame:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square","ADD");
            ConROCOffHandFrame:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress","ADD");
            ConROCOffHandFrame:SetAttribute("macrotext", "/use " .. ohName .. ";\n/use 17;\n/click StaticPopup1Button1;")
        else
            ConROCOffHandFrame:SetAttribute("macrotext", "")
        end
        ohIcText:SetText(ohIC);
        ConROCOffHandBGFrame:SetNormalTexture(ohTexture);
    else
        ConROCOffHandBGFrame:Hide();
        ConROCOffHandBGFrame:SetNormalTexture("");
        ConROCOffHandFrame:SetHighlightTexture("", "MOD");
        ConROCOffHandFrame:SetPushedTexture("", "MOD");
        ConROCOffHandFrame:SetAttribute("macrotext", "")
        ohIcText:SetText("")
    end
    ConROCOffHandBGFrame:SetAlpha(_ohAlpha);
    ConROCOffHandFrame:SetAlpha(_ohAlpha);
end

function ConROC:CreatePoisonFrame()
    local _, Class, classId = UnitClass("player")
    local Color = RAID_CLASS_COLORS[Class]
    local mhName = _InstantPoison.name
    local mhTexture = select(5, GetItemInfoInstant(_InstantPoison.id))
    --local mhName, _, _, _, _, _, _, _, _, mhTexture = GetItemInfo(_InstantPoison)
    local ohName = _DeadlyPoison.name
    local ohTexture = select(5, GetItemInfoInstant(_DeadlyPoison.id))
    --local ohName, _, _, _, _, _, _, _, _, ohTexture = GetItemInfo(_DeadlyPoison)
    local frame = CreateFrame("Frame", "ConROCApplyPoisonFrame", UIParent, "BackdropTemplate")

    frame:SetFrameStrata("MEDIUM")
    frame:SetFrameLevel("4")
    frame:SetSize(128 + 8, 64 + 8)

    frame:SetBackdrop(
        {
            bgFile = "Interface\\CHATFRAME\\CHATFRAMEBACKGROUND",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 8,
            edgeSize = 20,
            insets = {left = 4, right = 4, top = 4, bottom = 4}
        }
    )
    frame:SetBackdropColor(0, 0, 0, .75)
    frame:SetBackdropBorderColor(Color.r, Color.g, Color.b, .75)
    frame:SetPoint("TOP", UIErrorsFrame, "BOTTOM", 0, -20)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetClipsChildren(false)
    frame:SetScript(
        "OnDragStart",
        function(self)
            if ConROC.db.profile.unlockWindow then
                if (IsAltKeyDown()) then
                    frame:StartMoving()
                end
            end
        end
    )
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetScript(
        "OnEnter",
        function(self)
            frame:SetAlpha(1)
        end
    )
    frame:SetScript(
        "OnLeave",
        function(self)
            if not MouseIsOver(frame) then
                if ConROC.db.profile._Hide_Spellmenu then
                    frame:SetAlpha(0)
                else
                    frame:SetAlpha(1)
                end
            end
        end
    )
    local dragFrame = CreateFrame("Frame", "ConROCApplyPoisonFrame_DragFrame", frame)
    dragFrame:SetFrameStrata('MEDIUM')
    dragFrame:SetFrameLevel('8')
    dragFrame:SetSize(26, 26)
    dragFrame:SetAlpha(1)
    dragFrame:SetPoint("BOTTOMLEFT", frame, "TOPRIGHT", -16, -16)

    -- Background texture
    local background = dragFrame:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    background:SetTexture("Interface\\AddOns\\ConROC\\images\\move_icon")
    background:SetDesaturated(true)
    background:SetVertexColor(Color.r, Color.g, Color.b)
    dragFrame.background = background

    if ConROC.db.profile.unlockWindow then
        dragFrame:Show();
    else
        dragFrame:Hide();
    end

    dragFrame:SetScript("OnMouseDown", function (self, otbutton, up)
        if ConROC.db.profile.unlockWindow then
                frame:StartMoving()
        end
    end)

    dragFrame:SetScript("OnMouseUp", function (self, otbutton, up)
        if ConROC.db.profile.unlockWindow then
            frame:StopMovingOrSizing();
        end
    end)
    local MhBgFrame = CreateFrame("BUTTON", "ConROCMainHandBGFrame", frame, "SecureActionButtonTemplate");
    local OhBgFrame = CreateFrame("BUTTON", "ConROCOffHandBGFrame", frame, "SecureActionButtonTemplate");
    MhBgFrame:ClearAllPoints();
    MhBgFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4);
    MhBgFrame:SetFrameStrata("MEDIUM");
    MhBgFrame:SetFrameLevel("5");
    MhBgFrame:SetSize(64, 64);
    MhBgFrame:SetAlpha(1);
    MhBgFrame:Show();
    MhBgFrame:RegisterForClicks();
    OhBgFrame:ClearAllPoints();
    OhBgFrame:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4);
    OhBgFrame:SetFrameStrata("MEDIUM");
    OhBgFrame:SetFrameLevel("5");
    OhBgFrame:SetSize(64, 64);
    OhBgFrame:SetAlpha(1);
    OhBgFrame:Show();
    OhBgFrame:RegisterForClicks();

    local secureMhButton = CreateFrame("BUTTON", "ConROCMainHandFrame", frame, "SecureActionButtonTemplate")
    secureMhButton:ClearAllPoints()
    secureMhButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4)
    secureMhButton:SetFrameStrata("MEDIUM")
    secureMhButton:SetFrameLevel("6")
    secureMhButton:SetSize(64, 64)
    secureMhButton:SetAlpha(1)
    local mhTitleText = secureMhButton:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    mhTitleText:SetParent(secureMhButton)
    mhTitleText:SetText("MH")
    mhTitleText:SetFont("Fonts\\ARIALN.TTF", 20)
    mhTitleText:SetShadowColor(0, 0, 0, 1)
    mhTitleText:SetShadowOffset(2, -2)
    mhTitleText:SetPoint("CENTER", secureMhButton, "CENTER", 0, 0)
    mhIcText = secureMhButton:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    mhIcText:SetFont("Fonts\\ARIALN.TTF", 16)
    mhIcText:SetText("N/A")
    mhIcText:SetPoint("BOTTOMRIGHT", secureMhButton, "BOTTOMRIGHT", -7, 7)
    secureMhButton:SetAttribute("type1", "macro")
    secureMhButton:SetAttribute("macrotext", "/s zomg a left click! - Main hand")

    secureMhButton:RegisterForClicks("AnyDown")
    secureMhButton:Show()

    local secureOhButton = CreateFrame("BUTTON", "ConROCOffHandFrame", frame, "SecureActionButtonTemplate")
    secureOhButton:ClearAllPoints()
    secureOhButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)
    secureOhButton:SetFrameStrata("MEDIUM")
    secureOhButton:SetFrameLevel("6")
    secureOhButton:SetSize(64, 64)
    secureOhButton:SetAlpha(1)
    local ohTitleText = secureOhButton:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    ohTitleText:SetText("OH")
    ohTitleText:SetFont("Fonts\\ARIALN.TTF", 20)
    ohTitleText:SetShadowColor(0, 0, 0, 1)
    ohTitleText:SetShadowOffset(2, -2)
    ohTitleText:SetPoint("CENTER", secureOhButton, "CENTER", 0, 0)
    ohIcText = secureOhButton:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    ohIcText:SetFont("Fonts\\ARIALN.TTF", 16)
    ohIcText:SetText("N/A")
    ohIcText:SetPoint("BOTTOMRIGHT", secureOhButton, "BOTTOMRIGHT", -7, 7)
    secureOhButton:SetAttribute("type1", "macro")
    secureOhButton:SetAttribute("macrotext", "/s zomg a left click! - Off hand")

    secureOhButton:RegisterForClicks("AnyDown")
    secureOhButton:Show();

    frame:Hide()
end

ConROC:CreatePoisonFrame()

function poisonErrorMessage(_pCount, _pName, _pNameMax, _hand)
    if _pCount < 1 then
        ConROC:Warnings("You should buy more " .. _pNameMax .. ", you have none left!!!", true)
    elseif _pCount < 10 then
        ConROC:Warnings("You should buy more " .. _pNameMax .. ", you only have " .. _pCount .. " left!!!", true)
        ConROC:Warnings("Put " .. _pName .. " on your " .. _hand .. " weapon!!!", true)
    else
        --UIErrorsFrame:AddMessage("Put ".. pName .." on your mainhand weapon!!!", 1.0, 0.0, 0.0, 53, .1);
        ConROC:Warnings("Put " .. _pName .. " on your " .. _hand .. " weapon!!!", true)
    end
end
