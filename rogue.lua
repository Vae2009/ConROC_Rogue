ConROC.Rogue = {}

local ConROC_Rogue, ids = ...;
local _tickerVar = 10;
local _mhP = nil;
local _ohP = nil;
local _mhNameMax, _mhTexture;
local _ohNameMax, _ohTexture;
local _mhAlpha = 1;
local _ohAlpha = 1;

function ConROC:EnableRotationModule()
    self.Description = "Rogue"
    self.NextSpell = ConROC.Rogue.Damage

    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
    self.lastSpellId = 0

	if ConROCSpellmenuClass == nil then
		ConROC:SpellmenuClass();
	end
end

function ConROC:EnableDefenseModule()
    self.NextDef = ConROC.Rogue.Defense
end

function ConROC:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
    if unitID == "player" then
        self.lastSpellId = spellID
    end
end

local Racial, Spec, Ability, Poisons, Rank, Ass_Talent, Com_Talent, Sub_Talent, Engrave, Runes, Buff, Debuff = ids.Racial, ids.Spec, ids.Ability, ids.Poisons, ids.Rank, ids.Assassination_Talent, ids.Combat_Talent, ids.Subtlety_Talent, ids.Engrave, ids.Runes, ids.Buff, ids.Debuff;

--Info
local _Player_Spec, _Player_Spec_ID = ConROC:currentSpec();
local _Player_Level = UnitLevel("player");
local _Player_Percent_Health = ConROC:PercentHealth('player');
local _is_PvP = ConROC:IsPvP();
local _in_combat = UnitAffectingCombat('player');
local _party_size = GetNumGroupMembers();
local _is_PC = UnitPlayerControlled("target");
local _is_Enemy = ConROC:TarHostile();
local _Target_Health = UnitHealth('target');
local _Target_Percent_Health = ConROC:PercentHealth('target');

--Resources
local _Combo, _Combo_Max = ConROC:PlayerPower('Combo');
local _Energy, _Energy_Max = ConROC:PlayerPower('Energy');

--Conditions
local _Queue = 0;
local _is_stealthed = IsStealthed();
local _is_moving = ConROC:PlayerSpeed();
local _enemies_in_melee, _target_in_melee = ConROC:Targets("Melee");
local _enemies_in_10yrds, _target_in_10yrds = ConROC:Targets("10");
local _enemies_in_20yrds, _target_in_20yrds = ConROC:Targets("20");
local _enemies_in_25yrds, _target_in_25yrds = ConROC:Targets("25");
local _enemies_in_40yrds, _target_in_40yrds = ConROC:Targets("40");
local _can_Execute = _Target_Percent_Health < 20;

--Racials
local _Berserking, _Berserking_RDY = _, _;

function ConROC:Stats()
	_Player_Spec, _Player_Spec_ID = ConROC:currentSpec();
	_Player_Level = UnitLevel("player");
	_Player_Percent_Health = ConROC:PercentHealth('player');
	_is_PvP = ConROC:IsPvP();
	_in_combat = UnitAffectingCombat('player');
	_party_size = GetNumGroupMembers();
	_is_PC = UnitPlayerControlled("target");
	_is_Enemy = ConROC:TarHostile();
	_Target_Health = UnitHealth('target');
	_Target_Percent_Health = ConROC:PercentHealth('target');

	_Combo, _Combo_Max = ConROC:PlayerPower('Combo');
	_Energy, _Energy_Max, _Energy_PERCENT = ConROC:PlayerPower('Energy');

	_Queue = 0;
    _is_stealthed = IsStealthed();
	_is_moving = ConROC:PlayerSpeed();
	_enemies_in_melee, _target_in_melee = ConROC:Targets("Melee");
	_enemies_in_10yrds, _target_in_10yrds = ConROC:Targets("10");
	_enemies_in_20yrds, _target_in_20yrds = ConROC:Targets("20");
    _enemies_in_25yrds, _target_in_25yrds = ConROC:Targets("25");
	_enemies_in_40yrds, _target_in_40yrds = ConROC:Targets("40");
	_can_Execute = _Target_Percent_Health < 20;

	_Berserking, _Berserking_RDY = ConROC:AbilityReady(Racial.Berserking, timeShift);
end

function ConROC.Rogue.Damage(_, timeShift, currentSpell, gcd)
	ConROC:UpdateSpellID();
	wipe(ConROC.SuggestedSpells);
	ConROC:Stats();

--Abilities
    local _AdrenalineRush, _AdrenalineRush_RDY = ConROC:AbilityReady(Ability.AdrenalineRush, timeShift);
        local _AdrenalineRush_BUFF = ConROC:Aura(_AdrenalineRush, timeShift);
    local _Ambush, _Ambush_RDY = ConROC:AbilityReady(Ability.Ambush, timeShift);
        local _Ambush_COST = 60;
    local _Backstab, _Backstab_RDY = ConROC:AbilityReady(Ability.Backstab, timeShift);
        local _Backstab_COST = 60;
    local _BladeFlurry, _BladeFlurry_RDY = ConROC:AbilityReady(Ability.BladeFlurry, timeShift);
    local _Blind, _Blind_RDY = ConROC:AbilityReady(Ability.Blind, timeShift);
    local _CheapShot, _CheapShot_RDY = ConROC:AbilityReady(Ability.CheapShot, timeShift);
    local _KidneyShot, _KidneyShot_RDY = ConROC:AbilityReady(Ability.KidneyShot, timeShift, "known");
    local _Eviscerate, _Eviscerate_RDY = ConROC:AbilityReady(Ability.Eviscerate, timeShift, "known");
    local _ColdBlood, _ColdBlood_RDY = ConROC:AbilityReady(Ability.ColdBlood, timeShift);
        local _ColdBlood_BUFF = ConROC:Aura(_ColdBlood, timeShift);
    local _ExposeArmor, _ExposeArmor_RDY = ConROC:AbilityReady(Ability.ExposeArmor, timeShift, "known");
        local _ExposeArmor_DEBUFF = ConROC:TargetAura(_ExposeArmor, timeShift);
    local _Garrote, _Garrote_RDY = ConROC:AbilityReady(Ability.Garrote, timeShift);
        local _Garrote_DEBUFF, _, _Garrote_DUR = ConROC:TargetAura(_Garrote, timeShift);
    local _GhostlyStrike, _GhostlyStrike_RDY = ConROC:AbilityReady(Ability.GhostlyStrike, timeShift);
    local _Gouge, _Gouge_RDY = ConROC:AbilityReady(Ability.Gouge, timeShift);
    local _Hemorrhage, _Hemorrhage_RDY = ConROC:AbilityReady(Ability.Hemorrhage, timeShift);
        local _Hemorrhage_DEBUFF = ConROC:TargetAura(_Hemorrhage, timeShift);
    local _Kick, _Kick_RDY = ConROC:AbilityReady(Ability.Kick, timeShift);
    local _Premeditation, _Premeditation_RDY = ConROC:AbilityReady(Ability.Premeditation, timeShift);
    local _Preparation, _Preparation_RDY = ConROC:AbilityReady(Ability.Preparation, timeShift);
    local _Riposte, _Riposte_RDY = ConROC:AbilityReady(Ability.Riposte, timeShift);
    local _Rupture, _Rupture_RDY = ConROC:AbilityReady(Ability.Rupture, timeShift, "known");
        local _Rupture_DEBUFF, _, _Rupture_DUR = ConROC:TargetAura(_Rupture, timeShift);
    local _SinisterStrike, _SinisterStrike_RDY = ConROC:AbilityReady(Ability.SinisterStrike, timeShift);
    local _SliceandDice, _SliceandDice_RDY = ConROC:AbilityReady(Ability.SliceandDice, timeShift, "known");
        local _SliceandDice_BUFF, _, _SliceandDice_DUR = ConROC:Aura(_SliceandDice, timeShift);
    local _Sprint, _Sprint_RDY = ConROC:AbilityReady(Ability.Sprint, timeShift);
    local _Vanish, _Vanish_RDY = ConROC:AbilityReady(Ability.Vanish, timeShift);

 --Runes
    local _BetweentheEyes, _BetweentheEyes_RDY = ConROC:AbilityReady(Runes.BetweentheEyes, timeShift, "known");
    local _BladeDance, _BladeDance_RDY = ConROC:AbilityReady(Runes.BladeDance, timeShift, "known");
        local _BladeDance_BUFF = ConROC:Aura(_BladeDance, timeShift);
    local _Blunderbuss, _Blunderbuss_RDY = ConROC:AbilityReady(Runes.Blunderbuss, timeShift);
    local _CrimsonTempest, _CrimsonTempest_RDY = ConROC:AbilityReady(Runes.CrimsonTempest, timeShift, "known");
        local _CrimsonTempest_DEBUFF, _, _CrimsonTempest_DUR = ConROC:TargetAura(_CrimsonTempest, timeShift);
        local _Cutthroat_BUFF = ConROC:Aura(Buff.Cutthroat, timeShift);
    local _Envenom, _Envenom_RDY = ConROC:AbilityReady(Runes.Envenom, timeShift, "known");
    local _MainGauche, _MainGauche_RDY = ConROC:AbilityReady(Runes.MainGauche, timeShift);
        local _MainGauche_BUFF = ConROC:Aura(Buff.MainGauche, timeShift);
    local _Mutilate, _Mutilate_RDY = ConROC:AbilityReady(Runes.Mutilate, timeShift);
    local _PoisonedKnife, _PoisonedKnife_RDY = ConROC:AbilityReady(Runes.PoisonedKnife, timeShift);
    local _QuickDraw, _QuickDraw_RDY = ConROC:AbilityReady(Runes.QuickDraw, timeShift);
    local _SaberSlash, _SaberSlash_RDY = ConROC:AbilityReady(Runes.SaberSlash, timeShift);
        local _, _SaberSlash_COUNT, _SaberSlash_DUR = ConROC:TargetAura(_SaberSlash, timeShift);
    local _Shadowstep, _Shadowstep_RDY = ConROC:AbilityReady(Runes.Shadowstep, timeShift);
        local _, _Shadowstep_RANGE = ConROC:Targets(_Shadowstep);
    local _Shadowstrike, _Shadowstrike_RDY = ConROC:AbilityReady(Runes.Shadowstrike, timeShift);
    local _ShurikenToss, _ShurikenToss_RDY = ConROC:AbilityReady(Runes.ShurikenToss, timeShift);
    local _Tease, _Tease_RDY = ConROC:AbilityReady(Runes.Tease, timeShift);

--Conditions
    local _Resting = IsResting();
    local _Mounted = IsMounted();
    local hasDagger = ConROC:Equipped("Daggers", "MAINHANDSLOT");
    local dualWielding = ConROC:Equipped("wpn", "MAINHANDSLOT") and ConROC:Equipped("wpn", "SECONDARYHANDSLOT");
    local poisonMH, _, _, _, poisonOH = GetWeaponEnchantInfo()
    local mhExp = 0
    local ohExp = 0
    local _Improved_SinisterStrike, _Improved_SinisterStrike_RANK = ConROC:TalentChosen(Spec.Combat, Com_Talent.ImprovedSinisterStrike)
    local _SinisterStrike_REDUCTION = 0;

    if _Improved_SinisterStrike then
        if _Improved_SinisterStrike_RANK == 2 then
            _SinisterStrike_REDUCTION = 5;
        elseif _Improved_SinisterStrike_RANK == 1 then
            _SinisterStrike_REDUCTION = 3;
        end
    end

    if _MainGauche_BUFF then
        _SinisterStrike_REDUCTION = _SinisterStrike_REDUCTION + 20;
    end

    if ConROC:RuneEquipped(ids.Engrave.SlaughterfromtheShadows, "chest") then
        _Ambush_COST = _Ambush_COST - 30;
        _Backstab_COST = _Backstab_COST - 30;
    end

 --Indicators
    ConROC:AbilityBurst(_AdrenalineRush, _AdrenalineRush_RDY and _in_combat and _Energy_PERCENT <= 40)
    ConROC:AbilityBurst(_ColdBlood, _ColdBlood_RDY and ((_is_stealthed and hasDagger) or _Combo == _Combo_Max))
    --  ConROC:AbilityBurst(_Preparation, _Preparation_RDY and _in_combat);
    ConROC:AbilityBurst(_Gouge, ConROC:CheckBox(ConROC_SM_Stun_Gouge) and _Gouge_RDY and not _Rupture_DEBUFF and not _Garrote_DEBUFF and _in_combat and ConROC:TarYou())
    ConROC:AbilityBurst(_Blind, ConROC:CheckBox(ConROC_SM_Stun_Blind) and _Blind_RDY and not _Rupture_DEBUFF and not _Garrote_DEBUFF and _in_combat and ConROC:TarYou())

    ConROC:AbilityMovement(_Shadowstep, _Shadowstep_RDY and _target_in_25yrds);
    ConROC:AbilityInterrupt(_Kick, ConROC:Interrupt() and _Kick_RDY)

--Warnings
    _tickerVar = _tickerVar + 1
    local hasMainHandEnchant, mainHandExpiration, mainHandCharges,  mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantId = GetWeaponEnchantInfo()
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
        if not _Mounted and (not _Resting or _is_stealthed) then
            if ConROC:CheckBox(ConROC_SM_PoisonMH_Instant) then
                if ids.ActivePoison[mainHandEnchantID] == Poisons.InstantPoison.name then
                    _mhAlpha = .5
                end
                _mhP = Poisons.InstantPoison
                _mhNameMax = Poisons.InstantPoison.name
                local pName = Rank.InstantPoisonRank1.name
                local pCount = GetItemCount(_mhP.id)
                if ids.ActivePoison[mainHandEnchantID] ~= _mhNameMax then
                    _mhAlpha = 1
                    poisonErrorMessage(pCount, pName, _mhNameMax, "mainhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonMH_Crippling) then
                if ids.ActivePoison[mainHandEnchantID] == Poisons.CripplingPoison.name then
                    _mhAlpha = .5
                end
                _mhP = Poisons.CripplingPoison
                _mhNameMax = Poisons.CripplingPoison.name
                local pName = Rank.CripplingPoisonRank1.name
                local pCount = GetItemCount(_mhP.id)
                if ids.ActivePoison[mainHandEnchantID] ~= _mhNameMax then
                    _mhAlpha = 1
                    poisonErrorMessage(pCount, pName, _mhNameMax, "mainhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonMH_Mindnumbing) then
                if ids.ActivePoison[mainHandEnchantID] == Poisons.MindnumbingPoison.name then
                    _mhAlpha = .5
                end
                _mhP = Poisons.MindnumbingPoison
                _mhNameMax = Poisons.MindnumbingPoison.name
                local pName = Rank.MindnumbingPoisonRank1.name
                local pCount = GetItemCount(_mhP.id)
                if ids.ActivePoison[mainHandEnchantID] ~= _mhNameMax then
                    _mhAlpha = 1
                    poisonErrorMessage(pCount, pName, _mhNameMax, "mainhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonMH_Deadly) then
                if ids.ActivePoison[mainHandEnchantID] == Poisons.DeadlyPoison.name then
                    _mhAlpha = .5
                end
                _mhP = Poisons.DeadlyPoison
                _mhNameMax = Poisons.DeadlyPoison.name
                local pName = Rank.DeadlyPoisonRank1.name
                local pCount = GetItemCount(_mhP.id)
                if ids.ActivePoison[mainHandEnchantID] ~= _mhNameMax then
                    _mhAlpha = 1
                    poisonErrorMessage(pCount, pName, _mhNameMax, "mainhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonMH_Wound) then
                if ids.ActivePoison[mainHandEnchantID] == Poisons.WoundPoison.name then
                    _mhAlpha = .5
                end
                _mhP = Poisons.WoundPoison
                _mhNameMax = Poisons.WoundPoison.name
                local pName = Rank.WoundPoisonRank1.name
                local pCount = GetItemCount(_mhP.id)
                if ids.ActivePoison[mainHandEnchantID] ~= _mhNameMax then
                    _mhAlpha = 1
                    poisonErrorMessage(pCount, pName, _mhNameMax, "mainhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonMH_Anesthetic) then
                if ids.ActivePoison[mainHandEnchantID] == Poisons.AnestheticPoison.name then
                    _mhAlpha = .5
                end
                _mhP = Poisons.AnestheticPoison
                _mhNameMax = Poisons.AnestheticPoison.name
                local pName = Rank.AnestheticPoisonRank1.name
                local pCount = GetItemCount(_mhP.id)
                if ids.ActivePoison[mainHandEnchantID] ~= _mhNameMax then
                    _mhAlpha = 1
                    poisonErrorMessage(pCount, pName, _mhNameMax, "mainhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonOH_Instant) then
                if ids.ActivePoison[offHandEnchantId] == Poisons.InstantPoison.name then
                    _ohAlpha = .5
                end
                _ohP = Poisons.InstantPoison
                _ohNameMax = Poisons.InstantPoison.name
                local pName = Rank.InstantPoisonRank1.name
                local pCount = GetItemCount(_ohP.id)
                if ids.ActivePoison[offHandEnchantId] ~= _ohNameMax then
                    _ohAlpha = 1
                    poisonErrorMessage(pCount, pName, _ohNameMax, "offhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonOH_Crippling) then
                if ids.ActivePoison[offHandEnchantId] == Poisons.CripplingPoison.name then
                    _ohAlpha = .5
                end
                _ohP = Poisons.CripplingPoison
                _ohNameMax = Poisons.CripplingPoison.name
                local pName = Rank.CripplingPoisonRank1.name
                local pCount = GetItemCount(_ohP.id)
                if ids.ActivePoison[offHandEnchantId] ~= _ohNameMax then
                    _ohAlpha = 1
                    poisonErrorMessage(pCount, pName, _ohNameMax, "offhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonOH_Mindnumbing) then
                if ids.ActivePoison[offHandEnchantId] == Poisons.MindnumbingPoison.name then
                    _ohAlpha = .5
                end
                _ohP = Poisons.MindnumbingPoison
                _ohNameMax = Poisons.MindnumbingPoison.name
                local pName = Rank.MindnumbingPoisonRank1.name
                local pCount = GetItemCount(_ohP.id)
                if ids.ActivePoison[offHandEnchantId] ~= _ohNameMax then
                    _ohAlpha = 1
                    poisonErrorMessage(pCount, pName, _ohNameMax, "offhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonOH_Deadly) then
                if ids.ActivePoison[offHandEnchantId] == Poisons.DeadlyPoison.name then
                    _ohAlpha = .5
                end
                _ohP = Poisons.DeadlyPoison
                _ohNameMax = Poisons.DeadlyPoison.name
                local pName = Rank.DeadlyPoisonRank1.name
                local pCount = GetItemCount(_ohP.id)
                if ids.ActivePoison[offHandEnchantId] ~= _ohNameMax then
                    _ohAlpha = 1
                    poisonErrorMessage(pCount, pName, _ohNameMax, "offhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonOH_Wound) then
                if ids.ActivePoison[offHandEnchantId] == Poisons.WoundPoison.name then
                    _ohAlpha = .5
                end
                _ohP = Poisons.WoundPoison
                _ohNameMax = Poisons.WoundPoison.name
                local pName = Rank.WoundPoisonRank1.name
                local pCount = GetItemCount(_ohP.id)
                if ids.ActivePoison[offHandEnchantId] ~= _ohNameMax then
                    _ohAlpha = 1
                    poisonErrorMessage(pCount, pName, _ohNameMax, "offhand")
                end
            end

            if ConROC:CheckBox(ConROC_SM_PoisonOH_Anesthetic) then
                if ids.ActivePoison[offHandEnchantId] ~= Poisons.AnestheticPoison.name then
                    _ohAlpha = .5
                end
                _ohP = Poisons.AnestheticPoison
                _ohNameMax = Poisons.AnestheticPoison.name
                local pName = Rank.AnestheticPoisonRank1.name
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
            if not (_Resting or _in_combat or _Mounted) then
                --print("showing apply poison")
                ConROC:ApplyPoison(_mhP, _ohP)
                if not ConROCApplyPoisonFrame:IsShown() then
                    ConROCApplyPoisonFrame:Show()
                end
            end
        end

        if ConROCApplyPoisonFrame:IsShown() then
            if
                (_Resting or _Mounted and not _in_combat) or (_mhP == "none" and _ohP == "none") or
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
    repeat
        while(true) do
            if ConROC.Seasons.IsSoD then
                if ConROC:CheckBox(ConROC_SM_Role_Tank) or ConROC:RuneEquipped(ids.Engrave.JustaFleshWound, "chest") then
                    if _ShurikenToss_RDY and _Energy >= 30 and not _target_in_melee then
                        tinsert(ConROC.SuggestedSpells, _ShurikenToss);
                        _ShurikenToss_RDY = false;
                        _Energy = _Energy - 30;
                        _Combo = _Combo + 1;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if ConROC:CheckBox(ConROC_SM_Buff_BladeDance) and _BladeDance_RDY and _Energy >= 25 and _Combo > 3 and _BladeDance_DUR < 10 then
                        tinsert(ConROC.SuggestedSpells, _BladeDance);
                        _BladeDance_BUFF = true;
                        _BladeDance_DUR = 22;
                        _Energy = _Energy - 25;
                        _Combo = 0;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if _Riposte_RDY and _Energy >= 10 then
                        tinsert(ConROC.SuggestedSpells, _Riposte);
                        _Riposte_RDY = false;
                        _Energy = _Energy - 10;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if _BladeFlurry_RDY and _Energy >= 25 and _SliceandDice_BUFF and (not ConROC:RuneEquipped(ids.Engrave.SaberSlash, "hands") or (ConROC:RuneEquipped(ids.Engrave.SaberSlash, "hands") and _SaberSlash_COUNT >= 3)) then
                        tinsert(ConROC.SuggestedSpells, _BladeFlurry);
                        _BladeFlurry_RDY = false;
                        _Energy = _Energy - 25;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if _Ambush_RDY and _Energy >= _Ambush_COST and _Cutthroat_BUFF and hasDagger then
                        tinsert(ConROC.SuggestedSpells, _Ambush);
                        _Cutthroat_BUFF = false;
                        _Energy = _Energy - _Ambush_COST;
                        _Combo = _Combo + 1;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if _MainGauche_RDY and _Energy >= 15 then
                        tinsert(ConROC.SuggestedSpells, _MainGauche);
                        _MainGauche_BUFF = true;
                        _Combo = _Combo + 1;
                        _Energy = _Energy - 15;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if _SaberSlash_RDY and (_SaberSlash_COUNT <= 3 or _SaberSlash_DUR <= 2) and _Combo <= _Combo_Max - 1 and _Energy >= (45 - _SinisterStrike_REDUCTION) then
                        tinsert(ConROC.SuggestedSpells, _SaberSlash);
                        _Combo = _Combo + 1;
                        _Energy = _Energy - (45 - _SinisterStrike_REDUCTION);
                        _SaberSlash_COUNT = _SaberSlash_COUNT + 1;
                        _SaberSlash_DUR = 12;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if ConROC:RuneEquipped(ids.Engrave.CuttotheChase, "wrist") then
                        if ConROC:CheckBox(ConROC_SM_Buff_BladeDance) and _BladeDance_RDY and _Energy >= 25 and _Combo > 1 and not _BladeDance_BUFF then
                            tinsert(ConROC.SuggestedSpells, _BladeDance);
                            _BladeDance_BUFF = true;
                            _BladeDance_DUR = 14;
                            _Energy = _Energy - 25;
                            _Combo = 0;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if ConROC:CheckBox(ConROC_SM_Buff_SliceandDice) and _SliceandDice_RDY and _Energy >= 25 and _Combo >= 3 and not _SliceandDice_BUFF then
                            tinsert(ConROC.SuggestedSpells, _SliceandDice);
                            _SliceandDice_BUFF = true;
                            _SliceandDice_DUR = 15;
                            _Energy = _Energy - 25;
                            _Combo = 0;
                            _Queue = _Queue + 1;
                            break;
                        end
                    else
                        if ConROC:CheckBox(ConROC_SM_Buff_BladeDance) and _BladeDance_RDY and _Energy >= 25 and _Combo >= 3 and not _BladeDance_BUFF then
                            tinsert(ConROC.SuggestedSpells, _BladeDance);
                            _BladeDance_BUFF = true;
                            _BladeDance_DUR = 22;
                            _Energy = _Energy - 25;
                            _Combo = 0;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if ConROC:CheckBox(ConROC_SM_Buff_SliceandDice) and _SliceandDice_RDY and _Energy >= 25 and _Combo >= 4 and not _SliceandDice_BUFF then
                            tinsert(ConROC.SuggestedSpells, _SliceandDice);
                            _SliceandDice_BUFF = true;
                            _SliceandDice_DUR = 18;
                            _Energy = _Energy - 25;
                            _Combo = 0;
                            _Queue = _Queue + 1;
                            break;
                        end
                    end

                    if _CrimsonTempest_RDY and _Energy >= 35 and _Combo >= 4 and not _CrimsonTempest_DEBUFF then
                        tinsert(ConROC.SuggestedSpells, _CrimsonTempest);
                        _CrimsonTempest_DEBUFF = true;
                        _Energy = _Energy - 35;
                        _Combo = 0;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if _Blunderbuss_RDY and _Energy >= 20 and _target_in_10yrds then
                        tinsert(ConROC.SuggestedSpells, _Blunderbuss);
                        _Blunderbuss_RDY = false;
                        _Energy = _Energy - 20;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if ConROC:CheckBox(ConROC_SM_Debuff_ExposeArmor) and _ExposeArmor_RDY and not _ExposeArmor_DEBUFF and _Combo == _Combo_Max and _Target_Percent_Health >= 20 then
                        tinsert(ConROC.SuggestedSpells, _ExposeArmor);
                        _ExposeArmor_DEBUFF = true;
                        _Combo = 0;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if ConROC:CheckBox(ConROC_SM_Debuff_Rupture) and _Rupture_RDY and not _Rupture_DEBUFF and _Combo == _Combo_Max and _Target_Percent_Health >= 15 then
                        tinsert(ConROC.SuggestedSpells, _Rupture);
                        _Rupture_DEBUFF = true;
                        _Combo = 0;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if _BetweentheEyes_RDY and _Energy >= 35 and (_Combo >= 5 or (_Combo >= 4 and _Energy >= 60 and _AdrenalineRush_BUFF)) then
                        tinsert(ConROC.SuggestedSpells, _BetweentheEyes);
                        _BetweentheEyes_RDY = false;
                        _Energy = _Energy - 35;
                        _Combo = 0;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if ConROC:RuneEquipped(ids.Engrave.Envenom, "legs") then
                        if _Envenom_RDY and _Energy >= 35 and (_Combo >= 5 or (_Combo >= 4 and _Energy >= 60 and _AdrenalineRush_BUFF)) then
                            tinsert(ConROC.SuggestedSpells, _Envenom);
                            _Energy = _Energy - 35;
                            _Combo = 0;
                            _Queue = _Queue + 1;
                            break;
                        end
                    else
                        if _Eviscerate_RDY and _Energy >= 35 and (_Combo >= 5 or (_Combo >= 4 and _Energy >= 60 and _AdrenalineRush_BUFF)) then
                            tinsert(ConROC.SuggestedSpells, _Eviscerate);
                            _Energy = _Energy - 35;
                            _Combo = 0;
                            _Queue = _Queue + 1;
                            break;
                        end
                    end

                    if _GhostlyStrike_RDY and _Energy >= 40 and _Combo <= _Combo_Max - 1 and ConROC:TarYou() then
                        tinsert(ConROC.SuggestedSpells, _GhostlyStrike);
                        _GhostlyStrike_RDY = false;
                        _Energy = _Energy - 40;
                        _Combo = _Combo + 1;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if _Mutilate_RDY and _Combo <= _Combo_Max - 2 and _Energy >= 40 then
                        tinsert(ConROC.SuggestedSpells, _Mutilate);
                        _Energy = _Energy - 40;
                        _Combo = _Combo + 2;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if _SaberSlash_RDY and _Combo <= _Combo_Max - 1 and _Energy >= 70 then
                        tinsert(ConROC.SuggestedSpells, _SaberSlash);
                        _Combo = _Combo + 1;
                        _Energy = _Energy - (45 - _SinisterStrike_REDUCTION);
                        _SaberSlash_COUNT = _SaberSlash_COUNT + 1;
                        _SaberSlash_DUR = 12;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if _SinisterStrike_RDY and _Combo <= _Combo_Max - 1 and _Energy >= 70 then
                        tinsert(ConROC.SuggestedSpells, _SinisterStrike);
                        _Combo =  _Combo + 1;
                        _Energy = _Energy - (45 - _SinisterStrike_REDUCTION);
                        _Queue = _Queue + 1;
                        break;
                    end
                else
                    if _is_stealthed then
                        if _Shadowstrike_RDY and not _target_in_melee and not (_Ambush_RDY and _Backstab_RDY) then
                            tinsert(ConROC.SuggestedSpells, _Shadowstrike);
                            _is_stealthed = false;
                            _Combo = _Combo + 1;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _Premeditation_RDY then
                            tinsert(ConROC.SuggestedSpells, _Premeditation);
                            _Premeditation_RDY = false;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if ConROC:CheckBox(ConROC_SM_Stun_CheapShot) and _CheapShot_RDY and not _ColdBlood_BUFF then
                            tinsert(ConROC.SuggestedSpells, _CheapShot);
                            _CheapShot_RDY = false;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _Ambush_RDY and _Energy >= _Ambush_COST and hasDagger then
                            tinsert(ConROC.SuggestedSpells, _Ambush);
                            _is_stealthed = false;
                            _Energy = _Energy - _Ambush_COST;
                            _Combo = _Combo + 1;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if ConROC:CheckBox(ConROC_SM_Debuff_Garrote) and _Garrote_RDY and not _Garrote_DEBUFF then
                            tinsert(ConROC.SuggestedSpells, _Garrote);
                            _is_stealthed = false;
                            _Combo = _Combo + 1;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _Mutilate_RDY and _Energy >= 40 and _Combo <= _Combo_Max - 2 then
                            tinsert(ConROC.SuggestedSpells, _Mutilate);
                            _Energy = _Energy - 40;
                            _Combo = _Combo + 2;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if ConROC:RuneEquipped(ids.Engrave.Cutthroat, "hands") and _Backstab_RDY and _Energy >= _Backstab_COST and hasDagger and _Combo <= _Combo_Max - 1 then
                            tinsert(ConROC.SuggestedSpells, _Backstab);
                            _Energy = _Energy - _Backstab_COST;
                            _Combo = _Combo + 1;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _SaberSlash_RDY and _Energy >= 75 and _Combo <= _Combo_Max - 1 then
                            tinsert(ConROC.SuggestedSpells, _SaberSlash);
                            _Combo = _Combo + 1;
                            _Energy = _Energy - (45 - _SinisterStrike_REDUCTION);
                            _SaberSlash_COUNT = _SaberSlash_COUNT + 1;
                            _SaberSlash_DUR = 12;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _SinisterStrike_RDY and _Energy >= 75 and _Combo <= _Combo_Max - 1 then
                            tinsert(ConROC.SuggestedSpells, _SinisterStrike);
                            _Combo = _Combo + 1;
                            _Energy = _Energy - (45 - _SinisterStrike_REDUCTION);
                            _Queue = _Queue + 1;
                            break;
                        end
                    else
                        if _Riposte_RDY and _Energy >= 10 then
                            tinsert(ConROC.SuggestedSpells, _Riposte);
                            _Riposte_RDY = false;
                            _Energy = _Energy - 10;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _Ambush_RDY and _Energy >= _Ambush_COST and _Cutthroat_BUFF and hasDagger then
                            tinsert(ConROC.SuggestedSpells, _Ambush);
                            _Cutthroat_BUFF = false;
                            _Energy = _Energy - _Ambush_COST;
                            _Combo = _Combo + 1;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _PoisonedKnife_RDY and _Energy >= 25 and _Combo <= _Combo_Max - 1 then
                            tinsert(ConROC.SuggestedSpells, _PoisonedKnife);
                            _PoisonedKnife_RDY = false;
                            _Energy = _Energy - 25;
                            _Combo = _Combo + 1;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _SaberSlash_RDY and (_SaberSlash_COUNT <= 3 or _SaberSlash_DUR <= 2) and _Combo <= _Combo_Max - 1 and _Energy >= (45 - _SinisterStrike_REDUCTION) then
                            tinsert(ConROC.SuggestedSpells, _SaberSlash);
                            _Combo = _Combo + 1;
                            _Energy = _Energy - (45 - _SinisterStrike_REDUCTION);
                            _SaberSlash_COUNT = _SaberSlash_COUNT + 1;
                            _SaberSlash_DUR = 12;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _BladeFlurry_RDY and _enemies_in_melee >= 2 then
                            tinsert(ConROC.SuggestedSpells, _BladeFlurry);
                            _BladeFlurry_RDY = false;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _CrimsonTempest_RDY and _Energy >= 35 and _Combo >= 4 and not _CrimsonTempest_DEBUFF and _enemies_in_melee >= 3 then
                            tinsert(ConROC.SuggestedSpells, _CrimsonTempest);
                            _CrimsonTempest_DEBUFF = true;
                            _Energy = _Energy - 35;
                            _Combo = 0;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _Blunderbuss_RDY and _Energy >= 20 and _target_in_10yrds then
                            tinsert(ConROC.SuggestedSpells, _Blunderbuss);
                            _Blunderbuss_RDY = false;
                            _Energy = _Energy - 20;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if ConROC:CheckBox(ConROC_SM_Buff_SliceandDice) and _SliceandDice_RDY and ((_Combo >= 1 and not _SliceandDice_BUFF) or (_Combo == _Combo_Max and ((_SliceandDice_DUR <= 10 and not _AdrenalineRush_BUFF) or (_AdrenalineRush_BUFF and _SliceandDice_DUR <= 5)))) then
                            tinsert(ConROC.SuggestedSpells, _SliceandDice);
                            _SliceandDice_BUFF = true;
                            _SliceandDice_DUR = 21;
                            _Combo = 0;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if ConROC:CheckBox(ConROC_SM_Stun_KidneyShot) and _KidneyShot_RDY and _Combo == _Combo_Max then
                            tinsert(ConROC.SuggestedSpells, _KidneyShot);
                            _KidneyShot_RDY = false;
                            _Combo = 0;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if ConROC:CheckBox(ConROC_SM_Debuff_ExposeArmor) and _ExposeArmor_RDY and not _ExposeArmor_DEBUFF and _Combo == _Combo_Max and _Target_Percent_Health >= 15 then
                            tinsert(ConROC.SuggestedSpells, _ExposeArmor);
                            _ExposeArmor_DEBUFF = true;
                            _Combo = 0;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if ConROC:CheckBox(ConROC_SM_Debuff_Rupture) and _Rupture_RDY and not _Rupture_DEBUFF and _Combo == _Combo_Max and _Target_Percent_Health >= 15 then
                            tinsert(ConROC.SuggestedSpells, _Rupture);
                            _Rupture_DEBUFF = true;
                            _Combo = 0;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _BetweentheEyes_RDY and _Energy >= 35 and (_Combo >= 5 or (_Combo >= 4 and _Energy >= 60 and _AdrenalineRush_BUFF)) then
                            tinsert(ConROC.SuggestedSpells, _BetweentheEyes);
                            _BetweentheEyes_RDY = false;
                            _Energy = _Energy - 35;
                            _Combo = 0;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if ConROC:RuneEquipped(ids.Engrave.Envenom, "legs") then
                            if _Envenom_RDY and _Energy >= 35 and (_Combo >= 5 or (_Combo >= 4 and _Energy >= 60 and _AdrenalineRush_BUFF)) then
                                tinsert(ConROC.SuggestedSpells, _Envenom);
                                _Energy = _Energy - 35;
                                _Combo = 0;
                                _Queue = _Queue + 1;
                                break;
                            end
                        else
                            if _Eviscerate_RDY and _Energy >= 35 and (_Combo >= 5 or (_Combo >= 4 and _Energy >= 60 and _AdrenalineRush_BUFF)) then
                                tinsert(ConROC.SuggestedSpells, _Eviscerate);
                                _Energy = _Energy - 35;
                                _Combo = 0;
                                _Queue = _Queue + 1;
                                break;
                            end
                        end

                        if ConROC:CheckBox(ConROC_SM_Debuff_Hemorrhage) and _Hemorrhage_RDY and not _Hemorrhage_DEBUFF then
                            tinsert(ConROC.SuggestedSpells, _Hemorrhage);
                            _Hemorrhage_DEBUFF = true;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _GhostlyStrike_RDY and _Energy >= 40 and _Combo <= _Combo_Max - 1 and ConROC:TarYou() then
                            tinsert(ConROC.SuggestedSpells, _GhostlyStrike);
                            _GhostlyStrike_RDY = false;
                            _Energy = _Energy - 40;
                            _Combo = _Combo + 1;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _Mutilate_RDY and _Energy >= 40 and _Combo <= _Combo_Max - 2 then
                            tinsert(ConROC.SuggestedSpells, _Mutilate);
                            _Energy = _Energy - 40;
                            _Combo = _Combo + 2;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if ConROC:RuneEquipped(ids.Engrave.Cutthroat, "hands") and _Backstab_RDY and _Energy >= _Backstab_COST and hasDagger and _Combo <= _Combo_Max - 1 then
                            tinsert(ConROC.SuggestedSpells, _Backstab);
                            _Energy = _Energy - _Backstab_COST;
                            _Combo = _Combo + 1;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _SaberSlash_RDY and _Energy >= 75 and _Combo <= _Combo_Max - 1 then
                            tinsert(ConROC.SuggestedSpells, _SaberSlash);
                            _Combo = _Combo + 1;
                            _Energy = _Energy - (45 - _SinisterStrike_REDUCTION);
                            _SaberSlash_COUNT = _SaberSlash_COUNT + 1;
                            _SaberSlash_DUR = 12;
                            _Queue = _Queue + 1;
                            break;
                        end

                        if _SinisterStrike_RDY and _Energy >= 75 and _Combo <= _Combo_Max - 1 then
                            tinsert(ConROC.SuggestedSpells, _SinisterStrike);
                            _Combo = _Combo + 1;
                            _Energy = _Energy - (45 - _SinisterStrike_REDUCTION);
                            _Queue = _Queue + 1;
                            break;
                        end
                    end
                end
            else--not SoD
                if _is_stealthed then
                    if _Premeditation_RDY then
                        tinsert(ConROC.SuggestedSpells, _Premeditation);
                        _Premeditation_RDY = false;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if ConROC:CheckBox(ConROC_SM_Stun_CheapShot) and _CheapShot_RDY and not _ColdBlood_BUFF then
                        tinsert(ConROC.SuggestedSpells, _CheapShot);
                        _CheapShot_RDY = false;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if _Ambush_RDY and _Energy >= _Ambush_COST and hasDagger then
                        tinsert(ConROC.SuggestedSpells, _Ambush);
                        _is_stealthed = false;
                        _Energy = _Energy - _Ambush_COST;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if ConROC:CheckBox(ConROC_SM_Debuff_Garrote) and _Garrote_RDY and not _Garrote_DEBUFF then
                        tinsert(ConROC.SuggestedSpells, _Garrote);
                        _Garrote_DEBUFF = true;
                        _is_stealthed = false;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if _Backstab_RDY and _Energy >= _Backstab_COST and hasDagger and not ConROC:TarYou() then
                        tinsert(ConROC.SuggestedSpells, _Backstab);
                        _is_stealthed = false;
                        _Energy = _Energy - _Backstab_COST;
                        _Combo = _Combo + 1;
                        _Queue = _Queue + 1;
                        break;
                    end

                    if _SinisterStrike_RDY and not hasDagger and _Energy >= (45 - _SinisterStrike_REDUCTION) then
                        tinsert(ConROC.SuggestedSpells, _SinisterStrike);
                        _is_stealthed = false;
                        _Combo = _Combo + 1;
                        _Energy = _Energy - (45 - _SinisterStrike_REDUCTION);
                        _Queue = _Queue + 1;
                        break;
                    end
                end

                if _Riposte_RDY then
                    tinsert(ConROC.SuggestedSpells, _Riposte);
                    _Riposte_RDY = false;
                    _Queue = _Queue + 1;
                    break;
                end

                if ConROC:CheckBox(ConROC_SM_Stun_KidneyShot) and _KidneyShot_RDY and _Combo == _Combo_Max then
                    tinsert(ConROC.SuggestedSpells, _KidneyShot);
                    _KidneyShot_RDY = false;
                    _Combo = 0;
                    _Queue = _Queue + 1;
                    break;
                end

                if ConROC:CheckBox(ConROC_SM_Buff_SliceandDice) and _SliceandDice_RDY and ((_Combo >= 1 and not _SliceandDice_BUFF) or (_Combo == _Combo_Max and ((_SliceandDice_DUR <= 10 and not _AdrenalineRush_BUFF) or (_AdrenalineRush_BUFF and _SliceandDice_DUR <= 5)))) then
                    tinsert(ConROC.SuggestedSpells, _SliceandDice);
                    _Combo = 0;
                    _SliceandDice_BUFF = true;
                    _SliceandDice_DUR = 21;
                    _Queue = _Queue + 1;
                    break;
                end

                if ConROC:CheckBox(ConROC_SM_Debuff_ExposeArmor) and _ExposeArmor_RDY and not _ExposeArmor_DEBUFF and _Combo == _Combo_Max and _Target_Percent_Health >= 20 then
                    tinsert(ConROC.SuggestedSpells, _ExposeArmor);
                    _ExposeArmor_DEBUFF = true;
                    _Combo = 0;
                    _Queue = _Queue + 1;
                    break;
                end

                if ConROC:CheckBox(ConROC_SM_Debuff_Rupture) and _Rupture_RDY and not _Rupture_DEBUFF and _Combo == _Combo_Max and _Target_Percent_Health >= 15 then
                    tinsert(ConROC.SuggestedSpells, _Rupture);
                    _Rupture_DEBUFF = true;
                    _Combo = 0;
                    _Queue = _Queue + 1;
                    break;
                end

                if _BladeFlurry_RDY and _enemies_in_melee >= 2 then
                    tinsert(ConROC.SuggestedSpells, _BladeFlurry);
                    _BladeFlurry_RDY = false;
                    _Queue = _Queue + 1;
                    break;
                end

                if _Eviscerate_RDY and (_Combo == _Combo_Max or (_Combo >= 1 and ((_Target_Percent_Health <= 5 and ConROC:Raidmob()) or (_Target_Percent_Health <= 20 and not ConROC:Raidmob())))) then
                    tinsert(ConROC.SuggestedSpells, _Eviscerate);
                    _Combo = 0;
                    _Queue = _Queue + 1;
                    break;
                end

                if ConROC:CheckBox(ConROC_SM_Debuff_Hemorrhage) and _Hemorrhage_RDY and not _Hemorrhage_DEBUFF then
                    tinsert(ConROC.SuggestedSpells, _Hemorrhage);
                    _Hemorrhage_DEBUFF = true;
                    _Combo = _Combo + 1;
                    _Queue = _Queue + 1;
                    break;
                end

                if _Backstab_RDY and _Energy >= _Backstab_COST and hasDagger and not ConROC:TarYou() then
                    tinsert(ConROC.SuggestedSpells, _Backstab);
                    _Energy = _Energy - _Backstab_COST;
                    _Combo = _Combo + 1;
                    _Queue = _Queue + 1;
                    break;
                end

                if _GhostlyStrike_RDY and ConROC:TarYou() then
                    tinsert(ConROC.SuggestedSpells, _GhostlyStrike);
                    _GhostlyStrike_RDY = false;
                    _Combo = _Combo + 1;
                    _Queue = _Queue + 1;
                    break;
                end

                if _SinisterStrike_RDY and _Energy >= (45 - _SinisterStrike_REDUCTION) and (not hasDagger or ConROC:TarYou()) then
                    tinsert(ConROC.SuggestedSpells, _SinisterStrike);
                    _Combo = _Combo + 1;
                    _Energy = _Energy - (45 - _SinisterStrike_REDUCTION);
                    _Queue = _Queue + 1;
                    break;
                end
            end

            tinsert(ConROC.SuggestedSpells, 26008); --Waiting Spell Icon
            _Queue = _Queue + 3;
            break;
        end
    until _Queue >= 3;
return nil;
end

function ConROC.Rogue.Defense(_, timeShift, currentSpell, gcd)
	ConROC:UpdateSpellID();
	wipe(ConROC.SuggestedDefSpells);
	ConROC:Stats();

 --Abilities
    local _Stealth, _Stealth_RDY = ConROC:AbilityReady(Ability.Stealth, timeShift)
    local _Evasion, _Evasion_RDY = ConROC:AbilityReady(Ability.Evasion, timeShift)

 --Rotations
    if _Stealth_RDY and not _is_stealthed and not _in_combat then
        tinsert(ConROC.SuggestedDefSpells, _Stealth);
    end

    if _Evasion_RDY and _in_combat and ConROC:TarYou() and _Player_Percent_Health <= 75 then
        tinsert(ConROC.SuggestedDefSpells, _Evasion);
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
    local mhName = Poisons.InstantPoison.name
    local mhTexture = select(5, GetItemInfoInstant(Poisons.InstantPoison.id))
    --local mhName, _, _, _, _, _, _, _, _, mhTexture = GetItemInfo(Poisons.InstantPoison)
    local ohName = Poisons.DeadlyPoison.name
    local ohTexture = select(5, GetItemInfoInstant(Poisons.DeadlyPoison.id))
    --local ohName, _, _, _, _, _, _, _, _, ohTexture = GetItemInfo(Poisons.DeadlyPoison)
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
