local ConROC_Rogue, ids = ...;

--General
ids.Racial = {
	Berserking = 20554,
	Shadowmeld = 20580,
}
ids.Spec = {
	Assassination = 1,
	Combat = 2,
	Subtlety = 3,
}
ids.Ability = {
--Assassination
	Ambush = 8676,
	CheapShot = 1833,
	ColdBlood = 14177,
	Eviscerate = 2098,
	ExposeArmor = 8647,
	Garrote = 703,
	KidneyShot = 408,
	Rupture = 1943,
	SliceandDice = 5171,
--Combat
	AdrenalineRush = 13750,
	Backstab = 53,
	BladeFlurry = 13877,
	Evasion = 5277,
	Feint = 1966,
	Gouge = 1776,
	Kick = 1766,
	Riposte = 14251,
	SinisterStrike = 1752,
	Sprint = 2983,
--Subtlety
	Blind = 2094,
	DetectTraps = 2836,
	DisarmTrap = 1842,
	Distract = 1725,
	GhostlyStrike = 14278,
	Hemorrhage = 16511,
	PickPocket = 921,
	Premeditation = 14183,
	Preparation = 14185,
	Sap = 6770,
	Stealth = 1784,
	Vanish = 1856,
}
ids.Poisons = { -- is items not spells
	CripplingPoison = {id = 3775, name = "Crippling Poison", enchantID = 22, type = "poison"},
	DeadlyPoison = {id = 2892, name = "Deadly Poison", enchantID = 7, type = "poison"},
	InstantPoison = {id = 6947, name = "Instant Poison", enchantID = 323, type = "poison"},
	MindnumbingPoison = {id = 5237, name = "Mind-numbing", enchantID = 35, type = "poison"},
	WoundPoison = {id = 10918, name = "Wound Poison", enchantID = 703, type = "poison"},
	BlindingPowder = {id = 5530, name = "Blinding Powder", enchantID = nil, type = "powder"},
}
ids.Rank = {
--Assassination
	AmbushRank1 = 8676,
	AmbushRank2 = 8724,
	AmbushRank3 = 8725,
	AmbushRank4 = 11267,
	AmbushRank5 = 11268,
	AmbushRank6 = 11269,
	EviscerateRank1 = 2098,
	EviscerateRank2 = 6760,
	EviscerateRank3 = 6761,
	EviscerateRank4 = 6762,
	EviscerateRank5 = 8623,
	EviscerateRank6 = 8624,
	EviscerateRank7 = 11299,
	EviscerateRank8 = 11300,
	ExposeArmorRank1 = 8647,
	ExposeArmorRank2 = 8649,
	ExposeArmorRank3 = 8650,
	ExposeArmorRank4 = 11197,
	ExposeArmorRank5 = 11198,
	GarroteRank1 = 703,
	GarroteRank2 = 8631,
	GarroteRank3 = 8632,
	GarroteRank4 = 8633,
	GarroteRank5 = 11289,
	GarroteRank6 = 11290,
	KidneyShotRank1 = 408,
	KidneyShotRank2 = 8643,
	RuptureRank1 = 1943,
	RuptureRank2 = 8639,
	RuptureRank3 = 8640,
	RuptureRank4 = 11273,
	RuptureRank5 = 11274,
	RuptureRank6 = 11275,
	SliceandDiceRank1 = 5171,
	SliceandDiceRank2 = 6774,
--Combat
	BackstabRank1 = 53,
	BackstabRank2 = 2589,
	BackstabRank3 = 2590,
	BackstabRank4 = 2591,
	BackstabRank5 = 8721,
	BackstabRank6 = 11279,
	BackstabRank7 = 11280,
	BackstabRank8 = 11281,
	FeintRank1 = 1966,
	FeintRank2 = 6768,
	FeintRank3 = 8637,
	FeintRank4 = 11303,
	GougeRank1 = 1776,
	GougeRank2 = 1777,
	GougeRank3 = 8629,
	GougeRank4 = 11285,
	GougeRank5 = 11286,
	KickRank1 = 1766,
	KickRank2 = 1767,
	KickRank3 = 1768,
	KickRank4 = 1769,
	SinisterStrikeRank1 = 1752,
	SinisterStrikeRank2 = 1757,
	SinisterStrikeRank3 = 1758,
	SinisterStrikeRank4 = 1759,
	SinisterStrikeRank5 = 1760,
	SinisterStrikeRank6 = 8621,
	SinisterStrikeRank7 = 11293,
	SinisterStrikeRank8 = 11294,
	SprintRank1 = 2983,
	SprintRank2 = 8696,
	SprintRank3 = 11305,
--Subtlety
	HemorrhageRank1 = 16511,
	HemorrhageRank2 = 17347,
	HemorrhageRank3 = 17348,
	SapRank1 = 6770,
	SapRank2 = 2070,
	SapRank3 = 11297,
	StealthRank1 = 1784,
	StealthRank2 = 1785,
	StealthRank3 = 1786,
	StealthRank4 = 1787,
	VanishRank1 = 1856,
	VanishRank2 = 1857,
--Poisons
	CripplingPoisonRank1 = {id = 3775, name = "Crippling Poison", enchantID = 22, type = "poison"},
	CripplingPoisonRank2 = {id = 3776, name = "Crippling Poison II", enchantID = 603, type = "poison"},
	DeadlyPoisonRank1 = {id = 2892, name = "Deadly Poison", enchantID = 7, type = "poison"},
	DeadlyPoisonRank2 = {id = 2893, name = "Deadly Poison II", enchantID = 8, type = "poison"},
	DeadlyPoisonRank3 = {id = 8984, name = "Deadly Poison III", enchantID = 626, type = "poison"},
	DeadlyPoisonRank4 = {id = 8985, name = "Deadly Poison IV", enchantID = 627, type = "poison"},
	DeadlyPoisonRank5 = {id = 20844, name = "Deadly Poison V", enchantID = 2630, type = "poison"},
	InstantPoisonRank1 = {id = 6947, name = "Instant Poison", enchantID = 323, type = "poison"},
	InstantPoisonRank2 = {id = 6949, name = "Instant Poison II", enchantID = 324, type = "poison"},
	InstantPoisonRank3 = {id = 6950, name = "Instant Poison III", enchantID = 325, type = "poison"},
	InstantPoisonRank4 = {id = 8926, name = "Instant Poison IV", enchantID = 623, type = "poison"},
	InstantPoisonRank5 = {id = 8927, name = "Instant Poison V", enchantID = 624, type = "poison"},
	InstantPoisonRank6 = {id = 8928, name = "Instant Poison VI", enchantID = 625, type = "poison"},
	MindnumbingPoisonRank1 = {id = 5237, name = "Mind-numbing", enchantID = 35, type = "poison"},
	MindnumbingPoisonRank2 = {id = 6951, name = "Mind-numbing II", enchantID = 23, type = "poison"},
	MindnumbingPoisonRank3 = {id = 9186, name = "Mind-numbing III", enchantID = 643, type = "poison"},
	WoundPoisonRank1 = {id = 10918, name = "Wound Poison", enchantID = 703, type = "poison"},
	WoundPoisonRank2 = {id = 10920, name = "Wound Poison II", enchantID = 704, type = "poison"},
	WoundPoisonRank3 = {id = 10921, name = "Wound Poison III", enchantID = 705, type = "poison"},
	WoundPoisonRank4 = {id = 10922, name = "Wound Poison IV", enchantID = 706, type = "poison"},
}
ids.Assassination_Talent = {
	ImprovedPoisons =  1, 
	Lethality =  2, 
	Malice =  3, 
	RemorselessAttacks =  4, 
	Ruthlessness =  5, 
	Murder =  6, 
	ImprovedEviscerate =  7, 
	ImprovedSliceandDice =  8, 
	ImprovedExposeArmor =  9, 
	ImprovedKidneyShot =  10, 
	ColdBlood =  11, 
	RelentlessStrikes =  12, 
	SealFate =  13, 
	Vigor =  14, 
	VilePoisons =  15, 
}
ids.Combat_Talent = {
	Precision =  1, 
	DaggerSpecialization =  2, 
	FistWeaponSpecialization =  3, 
	MaceSpecialization =  4, 
	LightningReflexes =  5, 
	Deflection =  6, 
	ImprovedSinisterStrike =  7, 
	ImprovedBackstab =  8, 
	ImprovedGouge =  9, 
	Endurance =  10, 
	AdrenalineRush =  11, 
	ImprovedKick =  12, 
	DualWieldSpecialization =  13, 
	ImprovedSprint =  14, 
	BladeFlurry =  15, 
	SwordSpecialization =  16, 
	Riposte =  17, 
	Aggression =  18, 
	WeaponExpertise =  19, 
}
ids.Subtlety_Talent = { 
	MasterofDeception =  1, 
	Camouflage =  2, 
	Initiative =  3, 
	Setup =  4, 
	Elusiveness =  5, 
	Opportunity =  6, 
	ImprovedSap =  7, 
	ImprovedAmbush =  8, 
	DirtyDeeds =  9, 
	Preparation =  10, 
	GhostlyStrike =  11, 
	Premeditation =  12, 
	Hemorrhage =  13, 
	SerratedBlades =  14, 
	SleightofHand =  15, 
	HeightenedSenses =  16, 
	Deadliness =  17, 
}
ids.Runes = {
	BetweentheEyes = 400009,
	BladeDance = 400012,
	Envenom = 399963,
	MainGauche = 424919,
	Mutilate = 399956,
	QuickDraw = 398196,
	SaberSlash = 424785,  --424979,
	Shadowstrike = 399985,
	Shiv = 424799,
	Tease = 410412, -- from the rune "Just a Flesh Wound", replaces Faint
	ShurikenToss = 399986, --Phase 2 - AoE hits up to 5
	MasterofSubtlety = 425098, --Phase 2 -passive -buff 10% +dmg for 6 sec breaking stealth
}
-- Auras
ids.Buff = {

}
ids.Debuff = {

}
ids.ActivePoison = { -- list of EnchantId and Poison name to map against Poisons
	[22]	=	"Crippling Poison",
	[603]	=	"Crippling Poison II",
	[7]		=	"Deadly Poison",
	[8]		=	"Deadly Poison II",
	[626]	=	"Deadly Poison III",
	[627]	=	"Deadly Poison IV",
	[2630]	=	"Deadly Poison V",
	[323]	=	"Instant Poison",
	[324]	=	"Instant Poison II",
	[325]	=	"Instant Poison III",
	[623]	=	"Instant Poison IV",
	[624]	=	"Instant Poison V",
	[625]	=	"Instant Poison VI",
	[35]	=	"Mind-numbing Poison",
	[23]	=	"Mind-numbing Poison II",
	[643]	=	"Mind-Numbing Poison III",
	[703]	=	"Wound Poison",
	[704]	=	"Wound Poison II",
	[705]	=	"Wound Poison III",
	[706]	=	"Wound Poison IV",
}

function ConROC:UpdateSpellID()
	--Ranks
	if IsSpellKnown(ids.Rank.AmbushRank6) then ids.Ability.Ambush = ids.Rank.AmbushRank6
	elseif IsSpellKnown(ids.Rank.AmbushRank5) then ids.Ability.Ambush = ids.Rank.AmbushRank5
	elseif IsSpellKnown(ids.Rank.AmbushRank4) then ids.Ability.Ambush = ids.Rank.AmbushRank4
	elseif IsSpellKnown(ids.Rank.AmbushRank3) then ids.Ability.Ambush = ids.Rank.AmbushRank3
	elseif IsSpellKnown(ids.Rank.AmbushRank2) then ids.Ability.Ambush = ids.Rank.AmbushRank2 end

	if IsSpellKnown(ids.Rank.EviscerateRank8) then ids.Ability.Eviscerate = ids.Rank.EviscerateRank8
	elseif IsSpellKnown(ids.Rank.EviscerateRank7) then ids.Ability.Eviscerate = ids.Rank.EviscerateRank7
	elseif IsSpellKnown(ids.Rank.EviscerateRank6) then ids.Ability.Eviscerate = ids.Rank.EviscerateRank6
	elseif IsSpellKnown(ids.Rank.EviscerateRank5) then ids.Ability.Eviscerate = ids.Rank.EviscerateRank5
	elseif IsSpellKnown(ids.Rank.EviscerateRank4) then ids.Ability.Eviscerate = ids.Rank.EviscerateRank4
	elseif IsSpellKnown(ids.Rank.EviscerateRank3) then ids.Ability.Eviscerate = ids.Rank.EviscerateRank3
	elseif IsSpellKnown(ids.Rank.EviscerateRank2) then ids.Ability.Eviscerate = ids.Rank.EviscerateRank2 end

	if IsSpellKnown(ids.Rank.ExposeArmorRank5) then ids.Ability.ExposeArmor = ids.Rank.ExposeArmorRank5;
	elseif IsSpellKnown(ids.Rank.ExposeArmorRank4) then ids.Ability.ExposeArmor = ids.Rank.ExposeArmorRank4;
	elseif IsSpellKnown(ids.Rank.ExposeArmorRank3) then ids.Ability.ExposeArmor = ids.Rank.ExposeArmorRank3;
	elseif IsSpellKnown(ids.Rank.ExposeArmorRank2) then ids.Ability.ExposeArmor = ids.Rank.ExposeArmorRank2; end

	if IsSpellKnown(ids.Rank.GarroteRank6) then ids.Ability.Garrote = ids.Rank.GarroteRank6
	elseif IsSpellKnown(ids.Rank.GarroteRank5) then ids.Ability.Garrote = ids.Rank.GarroteRank5
	elseif IsSpellKnown(ids.Rank.GarroteRank4) then ids.Ability.Garrote = ids.Rank.GarroteRank4
	elseif IsSpellKnown(ids.Rank.GarroteRank3) then ids.Ability.Garrote = ids.Rank.GarroteRank3
	elseif IsSpellKnown(ids.Rank.GarroteRank2) then ids.Ability.Garrote = ids.Rank.GarroteRank2 end

	if IsSpellKnown(ids.Rank.KidneyShotRank2) then ids.Ability.KidneyShot = ids.Rank.KidneyShotRank2 end

	if IsSpellKnown(ids.Rank.RuptureRank6) then ids.Ability.Rupture = ids.Rank.RuptureRank6
	elseif IsSpellKnown(ids.Rank.RuptureRank5) then ids.Ability.Rupture = ids.Rank.RuptureRank5
	elseif IsSpellKnown(ids.Rank.RuptureRank4) then ids.Ability.Rupture = ids.Rank.RuptureRank4
	elseif IsSpellKnown(ids.Rank.RuptureRank3) then ids.Ability.Rupture = ids.Rank.RuptureRank3
	elseif IsSpellKnown(ids.Rank.RuptureRank2) then ids.Ability.Rupture = ids.Rank.RuptureRank2 end

	if IsSpellKnown(ids.Rank.SliceandDiceRank2) then ids.Ability.SliceandDice = ids.Rank.SliceandDiceRank2 end

	if IsSpellKnown(ids.Rank.BackstabRank8) then ids.Ability.Backstab = ids.Rank.BackstabRank8
	elseif IsSpellKnown(ids.Rank.BackstabRank7) then ids.Ability.Backstab = ids.Rank.BackstabRank7
	elseif IsSpellKnown(ids.Rank.BackstabRank6) then ids.Ability.Backstab = ids.Rank.BackstabRank6
	elseif IsSpellKnown(ids.Rank.BackstabRank5) then ids.Ability.Backstab = ids.Rank.BackstabRank5
	elseif IsSpellKnown(ids.Rank.BackstabRank4) then ids.Ability.Backstab = ids.Rank.BackstabRank4
	elseif IsSpellKnown(ids.Rank.BackstabRank3) then ids.Ability.Backstab = ids.Rank.BackstabRank3
	elseif IsSpellKnown(ids.Rank.BackstabRank2) then ids.Ability.Backstab = ids.Rank.BackstabRank2 end

	if IsSpellKnown(ids.Rank.FeintRank4) then ids.Ability.Feint = ids.Rank.FeintRank4
	elseif IsSpellKnown(ids.Rank.FeintRank3) then ids.Ability.Feint = ids.Rank.FeintRank3
	elseif IsSpellKnown(ids.Rank.FeintRank2) then ids.Ability.Feint = ids.Rank.FeintRank2 end

	if IsSpellKnown(ids.Rank.GougeRank5) then ids.Ability.Gouge = ids.Rank.GougeRank5;
	elseif IsSpellKnown(ids.Rank.GougeRank4) then ids.Ability.Gouge = ids.Rank.GougeRank4;
	elseif IsSpellKnown(ids.Rank.GougeRank3) then ids.Ability.Gouge = ids.Rank.GougeRank3;
	elseif IsSpellKnown(ids.Rank.GougeRank2) then ids.Ability.Gouge = ids.Rank.GougeRank2; end

	if IsSpellKnown(ids.Rank.KickRank4) then ids.Ability.Kick = ids.Rank.KickRank4;
	elseif IsSpellKnown(ids.Rank.KickRank3) then ids.Ability.Kick = ids.Rank.KickRank3;
	elseif IsSpellKnown(ids.Rank.KickRank2) then ids.Ability.Kick = ids.Rank.KickRank2; end

	if IsSpellKnown(ids.Rank.SinisterStrikeRank8) then ids.Ability.SinisterStrike = ids.Rank.SinisterStrikeRank8
	elseif IsSpellKnown(ids.Rank.SinisterStrikeRank7) then ids.Ability.SinisterStrike = ids.Rank.SinisterStrikeRank7
	elseif IsSpellKnown(ids.Rank.SinisterStrikeRank6) then ids.Ability.SinisterStrike = ids.Rank.SinisterStrikeRank6
	elseif IsSpellKnown(ids.Rank.SinisterStrikeRank5) then ids.Ability.SinisterStrike = ids.Rank.SinisterStrikeRank5
	elseif IsSpellKnown(ids.Rank.SinisterStrikeRank4) then ids.Ability.SinisterStrike = ids.Rank.SinisterStrikeRank4
	elseif IsSpellKnown(ids.Rank.SinisterStrikeRank3) then ids.Ability.SinisterStrike = ids.Rank.SinisterStrikeRank3
	elseif IsSpellKnown(ids.Rank.SinisterStrikeRank2) then ids.Ability.SinisterStrike = ids.Rank.SinisterStrikeRank2 end

	if IsSpellKnown(ids.Rank.SprintRank3) then ids.Ability.Sprint = ids.Rank.SprintRank3
	elseif IsSpellKnown(ids.Rank.SprintRank2) then ids.Ability.Sprint = ids.Rank.SprintRank2 end

	if IsSpellKnown(ids.Rank.HemorrhageRank3) then ids.Ability.Hemorrhage = ids.Rank.HemorrhageRank3
	elseif IsSpellKnown(ids.Rank.HemorrhageRank2) then ids.Ability.Hemorrhage = ids.Rank.HemorrhageRank2 end

	if IsSpellKnown(ids.Rank.SapRank3) then ids.Ability.Sap = ids.Rank.SapRank3
	elseif IsSpellKnown(ids.Rank.SapRank2) then ids.Ability.Sap = ids.Rank.SapRank2 end

	if IsSpellKnown(ids.Rank.VanishRank2) then ids.Ability.Vanish = ids.Rank.VanishRank2 end

	if IsSpellKnown(ids.Rank.StealthRank4) then ids.Ability.Stealth = ids.Rank.StealthRank4;
    elseif IsSpellKnown(ids.Rank.StealthRank3) then ids.Ability.Stealth = ids.Rank.StealthRank3;
    elseif IsSpellKnown(ids.Rank.StealthRank2) then ids.Ability.Stealth = ids.Rank.StealthRank2; end

	local _Player_Level = UnitLevel("player");
	if _Player_Level >= 50 then ids.Poisons.CripplingPoison = ids.Rank.CripplingPoisonRank2; end

	if _Player_Level >= 54 then ids.Poisons.DeadlyPoison = ids.Rank.DeadlyPoisonRank4;
	elseif _Player_Level >= 46 then ids.Poisons.DeadlyPoison = ids.Rank.DeadlyPoisonRank3;
	elseif _Player_Level >= 38 then ids.Poisons.DeadlyPoison = ids.Rank.DeadlyPoisonRank2; end

	if _Player_Level >= 60 then ids.Poisons.InstantPoison = ids.Rank.InstantPoisonRank6;
	elseif _Player_Level >= 52 then ids.Poisons.InstantPoison = ids.Rank.InstantPoisonRank5;
	elseif _Player_Level >= 44 then ids.Poisons.InstantPoison = ids.Rank.InstantPoisonRank4;
	elseif _Player_Level >= 36 then ids.Poisons.InstantPoison = ids.Rank.InstantPoisonRank3;
	elseif _Player_Level >= 28 then ids.Poisons.InstantPoison = ids.Rank.InstantPoisonRank2; end

	if _Player_Level >= 52 then ids.Poisons.MindnumbingPoison = ids.Rank.MindnumbingPoisonRank3;
	elseif _Player_Level >= 38 then ids.Poisons.MindnumbingPoison = ids.Rank.MindnumbingPoisonRank2; end

	if _Player_Level >= 56 then ids.Poisons.WoundPoison = ids.Rank.WoundPoisonRank4;
	elseif _Player_Level >= 48 then ids.Poisons.WoundPoison = ids.Rank.WoundPoisonRank3;
	elseif _Player_Level >= 40 then ids.Poisons.WoundPoison = ids.Rank.WoundPoisonRank2; end
end