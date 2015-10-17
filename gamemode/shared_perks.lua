-- Prices

SpecialUpgradesPrice = {}
SpecialUpgradesPrice["InventorySlot"] = {Inventorylevel = {},}
SpecialUpgradesPrice["InventorySlot"].Inventorylevel[1] = 5000
SpecialUpgradesPrice["InventorySlot"].Inventorylevel[2] = 15000


-- Perk List
PlayerPerk = {}
PlayerPerk[0] = {Name = "No Perk"}
PlayerPerk["perk_health"] = {
	Name = "Health Up",
	Desc = "You're max health increases by %15",
	AddFunction = function(ply) ply:SetNWInt("MaxHp", ply:GetNWInt("MaxHp") + 15) ply:SetHealth(ply:GetNWInt("MaxHp")) end,
	RemoveFunction = function(ply) ply:SetNWInt("MaxHp", ply:GetNWInt("MaxHp") - 15) ply:SetHealth(ply:GetNWInt("MaxHp")) end,
	Active = false,
	Price = 25000,
}
PlayerPerk["perk_invslot"] = {
	Name = "+Inventory Slot",
	Desc = "An Extra slot to store items is added.",
	AddFunction = function(ply) table.insert(ply.RE2Data["Inventory"],{Item = 0, Amount = 0})  end,
	RemoveFunction = function(ply) table.remove(ply.RE2Data["Inventory"], ply.RE2Data["Inventory"][table.Count(ply.RE2Data["Inventory"]) + 1]) end,
	Active = false,
	Price = 25000,
}
PlayerPerk["perk_speed"] = {
	Name = "Speed Up",
	Desc = "You have a %10 speed increase",
	AddFunction = function(ply) ply:SetNWInt("Speed", ply:GetNWInt("Speed") + 15 ) GAMEMODE:SetPlayerSpeed(ply,ply:GetNWInt("Speed"),ply:GetNWInt("Speed") )   end,
	RemoveFunction = function(ply) ply:SetNWInt("Speed", ply:GetNWInt("Speed") - 15 ) GAMEMODE:SetPlayerSpeed(ply,ply:GetNWInt("Speed"),ply:GetNWInt("Speed") ) end,
	Price = 25000, 
}
PlayerPerk["perk_immunity"] = {
	Name = "Immunity",
	Desc = "You Can't become infected",
	AddFunction = function(ply) ply:SetNWInt("Immunity", 101 )    end,
	RemoveFunction = function(ply) ply:SetNWInt("Immunity", 101 ) end,
	Price = 10000, 
}