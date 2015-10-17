Weapons = {}

-- Weapons List
-- The upgrades tables might be in order

Weapons["item_handgun"] = {Weapon = "weapon_handgun_re"}
Weapons["item_m4"] = {Weapon = "weapon_m4_re"}
Weapons["item_p90"] = {Weapon = "weapon_p90_re"}
Weapons["item_pumpshot"] = {Weapon = "weapon_pumpshot_re"}
Weapons["item_glock18"] = {Weapon = "weapon_glock18_re"}
Weapons["item_aug"] = {Weapon = "weapon_aug_re"}
Weapons["item_mp5"] = {Weapon = "weapon_mp5_re"}
Weapons["item_ragerev"] = {Weapon = "weapon_ragerevolver_re"}
--
Weapons["item_p228"] = {Weapon = "weapon_p228_re"}
Weapons["item_ak47"] = {Weapon = "weapon_ak47_re"}
Weapons["item_ump"] = {Weapon = "weapon_ump_re"}
Weapons["item_deagle"] = {Weapon = "weapon_deagle_re"}
--
Weapons["item_awp"] = {Weapon = "weapon_awp_re"}

UpgPrices = {}
UpgradeLevels = {}

GM.Weapons = {}
GM.Weapons["item_9mmhandgun"] = {
	Weapon = "weapon_9mmHandgun_re",
	Item = "item_9mmhandgun",
	AmmoTypes = {{item = "item_ammo_pistol",Icon = "gui/ammo/handgun"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = 0.75,
	IMultiplier = 0.75,
	UpGrades = {
		Power = {{Price = 100, Level = 17},
				{Price = 1500, Level = 20},
				{Price = 2500, Level = 23},
				{Price = 4000, Level = 25}},
		Accuracy = {{Price = 100, Level = 0.08},
				{Price = 1500, Level = 0.07},
				{Price = 3000, Level = 0.06},
				{Price = 4000, Level = 0.05},},
		ClipSize = {{Price = 100, Level = 15},
				{Price = 1300, Level = 20},
				{Price = 2000, Level = 25},
				{Price = 2600, Level = 30}},
		FiringSpeed = {{Price = 100, Level = 0.1},
				{Price = 1400, Level = 0.08},
				{Price = 2200, Level = 0.06},
				{Price = 3100, Level = 0.04}},
		ReloadSpeed = {{Price = 400, Level = 2.4},
				{Price = 1000, Level = 2.2},
				{Price = 1000, Level = 2.1}},
	},
}

GM.Weapons["item_p228"] = {
	Weapon = "weapon_p228_re",
	Item = "item_p228",
	AmmoTypes = {{item = "item_ammo_pistol",Icon = "gui/ammo/handgun"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = 0.75,
	IMultiplier = 0.75,
	UpGrades = {
		Power = {{Price = 100, Level = 13},
				{Price = 1500, Level = 17},
				{Price = 2500, Level = 19},
				{Price = 4000, Level = 21},
				{Price = 4000, Level = 23}},
		Accuracy = {{Price = 100, Level = 0.08},
				{Price = 1500, Level = 0.06},
				{Price = 3000, Level = 0.05},},
		ClipSize = {{Price = 100, Level = 13},
				{Price = 1300, Level = 18},
				{Price = 2000, Level = 25},
				{Price = 2600, Level = 30}},
		FiringSpeed = {{Price = 100, Level = 0.15},
				{Price = 1400, Level = 0.13},
				{Price = 2200, Level = 0.1},},
		ReloadSpeed = {{Price = 400, Level = 2.3},
				{Price = 1000, Level = 2.1},
				{Price = 1000, Level = 2.0},
				{Price = 1000, Level = 1.9},},
	},
}

GM.Weapons["item_glock18"] = {
	Weapon = "weapon_glock18_re",
	Item = "item_glock18",
	AmmoTypes = {{item = "item_ammo_pistol",Icon = "gui/ammo/handgun"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = 0.75,
	IMultiplier = 1.1,
	UpGrades = {
		Power = {{Price = 100, Level = 13},
				{Price = 1500, Level = 16},
				{Price = 2500, Level = 19},
				{Price = 4000, Level = 21},},
		Accuracy = {{Price = 100, Level = 0.07},
				{Price = 1500, Level = 0.06},
				{Price = 3000, Level = 0.05},
				{Price = 3000, Level = 0.04},},
		ClipSize = {{Price = 100, Level = 20},
				{Price = 1300, Level = 30},
				{Price = 2000, Level = 35},
				{Price = 2600, Level = 40}},
		FiringSpeed = {{Price = 100, Level = 0.2},
				{Price = 1400, Level = 0.18},
				{Price = 2200, Level = 0.16},
				{Price = 2200, Level = 0.15},},
		ReloadSpeed = {{Price = 400, Level = 2.5},
				{Price = 1000, Level = 2.3},
				{Price = 1000, Level = 2.2},},
	},
}


----- MAGNUMS
GM.Weapons["item_deagle"] = {
	Weapon = "weapon_deagle_re",
	Item = "item_deagle",
	AmmoTypes = {{item = "item_ammo_magnum",Icon = "gui/ammo/357"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = 0.75,
	IMultiplier = 0.75,
	UpGrades = {
		Power = {{Price = 100, Level = 68},
				{Price = 1500, Level = 74},
				{Price = 2500, Level = 86},
				{Price = 4000, Level = 95},
				{Price = 4000, Level = 105},},
		Accuracy = {{Price = 100, Level = 0.04},
				{Price = 1500, Level = 0.035},},
		ClipSize = {{Price = 100, Level = 7},
				{Price = 1300, Level = 8},
				{Price = 2000, Level = 9},
				{Price = 2600, Level = 10},
				{Price = 2600, Level = 11},
				{Price = 2600, Level = 12},},
		FiringSpeed = {{Price = 100, Level = 0.3},
				{Price = 1400, Level = 0.2},},
		ReloadSpeed = {{Price = 400, Level = 1.9},
				{Price = 1000, Level = 1.7},
				{Price = 1000, Level = 1.6}},
	},
}

GM.Weapons["item_ragerev"] = {
	Weapon = "weapon_ragerev_re",
	Item = "item_ragerev",
	AmmoTypes = {{item = "item_ammo_magnum",Icon = "gui/ammo/357"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = 0.75,
	IMultiplier = 0.75,
	UpGrades = {
		Power = {{Price = 100, Level = 75},
				{Price = 1500, Level = 80},
				{Price = 2500, Level = 92},
				{Price = 4000, Level = 102},
				{Price = 4000, Level = 108},
				{Price = 4000, Level = 115},},
		Accuracy = {{Price = 100, Level = 0.04},
				{Price = 1500, Level = 0.03},},
		ClipSize = {{Price = 100, Level = 6},},
		FiringSpeed = {{Price = 100, Level = 0.4},
				{Price = 1400, Level = 0.3},
				{Price = 1400, Level = 0.2},
				{Price = 1400, Level = 0.1},},
		ReloadSpeed = {{Price = 400, Level = 2.3},
				{Price = 1000, Level = 2.1},
				{Price = 1000, Level = 2.0},
				{Price = 1000, Level = 1.9},},
	},
}

GM.Weapons["item_m29"] = {
	Weapon = "weapon_m29_re",
	Item = "item_m29",
	AmmoTypes = {{item = "item_ammo_magnum",Icon = "gui/ammo/357"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = 0.75,
	IMultiplier = 0.75,
	UpGrades = {
		Power = {{Price = 100, Level = 90},
				{Price = 1500, Level = 105},
				{Price = 2500, Level = 115},
				{Price = 4000, Level = 120},
				{Price = 4000, Level = 130},},
		Accuracy = {{Price = 100, Level = 0.04},
				{Price = 1500, Level = 0.03},
				{Price = 1500, Level = 0.02},},
		ClipSize = {{Price = 100, Level = 6},},
		FiringSpeed = {{Price = 100, Level = 0.8},
				{Price = 1400, Level = 0.7},
				{Price = 1400, Level = 0.6},
				{Price = 1400, Level = 0.5},},
		ReloadSpeed = {{Price = 400, Level = 2.5},
				{Price = 1000, Level = 2.3},},
	},
}

----- SMGS

GM.Weapons["item_p90"] = {
	Weapon = "weapon_p90_re",
	Item = "item_p90",
	AmmoTypes = {{item = "item_ammo_smg",Icon = "gui/ammo/machinegun"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = 0.75,
	IMultiplier = 0.7,
	UpGrades = {
		Power = {{Price = 300, Level = 14},
				{Price = 1500, Level = 17},
				{Price = 2500, Level = 20},
				{Price = 4000, Level = 23}},
		Accuracy = {{Price = 600, Level = 0.11},
				{Price = 1500, Level = 0.095},
				{Price = 3000, Level = 0.08},},
		ClipSize = {{Price = 100, Level = 50},
				{Price = 1300, Level = 55},
				{Price = 2000, Level = 65},
				{Price = 2600, Level = 70}},
		FiringSpeed = {{Price = 400, Level = 0.13},
				{Price = 1400, Level = 0.11},
				{Price = 2200, Level = 0.09},
				{Price = 3100, Level = 0.07}},
		ReloadSpeed = {{Price = 400, Level = 4.0},
				{Price = 400, Level = 3.8},
				{Price = 400, Level = 3.6},
				{Price = 400, Level = 3.4},},
	},
}

GM.Weapons["item_mp5"] = {
	Weapon = "weapon_mp5_re",
	Item = "item_mp5",
	AmmoTypes = {{item = "item_ammo_smg",Icon = "gui/ammo/machinegun"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = 0.75,
	IMultiplier = 0.75,
	UpGrades = {
		Power = {{Price = 300, Level = 19},
				{Price = 1500, Level = 22},
				{Price = 2500, Level = 24},
				{Price = 4000, Level = 27}},
		Accuracy = {{Price = 600, Level = 0.10},
				{Price = 1500, Level = 0.09},
				{Price = 3000, Level = 0.08},
				{Price = 3000, Level = 0.07},},
		ClipSize = {{Price = 100, Level = 30},
				{Price = 1300, Level = 35},
				{Price = 2000, Level = 40},
				{Price = 2600, Level = 45}},
		FiringSpeed = {{Price = 400, Level = 0.15},
				{Price = 1400, Level = 0.12},
				{Price = 2200, Level = 0.1},
				{Price = 3100, Level = 0.09}},
		ReloadSpeed = {{Price = 400, Level = 3.8},
				{Price = 400, Level = 3.6},},
	},
}

GM.Weapons["item_ump"] = {
	Weapon = "weapon_ump_re",
	Item = "item_ump",
	AmmoTypes = {{item = "item_ammo_smg",Icon = "gui/ammo/machinegun"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = 0.75,
	IMultiplier = 0.75,
	UpGrades = {
		Power = {{Price = 300, Level = 23},
				{Price = 1500, Level = 25},
				{Price = 2500, Level = 28},},
		Accuracy = {{Price = 600, Level = 0.11},
				{Price = 1500, Level = 0.09},
				{Price = 3000, Level = 0.07},},
		ClipSize = {{Price = 100, Level = 25},
				{Price = 1300, Level = 30},
				{Price = 2000, Level = 35},
				{Price = 2600, Level = 40},
				{Price = 2600, Level = 45},
				{Price = 2600, Level = 50},},
		FiringSpeed = {{Price = 400, Level = 0.2},
				{Price = 1400, Level = 0.18},
				{Price = 2200, Level = 0.15},
				{Price = 3100, Level = 0.11}},
		ReloadSpeed = {{Price = 400, Level = 3.9},
				{Price = 400, Level = 3.8},
				{Price = 400, Level = 3.6},
				{Price = 400, Level = 3.4},},
	},
}

------- Assualt Rifles
GM.Weapons["item_m4"] = {
	Weapon = "weapon_m4_re",
	Item = "item_m4",
	AmmoTypes = {{item = "item_ammo_rifle",Icon = "gui/ammo/rifle"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = 0.75,
	IMultiplier = 0.75,
	UpGrades = {
		Power = {{Price = 300, Level = 27},
				{Price = 1500, Level = 29},
				{Price = 2500, Level = 30},
				{Price = 4000, Level = 32}},
		Accuracy = {{Price = 600, Level = 0.08},
				{Price = 1500, Level = 0.06},
				{Price = 3000, Level = 0.05},
				{Price = 3000, Level = 0.04},},
		ClipSize = {{Price = 100, Level = 30},
				{Price = 1300, Level = 35},
				{Price = 2000, Level = 40},
				{Price = 2600, Level = 45}},
		FiringSpeed = {{Price = 400, Level = 0.17},
				{Price = 1400, Level = 0.14},
				{Price = 2200, Level = 0.1},
				{Price = 3100, Level = 0.08}},
		ReloadSpeed = {{Price = 400, Level = 4.2},
				{Price = 400, Level = 4.0},
				{Price = 400, Level = 3.8},},
	},
}

GM.Weapons["item_ak47"] = {
	Weapon = "weapon_ak47_re",
	Item = "item_ak47",
	AmmoTypes = {{item = "item_ammo_rifle",Icon = "gui/ammo/rifle"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = 0.75,
	IMultiplier = 0.75,
	UpGrades = {
		Power = {{Price = 300, Level = 30},
				{Price = 1500, Level = 34},
				{Price = 2500, Level = 36},
				{Price = 4000, Level = 38},
				{Price = 5000, Level = 48},},
		Accuracy = {{Price = 600, Level = 0.16},
				{Price = 1500, Level = 0.15},
				{Price = 3000, Level = 0.13},
				{Price = 3500, Level = 0.10},
				{Price = 4000, Level = 0.07},
				{Price = 5000, Level = 0.06},},
		ClipSize = {{Price = 100, Level = 30},
				{Price = 1300, Level = 35},},
		FiringSpeed = {{Price = 400, Level = 0.18},
				{Price = 1400, Level = 0.15},
				{Price = 2200, Level = 0.11},},
		ReloadSpeed = {{Price = 400, Level = 4.3},
				{Price = 400, Level = 4.1},
				{Price = 400, Level = 4.0},},
	},
}

GM.Weapons["item_aug"] = {
	Weapon = "weapon_aug_re",
	Item = "item_aug",
	AmmoTypes = {{item = "item_ammo_rifle",Icon = "gui/ammo/rifle"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = 0.75,
	IMultiplier = 0.6,
	UpGrades = {
		Power = {{Price = 300, Level = 28},
				{Price = 1500, Level = 30},
				{Price = 2500, Level = 32},
				{Price = 4000, Level = 33}},
		Accuracy = {{Price = 600, Level = 0.09},
				{Price = 1500, Level = 0.08},
				{Price = 3000, Level = 0.06},
				{Price = 3000, Level = 0.05},},
		ClipSize = {{Price = 100, Level = 30},
				{Price = 1300, Level = 35},
				{Price = 2000, Level = 40},
				{Price = 2600, Level = 45}},
		FiringSpeed = {{Price = 400, Level = 0.2},
				{Price = 1400, Level = 0.16},
				{Price = 2200, Level = 0.13},
				{Price = 3100, Level = 0.1}},
		ReloadSpeed = {{Price = 400, Level = 4.0},
				{Price = 400, Level = 3.9},},
	},
}

----- Shotgun(s)

GM.Weapons["item_pumpshot"] = {
	Weapon = "weapon_pumpshot_re",
	Item = "item_pumpshot",
	AmmoTypes = {{item = "item_ammo_buckshot",Icon = "gui/ammo/buckshot"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	NumShots = 8,
	Recoil = 0.75,
	IMultiplier = 0.7,
	UpGrades = {
		Power = {{Price = 300, Level = 8},
				{Price = 1500, Level = 11},
				{Price = 2500, Level = 13},
				{Price = 4000, Level = 15}},
		Accuracy = {{Price = 600, Level = 0.18},},
		ClipSize = {{Price = 100, Level = 6},
				{Price = 1300, Level = 7},
				{Price = 2000, Level = 8},
				{Price = 2600, Level = 9},
				{Price = 2600, Level = 10},},
		FiringSpeed = {{Price = 400, Level = 1},
				{Price = 1400, Level = 0.8},
				{Price = 2200, Level = 0.6},},
		ReloadSpeed = {{Price = 400, Level = .8},
				{Price = 400, Level = .7},
				{Price = 400, Level = .6},
				{Price = 400, Level = .5},},
	},
}

GM.Weapons["item_striker7"] = {
	Weapon = "weapon_striker7_re",
	Item = "item_striker7",
	AmmoTypes = {{item = "item_ammo_buckshot",Icon = "gui/ammo/buckshot"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	NumShots = 10,
	Recoil = 0.75,
	IMultiplier = 0.7,
	UpGrades = {
		Power = {{Price = 300, Level = 9},
				{Price = 1500, Level = 10},
				{Price = 2500, Level = 11},
				{Price = 4000, Level = 12},
				{Price = 4000, Level = 13},},
		Accuracy = {{Price = 600, Level = 0.13},},
		ClipSize = {{Price = 100, Level = 8},
				{Price = 1300, Level = 9},
				{Price = 2000, Level = 10},
				{Price = 2600, Level = 11},
				{Price = 2600, Level = 12},
				{Price = 2600, Level = 13},
				{Price = 2600, Level = 14},},
		FiringSpeed = {{Price = 400, Level = 1},
				{Price = 1400, Level = 0.9},},
		ReloadSpeed = {{Price = 400, Level = 1.2},
				{Price = 400, Level = 1.1},
				{Price = 400, Level = 1.0},
				{Price = 400, Level = 0.9},
				{Price = 400, Level = 0.8},},
	},
}

GM.Weapons["item_spas12"] = {
	Weapon = "weapon_spas12_re",
	Item = "item_spas12",
	AmmoTypes = {{item = "item_ammo_buckshot",Icon = "gui/ammo/buckshot"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	NumShots = 6,
	UpGrades = {
		Power = {{Price = 300, Level = 14},
				{Price = 1500, Level = 16},
				{Price = 2500, Level = 18},},
		Accuracy = {{Price = 600, Level = 0.22},},
		ClipSize = {{Price = 100, Level = 12},
				{Price = 1300, Level = 13},
				{Price = 2000, Level = 14},},
		FiringSpeed = {{Price = 400, Level = .6},
				{Price = 1400, Level = 0.5},
				{Price = 2200, Level = 0.4},},
		ReloadSpeed = {{Price = 400, Level = 1.0},
				{Price = 400, Level = .9},
				{Price = 400, Level = .8},},
	},
}

----------- Snipers

GM.Weapons["item_awp"] = {
	Weapon = "weapon_awp_re",
	Item = "item_awp",
	AmmoTypes = {{item = "item_ammo_sniper",Icon = "gui/ammo/sniper"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = .6,
	IMultiplier = 0.004,
	UpGrades = {
		Power = {{Price = 100, Level = 100},
				{Price = 1500, Level = 125},
				{Price = 2500, Level = 135},},
		Accuracy = {{Price = 100, Level = 0.001},},
		ClipSize = {{Price = 100, Level = 6},
				{Price = 1300, Level = 7},
				{Price = 2000, Level = 8},
				{Price = 2600, Level = 9},},
		FiringSpeed = {{Price = 100, Level = 1.0},
				{Price = 1400, Level = 0.9},
				{Price = 2000, Level = 0.8},
				{Price = 3000, Level = 0.7},},
		ReloadSpeed = {{Price = 400, Level = 2.3},
				{Price = 1000, Level = 2.2},
				{Price = 2000, Level = 2.1}},
	},
}

GM.Weapons["item_scout"] = {
	Weapon = "weapon_scout_re",
	Item = "item_scout",
	AmmoTypes = {{item = "item_ammo_sniper",Icon = "gui/ammo/sniper"}},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	Recoil = .4,
	IMultiplier = 0.008,
	UpGrades = {
		Power = {{Price = 100, Level = 95},
				{Price = 1500, Level = 110},
				{Price = 2500, Level = 125},
				{Price = 4000, Level = 130},},
		Accuracy = {{Price = 100, Level = 0.002},},
		ClipSize = {{Price = 100, Level = 11},
				{Price = 1300, Level = 12},
				{Price = 2000, Level = 13},
				{Price = 2600, Level = 14},
				{Price = 3600, Level = 15},},
		FiringSpeed = {{Price = 100, Level = .8},
				{Price = 1400, Level = 0.7},
				{Price = 2000, Level = 0.6},
				{Price = 3000, Level = 0.5},
				{Price = 3000, Level = 0.4},},
		ReloadSpeed = {{Price = 400, Level = 2.2},
				{Price = 1000, Level = 2.1},
				{Price = 2000, Level = 2.0},
				{Price = 3000, Level = 1.9},},
	},
}

----------- Power Weapons

GM.Weapons["item_m79"] = {
	Weapon = "weapon_m79_re",
	Item = "item_m79",
	AmmoTypes = {{item = "item_ammo_gl_explosive",Icon = "gui/ammo/explosive"},{item = "item_ammo_gl_flame",Icon = "gui/ammo/flame"},{item = "item_ammo_gl_freeze",Icon = "gui/ammo/ice"},},
	Position = Vector(-3, 0, 3.5),
	Angle = Angle(0, 180, 0),
	UpGrades = {
		Power = {{Price = 0, Level = 75},},
		Accuracy = {{Price = 0, Level = 0.10},},
		ClipSize = {{Price = 0, Level = 1},},
		FiringSpeed = {{Price = 0, Level = 1},},
		ReloadSpeed = {{Price = 400, Level = 1.5},},
	},
	Size = 2,
}

GM.Weapons["item_quadrpg"] = {
	Weapon = "weapon_Quad_re",
	Item = "item_quadrpg",
	AmmoTypes = {{item = "item_ammo_rocket",Icon ="gui/ammo/rocket"}},
	UpGrades = {
		Power = {{Price = 5, Level = 100},},
		Accuracy = {{Price = 5, Level = 0.10},},
		ClipSize = {{Price = 5, Level = 4 },},
		FiringSpeed = {{Price = 0, Level = 1},},
		ReloadSpeed = {{Price = 400, Level = 1.5},},
	},
	Size = 2,
}
GM.Weapons["item_minigun"] = {
	Weapon = "weapon_minigun_re",
	Item = "item_minigun",
	AmmoTypes = {{item = "item_bandolier",Icon = "gui/ammo/minigun"}},
	UpGrades = {
		Power = {{Price = 0, Level = 50},
				{Price = 3500, Level = 55},
				{Price = 5500, Level = 60},
				{Price = 7000, Level = 65}},
		Accuracy = {{Price = 0, Level = 0.10},
				{Price = 2500, Level = 0.09},
				{Price = 3000, Level = 0.08},
				{Price = 4000, Level = 0.07},},
		ClipSize = {{Price = 0, Level = 200},},
		FiringSpeed = {{Price = 0, Level = 0.1},
				{Price = 1400, Level = 0.09},
				{Price = 2200, Level = 0.08},},
		ReloadSpeed = {{Price = 400, Level = 5},},
	},
	Size = 1,
}

GM.Weapons["item_physcannon"] = {
	Weapon = "weapon_physcannon",
	Item = "item_physcannon",
	AmmoTypes = {{item = nil,Icon = nil}},
	UpGrades = {
		Power = {{Price = 5, Level = 100},},
		Accuracy = {{Price = 5, Level = 0.10},},
		ClipSize = {{Price = 5, Level = 4 },},
		FiringSpeed = {{Price = 0, Level = 1},},
		ReloadSpeed = {{Price = 400, Level = 1.5},},
	},
	Size = 0,
}


--- Passive Weapons ( Makes it storable)

GM.Weapons["item_bandolier"] = {
	Weapon = nil,
	Item = "item_bandolier",
	AmmoTypes = {{item = nil,Icon = nil}},
	UpGrades = {
		Power = {{Price = 0, Level = 0},},
		Accuracy = {{Price = 0, Level = 0.10},},
		ClipSize = {{Price = 0, Level = 200},},
		FiringSpeed = {{Price = 0, Level = 0.1},},
		ReloadSpeed = {{Price = 400, Level = 5},},
	},
}
