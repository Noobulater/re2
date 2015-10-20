AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("shared_items.lua")
AddCSLuaFile("shared_maplists.lua")
AddCSLuaFile("shared_perks.lua")
AddCSLuaFile("shared_weapons.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_voting.lua")
AddCSLuaFile("cl_scoreboard.lua")
AddCSLuaFile("cl_shop.lua")
AddCSLuaFile("cl_inventory.lua")
AddCSLuaFile("cl_chests.lua")
include("shared.lua")
include("shared_items.lua")
include("shared_maplists.lua")
include("shared_perks.lua")
include("shared_weapons.lua")
include("player.lua")
include("inventory.lua")
include("gamemodes.lua")
include("Chests.lua")
include("Voting.lua")
include("player_ext.lua")

resource.AddWorkshop("536391334")
resource.AddWorkshop("537154308")

-- DataStreams
function GM:inv_UpdateSlot(ply,str_Item,int_Slot,int_Amount)
	umsg.Start("RE2_UpdateSlot", ply)
	umsg.Long(int_Slot)
	umsg.String(str_Item)
	umsg.Long(int_Amount)
	umsg.End()
end
function GM:inv_UpdateWeaponStat(ply,str_Weapon,str_Stat,int_Level)
	umsg.Start("RE2_UpdateWeaponStat", ply)
	umsg.String(str_Weapon)
	umsg.String(str_Stat)
	umsg.Long(int_Level)
	umsg.End()
end
function GM:inv_UpdateChestSlot(ply,str_Item,int_slot)
	umsg.Start("RE2_UpdateChestSlot", ply)
	umsg.String(str_Item)
	umsg.Long(int_slot)
	umsg.String(tostring(ply.RE2Data["Chest"][int_slot].Upgrades.pwrlvl))
	umsg.String(tostring(ply.RE2Data["Chest"][int_slot].Upgrades.acclvl))
	umsg.String(tostring(ply.RE2Data["Chest"][int_slot].Upgrades.clplvl))
	umsg.String(tostring(ply.RE2Data["Chest"][int_slot].Upgrades.fislvl))
	umsg.String(tostring(ply.RE2Data["Chest"][int_slot].Upgrades.reslvl))
	umsg.End()
end


util.AddNetworkString( "InvTransfer" )

function InvTransfer( ply )
	ply = ply or player.GetAll()
	net.Start( "InvTransfer" )
		net.WriteTable(ply.RE2Data["Inventory"])
		net.WriteTable(ply.RE2Data["Upgrades"])
		net.WriteTable(ply.RE2Data["Chest"])
	net.Send( ply )
end

function GM:SendDataToAClient(ply)
	InvTransfer(ply)
end
concommand.Add("InvUpdate",
	function(ply,command,args)
	GAMEMODE:SendDataToAClient(ply)
	end)

game.ConsoleCommand("mp_falldamage 1\n")

function GM:Initialize()

	timer.Simple(5, function() GAMEMODE:UpdateMap() end)

	GAMEMODE.int_DifficultyLevel = 1
	GAMEMODE.int_NumZombies = 0
	GAMEMODE.TEMP_DeadPlayers = {}

	GAMEMODE.VotingMaps = {}
	GAMEMODE.VotingGamemodes = {}
	GAMEMODE.VotingCrows = {Votes = 0,Value = 0}
	GAMEMODE.VotingClassic = {Votes = 0,Value = 0}
	GAMEMODE.VotingDifficulty = {}
	GAMEMODE.VotingMerchantTime = {}
	GAMEMODE.VotingMerchantTime[180] = 0
	GAMEMODE.VotingMerchantTime[120] = 0
	GAMEMODE.VotingMerchantTime[60] = 0

	for k,v in pairs(GAMEMODE.Gamemode) do
		GAMEMODE.VotingGamemodes[tostring(k)] = 0
	end
	for k,v in pairs(GAMEMODE.MapListTable) do
		GAMEMODE.VotingMaps[k] = 0
	end
	for k,v in pairs(GAMEMODE.ZombieData) do
		GAMEMODE.VotingDifficulty[k] = 0
	end

	GAMEMODE.Int_Ragdolls = 0
	GAMEMODE.Int_SpawnCounter = 0

	SetGlobalString( "Music", "/reg/BattleGame.mp3")

	timer.Create("Re2_DifficultyTimer",60,0,function() GAMEMODE:GamemodeDifficulty() end )

	GAMEMODE:BasePrep()

	SetGlobalInt("RE2_GameTime", 0)
	SetGlobalInt("RE2_DeadZombies", 0)
end


function GM:UpdateMap()
	for k,v in pairs(ents.FindByClass("item_*")) do
		if v:GetClass() ==  "item_item_crate" then
			local itembase = ents.Create("reward_crate")
			itembase:Spawn()
			itembase:SetPos(v:GetPos())
			local keyvaluetable = v:GetKeyValues()
			if keyvaluetable.ItemCount != 0 then
				itembase.Amount = keyvaluetable.ItemCount
			else
				itembase.Amount = math.random(1,4)
			end
			print(keyvaluetable.ItemClass)
			if keyvaluetable.ItemClass == "item_pammo" then
				keyvaluetable.ItemClass = "item_ammo_pistol"
			elseif keyvaluetable.ItemClass == "item_mammo" then
				keyvaluetable.ItemClass = "item_ammo_smg"
			elseif keyvaluetable.ItemClass == "item_bammo" then
				keyvaluetable.ItemClass = "item_ammo_buckshot"
			elseif keyvaluetable.ItemClass == "item_rammo" then
				keyvaluetable.ItemClass = "item_ammo_rifle"
			end
			itembase.Item = tostring(keyvaluetable.ItemClass)
			v:Remove()
		end
	end
end

function GM:AddToTime(ply)
	if ply:Team() == TEAM_HUNK then
		if ply:Alive() then
			ply:SetNWInt("Time", ply:GetNWInt("Time") + 1)
		end
	end
end

function GM:DoInfection(ply)
	if ply:GetNWBool("Infected") && ply:Alive() && ply:GetNWInt("InfectedPercent") < 100 then
		local add = math.random(1,5)
		ply:SetNWInt("InfectedPercent",ply:GetNWInt("InfectedPercent") + add)
		timer.Simple(10,function() GAMEMODE:DoInfection(ply) end)
		if ply:GetNWInt("InfectedPercent") >= 100 then
			ply:Kill()
		end
	end
end




--SavingAndLoading

function GM:Save(ply)
	local str_Steam = string.Replace(ply:SteamID(),":",";")
	local path_FilePath = "re2/"..str_Steam.."/playerinfo.txt"
	local Savetable = {}
	Savetable["Money"] = ply:GetNWInt("Money")
	Savetable["Inventory"] = {}
	Savetable["Inventory"] = ply.RE2Data["Inventory"]
	Savetable["Upgrades"] = {}
	Savetable["Upgrades"] = ply.RE2Data["Upgrades"]
	Savetable["Chest"] = {}
	Savetable["Chest"] = ply.RE2Data["Chest"]
	local StrindedItems = util.TableToKeyValues(Savetable)
	if (!file.Exists("re2/"..str_Steam, "DATA")) then
		file.CreateDir("re2/"..str_Steam)
	end
	file.Write(path_FilePath,StrindedItems)
end

function GM:Load(ply)
	local str_Steam = string.Replace(ply:SteamID(),":",";")
	local path_FilePath = "re2/"..str_Steam.."/playerinfo.txt"
	ply.RE2Data = {}
	ply.RE2Data["Inventory"] = {	{Item = "none", Amount = 0},
		{Item = "none", Amount = 0},	{Item = "none", Amount = 0},	{Item = "none", Amount = 0},
		{Item = "none", Amount = 0},	{Item = "none", Amount = 0},}
	ply.RE2Data["Chest"] = {
		{Weapon = "none", Upgrades = {}},{Weapon = "none", Upgrades = {}},{Weapon = "none", Upgrades = {}},
		{Weapon = "none", Upgrades = {}},{Weapon = "none", Upgrades = {}},{Weapon = "none", Upgrades = {}},
		{Weapon = "none", Upgrades = {}},{Weapon = "none", Upgrades = {}},{Weapon = "none", Upgrades = {}},
		{Weapon = "none", Upgrades = {}},{Weapon = "none", Upgrades = {}},{Weapon = "none", Upgrades = {}},
		{Weapon = "none", Upgrades = {}},{Weapon = "none", Upgrades = {}},{Weapon = "none", Upgrades = {}},
		{Weapon = "none", Upgrades = {}},{Weapon = "none", Upgrades = {}},{Weapon = "none", Upgrades = {}},
		{Weapon = "none", Upgrades = {}},{Weapon = "none", Upgrades = {}},	}
	ply.RE2Data["Upgrades"] = {}

	ply.RE2Data["Stats"] = {}

	for _,weapon in pairs(GAMEMODE.Weapons) do
		ply.RE2Data["Upgrades"][_] = {}
		ply.RE2Data["Upgrades"][_] = {pwrlvl = 1, acclvl = 1, clplvl = 1, fislvl = 1,reslvl = 1}
	end


	if not file.Exists(path_FilePath, "DATA") then
		ply:SetNWInt("Money",500)
		inv_AddToInventory(ply,"item_9mmhandgun")
	elseif file.Exists(path_FilePath, "DATA") then
		local savetable = util.KeyValuesToTable(file.Read(path_FilePath) )
		local inv = savetable["inventory"]
		local muney = savetable["money"]
		local upg = savetable["upgrades"]
		local chestie = savetable["chest"]

		ply:SetNWInt("Money",tonumber(muney) )

		for k,v in pairs(inv) do
			if v["item"] != "none" then
				for i=1, v.amount do
					inv_AddToInventory(ply,v["item"])
				end
			end
		end
		ply.RE2Data["Upgrades"] = {}
		ply.RE2Data["Upgrades"] =  upg

		for k,v in pairs(chestie) do
			if v.weapon != "none" then
				ply.RE2Data["Chest"][tonumber(k)].Weapon = tostring(v.weapon)
				ply.RE2Data["Chest"][tonumber(k)].Upgrades = v["upgrades"]
				if v.weapon == 0 then
					ply.RE2Data["Chest"][tonumber(k)].Weapon = "none"
					ply.RE2Data["Chest"][tonumber(k)].Upgrades = {}
				end
			end
		end
	end
	GAMEMODE:SendDataToAClient(ply)
end

--SpawningZombies

GM.ZombieData.Zombies = {
	"snpc_zombie",
	"snpc_zombie",
	"snpc_zombie",
	"snpc_zombie",
	"snpc_zombie",
	"snpc_zombie",
	"snpc_zombie",
	"snpc_zombie_crimzon",
}
GM.ZombieDataslow = 7
GM.ZombieDatafast = 1

function GM:SpawningZombies()
	if GetGlobalString("Mode") == "On" then
		for j,h in pairs(ents.FindByClass("ent_zombie_spawn")) do
			if !h.Disabled then
				if #ents.FindByClass("snpc_shambler") < (#player.GetAll() * 2)+20 then
					local Blocked = false
					for k,v in pairs(ents.FindInSphere(h:GetPos(),100)) do
						if v:GetClass() == "snpc_shambler" then
							Blocked = true
						end
					end
					if !Blocked then
						local ent = ents.Create("snpc_shambler") --GAMEMODE.ZombieData.Zombies[math.random(1,#GAMEMODE.ZombieData.Zombies)])
						local min = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieHealth[GAMEMODE.int_DifficultyLevel]
						local max = GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieMaxHealth[GAMEMODE.int_DifficultyLevel]
						ent:SetHealth(math.random(min, max))
						ent:SetPos(h:GetPos())
						ent:Spawn()
						ent:SetModel(table.Random({
				        "models/nmr_zombie/berny.mdl",
				        "models/nmr_zombie/casual_02.mdl",
				        "models/nmr_zombie/herby.mdl",
				        "models/nmr_zombie/jogger.mdl",
				        "models/nmr_zombie/julie.mdl",
				        "models/nmr_zombie/toby.mdl",
				    }))
						ent:setAttackSpeed(GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieAttackSpeed[GAMEMODE.int_DifficultyLevel])
						if (math.random(0, GAMEMODE.ZombieDataslow + GAMEMODE.ZombieDatafast) > GAMEMODE.ZombieDataslow) then
							ent:setRunning(true)
							ent:setRunSpeed(ent:getRunSpeed() * math.random(GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieMinSpeed, GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieMaxSpeed))
						else
							ent:setWalkSpeed(ent:getWalkSpeed() * math.random(GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieMinSpeed, GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieMaxSpeed))
						end
					end
				end
			end
		end
	end
end

function GM:ScaleNPCDamage(npc,hitgroup,dmginfo)
   if hitgroup == 1 then
		dmginfo:ScaleDamage(3)
		if dmginfo:GetAttacker():IsPlayer() then
			dmginfo:GetAttacker():AddStat("HeadShots",1)
		end
	elseif hitgroup == 2 then
		dmginfo:ScaleDamage(2)
	elseif hitgroup == 3 then
		dmginfo:ScaleDamage(1.5)
   end
end



local function ShouldCollideTestHook( ent1, ent2 )
	if ( ent1:GetClass() == "snpc_shambler" and ent2:GetClass() == "snpc_shambler" ) then
		//if (ent1:getRunning() && !ent2:getRunning()) || (!ent1:getRunning() && ent2:getRunning()) then
			return false --Returning false makes the entities not collide with eachother
		//end
	elseif ent1:GetClass() == "Quad_Rocket" && ent2:IsPlayer() then
		return false
	elseif ent1:GetClass() == "m79_bomb" && ent2:IsPlayer() then
		return false
	end
	-- DO NOT RETURN TRUE HERE OR YOU WILL FORCE EVERY OTHER ENTITY TO COLLIDE
end
hook.Add( "ShouldCollide", "ShouldCollideTestHook", ShouldCollideTestHook )



function cadeEntityTakeDamage( ent, dmginfo )
	if IsValid(ent) then
		if ent.isCade then
			if dmginfo:GetAttacker():GetClass() == "player" then dmginfo:SetDamage(0) end
			if dmginfo:GetAttacker():GetClass() == "env_explosion" && dmginfo:GetAttacker().Owner:IsPlayer() then dmginfo:SetDamage(0) end
			ent:SetHealth(ent:Health() - dmginfo:GetDamage())
			if (dmginfo:GetAttacker():GetClass() == "snpc_shambler") then
				dmginfo:GetAttacker().times = dmginfo:GetAttacker().times/2
			end
			if ent:Health() <= 0 then
				ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
				ent.isCade = false
				if (dmginfo:GetAttacker():GetClass() == "snpc_*") then
						dmginfo:GetAttacker():findEnemy()
				end
				ent:GetPhysicsObject():EnableMotion(true)
				ent:GetPhysicsObject():Wake()
				if ent:GetPhysicsObject():IsDragEnabled() then
					ent:GetPhysicsObject():SetDragCoefficient(0.4)
				end
				ent:GetPhysicsObject():ApplyForceCenter(dmginfo:GetDamageForce())
			end
		end
	end
end
hook.Add("EntityTakeDamage", "cadeEntityTakeDamage", cadeEntityTakeDamage)
