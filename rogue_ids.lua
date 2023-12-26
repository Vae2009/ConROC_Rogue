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
--Assassination
	ids.Ass_Ability = {
		AmbushRank1 = 8676,
		AmbushRank2 = 8724,
		AmbushRank3 = 8725,
		AmbushRank4 = 11267,
		AmbushRank5 = 11268,
		AmbushRank6 = 11269,
		CheapShot = 1833,
		ColdBlood = 213981,
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
	}
	--[[ids.Ass_Talent = {
		ImprovedEviscerate = 1,
		RemorselessAttacks = 2,
		Malice = 3,
		 
		Ruthlessness = 4,
		Murder = 5,
		ImprovedSliceandDice = 6,
		 
		RelentlessStrikes = 7,
		ImprovedExposeArmor = 8,
		Lethality = 9,
		 
		VilePoisons = 10,
		ImprovedPoisons = 11,
		 
		ColdBlood = 12,
		ImprovedKidneyShot = 13,
		 
		SealFate = 14,
		 
		Vigor = 15,
	}--]]
--Combat
	ids.Com_Ability = {
		AdrenalineRush = 13750,
		BackstabRank1 = 53,
		BackstabRank2 = 2589,
		BackstabRank3 = 2590,
		BackstabRank4 = 2591,
		BackstabRank5 = 8721,
		BackstabRank6 = 11279,
		BackstabRank7 = 11280,
		BackstabRank8 = 11281,
		BladeFlurry = 13877,
		Evasion = 5277,
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
		Riposte = 14251,
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
	}
	--[[ids.Com_Talent = {
		ImprovedGouge = 1,
		ImprovedSinisterStrike = 2,
		LightningReflexes = 3,
		 
		ImprovedBackstab = 4,
		Deflection = 5,
		Precision = 6,
		 
		Endurance = 7,
		Riposte = 8,
		ImprovedSprint = 9,
		 
		ImprovedKick = 10,
		DaggerSpecialization = 11,
		DualWieldSpecialization = 12,
		 
		MaceSpecialization = 13,
		BladeFlurry = 14,
		SwordSpecialization = 15,
		FistWeaponSpecialization = 16,
		 
		WeaponExpertise = 17,
		Aggression = 18,
		 
		AdrenalineRush = 19,
	}--]]
--Subtlety
	ids.Sub_Ability = {
		Blind = 2094,
		DetectTraps = 2836,
		DisarmTrap = 1842,
		Distract = 1725,
		GhostlyStrike = 14278,
		HemorrhageRank1 = 16511,
		HemorrhageRank2 = 17347,
		HemorrhageRank3 = 17348,
		PickPocket = 921,
		Premeditation = 14183,
		Preparation = 14185,
		SapRank1 = 6770,
		SapRank2 = 2070,
		SapRank3 = 11297,
		StealthRank1 = 1784,
		StealthRank2 = 1785,
		StealthRank3 = 1786,
		StealthRank4 = 1787,
		VanishRank1 = 1856,
		VanishRank2 = 1857,
	}
	--[[ids.Sub_Talent = {
		MasterofDeception = 1,
		Opportunity = 2,
		 
		SleightofHand = 3,
		Elusiveness = 4,
		Camouflage = 5,
		 
		Initiative = 6,
		GhostlyStrike = 7,
		ImprovedAmbush = 8,
		 
		Setup = 9,
		ImprovedSap = 10,
		SerratedBlades = 11,
		 
		HeightenedSenses = 12,
		Preparation = 13,
		DirtyDeeds = 14,
		Hemorrhage = 15,
		 
		Deadliness = 16,
		  
		Premeditation = 17,
	}--]]
--Poisons
	ids.Poisons = { -- is items not spells
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
		BlindingPowder = {id = 5530, name = "Blinding Powder", enchantID = nil, type = "powder"},
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
-- Auras
	ids.Player_Buff = {
	
	}
	ids.Player_Debuff = {

	}
	ids.Target_Debuff = {
	
	}