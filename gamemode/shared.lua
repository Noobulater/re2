GM.Name 		= "Resident Evil Garrysmod"
GM.Author 		= "Noobulater"
GM.Email 		= ""
GM.Website 		= "www.shellshocked.net46.net"
GM.TeamBased 	= true

function GM:Initialize()
	SetGlobalString( "Mode", "Merchant" )
end

function GM:CreateTeams()
	TEAM_SPECTATOR = 0
	team.SetUp(TEAM_SPECTATOR,"The Unfortunate",Color(90,155,90,120))
	team.SetSpawnPoint(TEAM_SPECTATOR,"info_player_start")

	TEAM_HUNK = 1
	team.SetUp(TEAM_HUNK,"Survivors",Color(155,155,155,120))
	team.SetSpawnPoint(TEAM_HUNK,"info_player_start")
end

function GM:LoadNextMap()
	game.LoadNextMap()
end

function GM:Sort_Top_Stats()
	local OldAmount
	local infectionLeader = player.GetAll()[1]
	local knifeLeader = player.GetAll()[1]
	local teammateLeader = player.GetAll()[1]
	local damagetakenLeader = player.GetAll()[1]
	local leastdamagetakenLeader = player.GetAll()[1]
	local damagedealtLeader = player.GetAll()[1]
	local killsLeader = player.GetAll()[1]
	local headshotsLeader = player.GetAll()[1]
	for _,ply in pairs(player.GetAll()) do
		if infectionLeader != nil && ply != infectionLeader then
			if ply:GetNWInt("Infections") > infectionLeader:GetNWInt("Infections") then
				infectionLeader = ply
			end
		end
	end
	for _,ply in pairs(player.GetAll()) do
		if knifeLeader != nil && ply != knifeLeader then
			if ply:GetNWInt("KnifeKills") > knifeLeader:GetNWInt("KnifeKills") then
				knifeLeader = ply
			end
		end
	end
	for _,ply in pairs(player.GetAll()) do
		if teammateLeader != nil && ply != teammateLeader then
			teammateLeader = ply
			if ( ply:GetNWInt("TeammatesSprayed") + ply:GetNWInt("TeammatesCured") + ply:GetNWInt("TeammatesSupplied") )   >  ( teammateLeader:GetNWInt("TeammatesSprayed") + teammateLeader:GetNWInt("TeammatesCured") + teammateLeader:GetNWInt("TeammatesSupplied") ) then
				teammateLeader = ply
			end
		end
	end
	for _,ply in pairs(player.GetAll()) do
		if damagetakenLeader != nil && ply != damagetakenLeader then
			if ply:GetNWInt("DamageTaken") > damagetakenLeader:GetNWInt("DamageTaken") then
				damagetakenLeader = ply
			end
		end
	end
	for _,ply in pairs(player.GetAll()) do
		if leastdamagetakenLeader != nil && ply != leastdamagetakenLeader then
			if ply:GetNWInt("DamageTaken") < leastdamagetakenLeader:GetNWInt("DamageTaken") then
				leastdamagetakenLeader = ply
			end
		end
	end
	for _,ply in pairs(player.GetAll()) do
		if damagedealtLeader != nil && ply != damagedealtLeader then
			if ply:GetNWInt("DamageDealt") > damagedealtLeader:GetNWInt("DamageDealt") then
				damagedealtLeader = ply
			end
		end
	end
	for _,ply in pairs(player.GetAll()) do
		if damagedealtLeader != nil && ply != damagedealtLeader then
			if ply:GetNWInt("DamageDealt") > damagedealtLeader:GetNWInt("DamageDealt") then
				damagedealtLeader = ply
			end
		end
	end
	for _,ply in pairs(player.GetAll()) do
		if killsLeader != nil && ply != killsLeader then
			if ply:GetNWInt("killcount") > killsLeader:GetNWInt("killcount") then
				killsLeader = ply
			end
		end
	end
	for _,ply in pairs(player.GetAll()) do
		if headshotsLeader != nil && ply != headshotsLeader then
			if ply:GetNWInt("HeadShots") > headshotsLeader:GetNWInt("HeadShots") then
				headshotsLeader = ply
			end
		end
	end
	local returntable = {Infections = infectionLeader,
	KnifeKills = knifeLeader,
	Teamplayer = teammateLeader,
	damageTaken = damagetakenLeader,
	leastdamageTaken = leastdamagetakenLeader,
	damagedealt = damagedealtLeader,
	kills = killsLeader,
	headshots = headshotsLeader ,}
	return returntable
end

/*---------------------------------------------------------
   Name: gamemode:Move
   This basically overrides the NOCLIP, PLAYERMOVE movement stuff.
   It's what actually performs the move.
   Return true to not perform any default movement actions. (completely override)
---------------------------------------------------------*/
function GM:Move( ply, mv )
	if GetGlobalBool("Re2_Crows") then
		if ply:Team() != TEAM_HUNK && ply:GetMoveType() != MOVETYPE_WALK && ply:OnGround() then
			ply:SetMoveType(MOVETYPE_WALK)
			if SERVER then
				ply:SetAllowFullRotation(false)
				GAMEMODE:SetPlayerSpeed(ply,ply:GetNWInt("Speed"),ply:GetNWInt("Speed"))
			end
		elseif ply:Team() != TEAM_HUNK && ply:GetMoveType() != MOVETYPE_FLY && !ply:OnGround() then
			ply:SetMoveType(MOVETYPE_FLY)
			if SERVER then
				ply:SetAllowFullRotation(true)
				GAMEMODE:SetPlayerSpeed(ply,ply:GetNWInt("Speed")*3,ply:GetNWInt("Speed")*3)
			end
		end
		if ply:GetMoveType() == MOVETYPE_FLY && ply:Team() != TEAM_HUNK && ply:GetMoveType() != MOVETYPE_WALK then
			ply:SetVelocity(Vector(ply:GetVelocity().x * -0.1,ply:GetVelocity().y * -0.1, ply:GetVelocity().z * -0.1))
		end
	end
end


-- Everything Else

function GM:SelectMusic(Mode)
	if Mode == "prep" || Mode == "Merchant" then
		local music = table.Random(GAMEMODE.Music.Safe).Sound
		if SERVER then
			SetGlobalString( "Music", music)
			for _,ply in pairs(player.GetAll()) do
				umsg.Start("RE2_MakeTrack", ply)
				umsg.String(music)
				umsg.End()
			end
		end
	elseif Mode == "On" then
		local music = table.Random(GAMEMODE.Music.Battle).Sound
		if SERVER then
			SetGlobalString( "Music", music)
			for _,ply in pairs(player.GetAll()) do
				umsg.Start("RE2_MakeTrack", ply)
				umsg.String(music)
				umsg.End()
			end
		end
	elseif Mode == "End" then
		local music = table.Random(GAMEMODE.Music.End).Sound
		if SERVER then
			for _,ply in pairs(player.GetAll()) do
				umsg.Start("RE2_MakeTrack", ply)
				umsg.String(music)
				umsg.End()
			end
		end
	end
end

GM.Music = {
	Safe = {
				{Sound = "/reg/madexperiment.mp3", Length = 121},
				{Sound = "/reg/saveroomcvx.mp3", Length = 115},
				{Sound = "/reg/RE1saveroom.mp3", Length = 165},
				{Sound = "/reg/freefromfear.mp3", Length = 153},
			},
	Battle = {
				{Sound = "/reg/BattleGame.mp3", Length = 132},
				{Sound = "/reg/RE4merc.mp3", Length = 208},
				{Sound = "/reg/RE5merc.mp3", Length = 202},
				{Sound = "/reg/Malf.mp3", Length = 96},
				{Sound = "/reg/Alexia.mp3", Length = 275},
				{Sound = "/reg/Tofu_01.mp3", Length = 272},
			},
	End = {
			{Sound = "/reg/Results_01.mp3", Length = 120},
			},
	}

GM.MerchantSounds = {
	MerchantWelcome = {
		"reg/merchant/welcome.wav",
		"reg/merchant/whatayabuyin.wav",
	},

	MerchantBuy = {
		"reg/merchant/isthatall.wav",
		"reg/merchant/thankyou.wav",
	},

	MerchantLeave = {
		"reg/merchant/comebackanytime.wav",
	},

}

function GM:str_SelectRandomItem()
	local itemnumber = math.random(1,106)
	local itemtype = "item_ammo_pistol"
	if itemnumber == 1 then
		itemtype = "item_tcure"
	elseif (itemnumber >= 2 && itemnumber <= 4) then
		itemtype =  "item_spray"
	elseif (itemnumber >= 5 && itemnumber <= 20) then
		itemtype =  "item_ammo_pistol"
	elseif (itemnumber >= 21 && itemnumber <= 35) then
		itemtype =  "item_ammo_buckshot"
	elseif (itemnumber >= 36 && itemnumber <= 50) then
		itemtype =  "item_ammo_smg"
	elseif (itemnumber >= 51 && itemnumber <= 65) then
		itemtype =  "item_ammo_rifle"
	elseif (itemnumber >= 66 && itemnumber <= 75) then
		itemtype = "item_landmine"
	elseif (itemnumber >= 76 && itemnumber <= 85) then
		itemtype = "item_c4"
	elseif (itemnumber >= 86 && itemnumber <= 92) then
		itemtype = "item_ammo_magnum"
	elseif (itemnumber >= 93 && itemnumber <= 97) then
		itemtype = "item_ammo_rocket"
	elseif (itemnumber == 98 ) then
		itemtype = "item_ammo_gl_explosive"
	elseif (itemnumber == 99 ) then
		itemtype = "item_ammo_gl_flame"
	elseif (itemnumber == 100 ) then
		itemtype = "item_ammo_gl_freeze"
	elseif (itemnumber >= 101 && itemnumber <= 106 ) then
		itemtype = "item_ammo_sniper"
	end
	return itemtype
end



GM.ZombieData = {}


--[[GM.ZombieData["Easy"] = {
	ItemChance = {1,2,3,4,5,6,7,8,9,10},  Levels
	ZombieHealth = {1,2,3,4,5,6,7,8,9,10}, Levels
	ZombieMaxHealth = {1,2,3,4,5,6,7,8,9,10}, Levels
	ZombieAttackSpeed = {1,2,3,4,5,6,7,8,9,10}, Levels
}]]--

--[[	ItemChance = {32,34,36,38,40,50,60,75,80,90},
	ZombieHealth = {55,65,80,90,110,140,150,160,180,230},
	ZombieMaxHealth = {70,80,90,105,120,150,160,170,200,250},
	ZombieAttackSpeed = {2.5,2.5,2.5,2.5,3,3,3,4,5,5},
	ZombieMaxSpeed = 500,
	ZombieMinSpeed = 100,
	ZombieSpawnRate = {5,5,4,4,4,3,3,3,2,2},]]--
GM.ZombieData["Easy"] = {
	ItemChance = {36,40,48,65,80,100,110,125,140,150},
	ZombieHealth = {55,65,80,90,110,140,150,160,180,230},
	ZombieMaxHealth = {65,75,90,105,120,150,160,170,200,250},
	ZombieAttackSpeed = {2.5,2.5,2.5,2.5,3,3,3,4,5,5},
	ZombieMaxSpeed = 1,
	ZombieMinSpeed = 1,
	ZombieSpawnRate = {5,5,4,4,4,3,3,3,2,2},
	Modifier = 1, --- used for rewards and stuff.
	StartTime = 120,
}
GM.ZombieData["Normal"] = {
	ItemChance = {43,45,53,69,84,109,123,133,145,190},
	ZombieHealth = {65,75,85,95,120,150,160,170,190,240},
	ZombieMaxHealth = {75,85,95,110,135,165,180,190,210,250},
	ZombieAttackSpeed = {2.5,2.6,2.7,2.8,3,3.3,3.6,4.8,5.7},
	ZombieMaxSpeed = 2, -- these are divided by 100, making it 1.00. I use this for random speeds, It doesnt actually work, so don't worry about it
	ZombieMinSpeed = 1,
	ZombieSpawnRate = {5,4,4,4,3,3,2,2,2,1},
	Modifier = 2,
	StartTime = 90,
}
GM.ZombieData["Difficult"] = {
	ItemChance = {50,60,70,80,90,105,120,135,180,210},
	ZombieHealth = {85,95,115,125,140,155,175,190,215,270},
	ZombieMaxHealth = {95,105,115,130,150,165,190,210,230,300},
	ZombieAttackSpeed = {2.8,2.9,3,3.2,3.5,3.8,4.3,4.7,5.6},
	ZombieMaxSpeed = 2, --- the lower this is the faster they can be. It doesnt actually work, so don't worry about it
	ZombieMinSpeed = 1,
	ZombieSpawnRate = {4,4,4,3,3,3,2,2,1,1},
	Modifier = 3,
	StartTime = 60,
}
GM.ZombieData["Expert"] = {
	ItemChance = {50,63,76,90,140,160,170,210,280},
	ZombieHealth = {95,105,115,135,140,155,185,205,230,300},
	ZombieMaxHealth = {105,115,125,150,160,175,200,230,260,320},
	ZombieAttackSpeed = {3,3.4,3.7,4,4.5,4.8,5,5.4,6},
	ZombieMaxSpeed = 3,
	ZombieMinSpeed = 1,
	ZombieSpawnRate = {4,4,3,3,3,2,2,1,1,1},
	Modifier = 4,
	StartTime = 45,
}
GM.ZombieData["Suicidal"] = {
	ItemChance = {50,60,70,80,90,105,120,135,180,300},
	ZombieHealth = {100,110,120,130,140,150,160,170,180,190},
	ZombieMaxHealth = {100,140,165,190,210,235,250,270,310,320},
	ZombieAttackSpeed = {4,4.4,2,4.4,4.5,4.8,5,5.3,5.7,6,7},
	ZombieMaxSpeed = 3,
	ZombieMinSpeed = 2,
	ZombieSpawnRate = {3,3,2,2,1,1,1,1,1,1},
	Modifier = 5,
	StartTime = 30,
}

GM.AmmoMax = {}
GM.AmmoMax["pistol"] = {number = 110,icon = "gui/ammo/handgun"}
GM.AmmoMax["ar2"] = {number = 90,icon = "gui/ammo/rifle"}
GM.AmmoMax["357"] = {number = 60,icon = "gui/ammo/357"}
GM.AmmoMax["smg1"] = {number = 120,icon = "gui/ammo/machinegun"}
GM.AmmoMax["none"] = {number = 0,icon = ""}
GM.AmmoMax["buckshot"] = {number = 25,icon = "gui/ammo/buckshot"}
GM.AmmoMax["CombineCannon"] = {number = 6,icon = "gui/ammo/explosive"}
GM.AmmoMax["GaussEnergy"] = {number = 6,icon = "gui/ammo/flame"}
GM.AmmoMax["Battery"] = {number = 6,icon = "gui/ammo/ice"}
GM.AmmoMax["RPG_Round"] = {number = 4,icon = "gui/ammo/rocket"}
GM.AmmoMax["StriderMinigun"] = {number = 200,icon = "gui/ammo/minigun"}

GM.AmmoMax["XBowBolt"] = {number = 50,icon = "gui/ammo/sniper"}

GM.Ammoref = {}
GM.Ammoref["item_ammo_pistol"] = "pistol"
GM.Ammoref["item_ammo_magnum"] = "357"
GM.Ammoref["item_ammo_rifle"] = "ar2"
GM.Ammoref["item_ammo_smg"] = "smg1"
GM.Ammoref["item_ammo_buckshot"] = "buckshot"
GM.Ammoref["item_ammo_sniper"] = "XBowBolt"
GM.Ammoref["item_ammo_gl_explosive"] = "CombineCannon"
GM.Ammoref["item_ammo_gl_flame"] = "GaussEnergy"
GM.Ammoref["item_ammo_gl_freeze"] = "Battery"
GM.Ammoref["item_ammo_rocket"] = "RPG_Round"


--Game mode list
GM.Gamemode = {}
	GM.Gamemode["Survivor"] = {
		PrepFunction = function()

			SetGlobalString( "Mode", "prep" )
			GAMEMODE:SelectMusic(GetGlobalString("Mode"))

			SetGlobalInt("Re2_CountDown", 120)
			timer.Create("Re2_CountDowntimer_Survivor",1,0, function()
			SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
				if GetGlobalInt("Re2_CountDown") <= 0 then
					GAMEMODE:BaseStart()
					timer.Destroy("Re2_CountDowntimer_Survivor")
				end
			end	)
		end,

		StartFunction = function()
							for _,ply in pairs(player.GetAll()) do
								local modifier = math.Round(math.random(25,35) * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier/1.33)
								SetGlobalInt("DeadZombieKillNumber", GetGlobalInt("DeadZombieKillNumber") + modifier)
							end
					timer.Create("TimeSurvivedTimer",1,0, function()
							SetGlobalInt("RE2_GameTime", GetGlobalInt("RE2_GameTime") + 1)

							for _,ply in pairs(team.GetPlayers(TEAM_HUNK)) do
								ply:SetNWInt("Time",ply:GetNWInt("Time") + 1 )
							end

								if GetGlobalInt("RE2_DeadZombies") >= GetGlobalInt("DeadZombieKillNumber") && GetGlobalInt("Game") != "End" then
									timer.Destroy("TimeSurvivedTimer")
									GAMEMODE:BaseEndGame()
								end
							end )

						end,

		CheckFunction = function()
							if team.NumPlayers(TEAM_HUNK) <= 0 then
								GAMEMODE:BaseEndGame()
								return
							end
						end,

		EndFunction = function()
						if GetGlobalInt("RE2_DeadZombies") >= GetGlobalInt("DeadZombieKillNumber") then
							if table.Count(team.GetPlayers(TEAM_HUNK)) > 0 then
								for _,ply in pairs(player.GetAll()) do
									if ply:Team() == TEAM_HUNK then
										ply:SetNWBool("Infected", false)
										ply:SetNWInt("InfectedPercent", 0)

										ply:DeathReward()

									end
								end
							end
						end
					end,
		DifficultyFunction = function() -- Called Every 60 seconds
			if !GetGlobalBool("Re2_Classic") then
				GAMEMODE.ZombieDatafast = GAMEMODE.ZombieDatafast + 1
				//table.insert(GAMEMODE.ZombieData.Zombies,"snpc_zombie_crimzon")
			end
		end,
		RewardFunction = function()
				if GetGlobalInt("RE2_DeadZombies") >= GetGlobalInt("DeadZombieKillNumber") then
					if table.Count(team.GetPlayers(TEAM_HUNK)) > 0 then
						local reward = table.Count(team.GetPlayers(TEAM_HUNK)) * 70
						reward = reward * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier
						PrintMessage( HUD_PRINTTALK, "Surviving players won $"..reward.." for staying alive. Well done!" )
						for _,ply in pairs(player.GetAll()) do
							if ply:Team() == TEAM_HUNK then

							ply:SetNWInt("Money", ply:GetNWInt("Money") + reward )

							end
						end
					end
				end
		end,
		}


	GM.Gamemode["VIP"] = {

		Condition = function()
			if team.NumPlayers(TEAM_HUNK) <= 1 then
				return false
			end
			return true
		end,

		DisconnectFunction = function(ply)
				if GetGlobalString("Mode") != "End" then
					if GetGlobalEntity("Thevip") == ply && team.NumPlayers(TEAM_HUNK) > 1 then
						local hunks = team.GetPlayers(TEAM_HUNK)
						local VIP = team.GetPlayers(TEAM_HUNK)[math.random(1,#hunks)]
						SetGlobalEntity( "Thevip", VIP  )
						VIP:Give("weapon_physcannon")
					elseif team.NumPlayers(TEAM_HUNK) < 1 then
						GAMEMODE:BaseEndGame()
					end
				end
			end,
		PrepFunction = function()

			SetGlobalString( "Mode", "prep" )
			GAMEMODE:SelectMusic(GetGlobalString("Mode"))

			SetGlobalInt("Re2_CountDown", GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].StartTime)
			------------------Choose Vip
			SetGlobalEntity( "Thevip", ""  )
			local hunks = team.GetPlayers(TEAM_HUNK)
			local VIP = team.GetPlayers(TEAM_HUNK)[math.random(1,#hunks)]
			SetGlobalEntity( "Thevip", VIP  )
			VIP:Give("weapon_physcannon")

			timer.Create("Re2_CountDowntimer_Vip",1,0, function()
			SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
				if GetGlobalInt("Re2_CountDown") <= 0 then
					GAMEMODE:BaseStart()
					timer.Destroy("Re2_CountDowntimer_Vip")
				end

			end
			)
		end,

		StartFunction = function()
		SetGlobalInt("Re2_CountDown", 300 + (table.Count(team.GetPlayers(TEAM_HUNK)) * 60) )

		---------------------Set the Re2_CountDown
				timer.Create("Re2_CountDownVIP",1,0, function()

						SetGlobalInt("RE2_GameTime", GetGlobalInt("RE2_GameTime") + 1)
						SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
							for _,ply in pairs(team.GetPlayers(TEAM_HUNK)) do
								ply:SetNWInt("Time",ply:GetNWInt("Time") + 1 )
							end
							if GetGlobalInt("Re2_CountDown") <= 0 then
								timer.Destroy("Re2_CountDownVIP")
								GAMEMODE:BaseEndGame()
							end
					end)

		end,

		CheckFunction = function()
					if GetGlobalEntity("Thevip"):Team() != TEAM_HUNK && GetGlobalEntity("Thevip") != nil then
						GAMEMODE:BaseEndGame()
						return
					elseif GetGlobalEntity("Thevip") == nil then
						GAMEMODE:BaseEndGame()
					end
		end,

		EndFunction = function()
				for _,ply in pairs(player.GetAll()) do
					if ply:Team() == TEAM_HUNK then
						ply:SetNWBool("Infected", false)
						ply:SetNWInt("InfectedPercent", 0)

						ply:DeathReward()

					end
				end
				timer.Destroy("Re2_CountDowntimer")
			end,

			DifficultyFunction = function()
				if !GetGlobalBool("Re2_Classic") then
					GAMEMODE.ZombieDatafast = GAMEMODE.ZombieDatafast + 1
					//table.insert(GAMEMODE.ZombieData.Zombies,"snpc_zombie_crimzon")
				end
			end,

		RewardFunction = function()
			local leader = player.GetAll()[1]
			if GetGlobalEntity( "Thevip", VIP  ):Team() == TEAM_HUNK then
				local reward = math.Round((GetGlobalInt("RE2_DeadZombies") * math.Round(table.Count( player.GetAll())))/ 4)
				reward = reward * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier
				PrintMessage( HUD_PRINTTALK, "The Vip has survived! All players won $"..reward.." . Fine Work!" )
				for _,ply  in pairs(player.GetAll()) do
					ply:SetNWInt("Money",math.Round(ply:GetNWInt("Money")+ reward))
				end
			else
				PrintMessage( HUD_PRINTTALK, "The Vip has died, nobody is rewarded a special bonus." )
			end
		end,


		HudFunction = function(ply)
			if SERVER then return end
			local SW = ScrW()
			local SH = ScrH()
			local client = LocalPlayer()
			if GetGlobalString("RE2_Game") == "VIP" && GetGlobalString("Mode") != "Merchant" then
				if ply != GetGlobalEntity("Thevip") && GetGlobalEntity("Thevip"):Team() == TEAM_HUNK then
					local Vipcolor = Color(0,155,0,250)
					if GetGlobalEntity("Thevip"):Health() >= 75 then
							Vipcolor = Color(0,155,0,250)
						elseif GetGlobalEntity("Thevip"):Health() >= 51 and GetGlobalEntity("Thevip"):Health() <= 74 then
							Vipcolor = Color(155,155,0,250)
						elseif GetGlobalEntity("Thevip"):Health() >= 20 and GetGlobalEntity("Thevip"):Health() <= 50 then
							Vipcolor = Color(155,100,0,250)
						elseif GetGlobalEntity("Thevip"):Health() <= 19 then
							Vipcolor = Color(155,0,0,250)
						end
					local min,max,cen = GetGlobalEntity("Thevip"):LocalToWorld(GetGlobalEntity("Thevip"):OBBMins()), GetGlobalEntity("Thevip"):LocalToWorld(GetGlobalEntity("Thevip"):OBBMaxs()), GetGlobalEntity("Thevip"):LocalToWorld(GetGlobalEntity("Thevip"):OBBCenter())
					local minl,maxl,cenp = min:Distance(cen), max:Distance(cen), cen:ToScreen()
					local minp = (cen + (ply:GetRight() * (-1 * minl)) + (ply:GetUp() * (-1 * minl))):ToScreen()
					local maxp = (cen + (ply:GetRight() * maxl) + (ply:GetUp() * maxl)):ToScreen()
					if not cenp.visible then
						DrawTime = nil
					return end
					surface.SetDrawColor(Vipcolor)
					surface.DrawLine(minp.x,maxp.y,maxp.x,maxp.y)
					surface.DrawLine(minp.x,maxp.y,minp.x,minp.y)
					surface.DrawLine(minp.x,minp.y,maxp.x,minp.y)
					surface.DrawLine(maxp.x,maxp.y,maxp.x,minp.y)
					surface.SetDrawColor(255,255,255,155)
					surface.SetTextPos(minp.x+2,maxp.y-15)
					local text = "Protect This Player"
					surface.SetFont("DefaultSmall")
					surface.DrawText(text)
					surface.SetDrawColor(255,255,255,255)
					surface.SetTextPos(minp.x+2,maxp.y-15)
					surface.SetFont("Default")
					surface.DrawText(text)
				elseif ply == GetGlobalEntity("Thevip") && GetGlobalEntity("Thevip"):Team() == TEAM_HUNK then
					surface.SetFont("Trebuchet18o")
					local textx,texty = surface.GetTextSize("You are the Vip")
					draw.SimpleText("You are the Vip","Trebuchet18o",SW/2 - textx/2,SH - SH + 40,Color(255,255,255,255),0,0)
					DrawIcon(surface.GetTextureID("gui/silkicons/star" ),SW/2 - 8, SH - SH + 16 ,16,16)
				end
			end
		end,
		}

	GM.Gamemode["Mercenaries"] = {
		Condition = function()
			if team.NumPlayers(TEAM_HUNK) <= 1 then
				return false
			end
			return true
		end,

		PrepFunction = function()
			GAMEMODE:BaseStart()
		end,


		StartFunction = function()
			GAMEMODE.Zombies = {
			"snpc_zombie",
			"snpc_zombie_crimzon",
			"snpc_zombie_crimzon",
			"snpc_zombie_crimzon",
			"snpc_zombie_crimzon",
			"snpc_zombie_crimzon",
			"snpc_zombie_crimzon",
			"snpc_zombie_crimzon",
			}
			SetGlobalInt("Re2_CountDown", 120)
			timer.Create("Re2_CountDownMercenaries",1,0, function()
						SetGlobalInt("RE2_GameTime", GetGlobalInt("RE2_GameTime") + 1)
						SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
						if GetGlobalInt("Re2_CountDown") <= 0 then
							timer.Destroy("Re2_CountDownMercenaries")
							GAMEMODE:BaseEndGame()
							end
						end)
			end,

		CheckFunction = function()
			if team.NumPlayers(TEAM_HUNK) <= 0 then
				GAMEMODE:BaseEndGame()
				return
			end
		end,

		EndFunction = function()
			timer.Destroy("Re2_CountDownMercenaries")
		end,

		DifficultyFunction = function()
			if !GetGlobalBool("Re2_Classic") then
				GAMEMODE.ZombieDatafast = GAMEMODE.ZombieDatafast + 1
				//table.insert(GAMEMODE.ZombieData.Zombies,"snpc_zombie_crimzon")
			end
		end,

		RewardFunction = function()
			local leader = table.Random(player.GetAll())
			for _,ply in pairs(player.GetAll()) do
				if ply:GetNWInt("killcount") >= leader:GetNWInt("killcount")  && ply != leader then
					leader = ply
				end
					if ply:Team() == TEAM_HUNK then
						ply:SetNWBool("Infected", false)
						ply:SetNWInt("InfectedPercent", 0)

						ply:DeathReward()

					end
			end
			local reward = table.Count(player.GetAll())*150
			reward = reward * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier
			PrintMessage( HUD_PRINTTALK, leader:Nick().." won "..reward.." for getting the most kills. Well done!" )
			leader:SetNWInt("Money", leader:GetNWInt("Money") + (math.Round(table.Count(player.GetAll())*150)))
		end,
		}

	GM.Gamemode["Escape"] = {
		PrepFunction = function()
			GAMEMODE:BaseStart()
		end,

		StartFunction = function()
		timer.Create("TimeSurvivedTimer",1,0, function()
			SetGlobalInt("RE2_GameTime", GetGlobalInt("RE2_GameTime") + 1)
				for _,ply in pairs(team.GetPlayers(TEAM_HUNK)) do
					ply:SetNWInt("Time",ply:GetNWInt("Time") + 1 )
				end
			end)

		end,

		CheckFunction = function()
			if team.NumPlayers(TEAM_HUNK) <= 0 then
				GAMEMODE:BaseEndGame()
				return
			end
		end,

		EndFunction = function()

		end,
		DifficultyFunction = function()
			if !GetGlobalBool("Re2_Classic") then
				GAMEMODE.ZombieDatafast = GAMEMODE.ZombieDatafast + 1
				//table.insert(GAMEMODE.ZombieData.Zombies,"snpc_zombie_crimzon")
			end
		end,
		RewardFunction = function()
				if table.Count(team.GetPlayers(TEAM_HUNK)) > 0 then
				local reward = math.Round(GAMEMODE.MapListTable[game.GetMap()].Escape.Reward)
				if GAMEMODE.MapListTable[game.GetMap()].Escape.Split then
					reward = math.Round(GAMEMODE.MapListTable[game.GetMap()].Escape.Reward/#player.GetAll())
				end
				reward = reward * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier
				PrintMessage( HUD_PRINTTALK, "You Have Escaped! Surviving players won $"..reward.." for staying alive. Well done!" )
				if team.NumPlayers(TEAM_HUNK) > 1 then
					local additionalreward = math.Round((GAMEMODE.MapListTable[game.GetMap()].Escape.Reward/#player.GetAll())/team.NumPlayers(TEAM_HUNK)) * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier
					PrintMessage( HUD_PRINTTALK, team.NumPlayers(TEAM_HUNK).." out of "..#player.GetAll().." survivors survived, every survivor gets a bonus of $"..additionalreward.." for team-work!" )
				end
				for _,ply in pairs(player.GetAll()) do
					if ply:Team() == TEAM_HUNK then
						ply:SetNWBool("Infected", false)
						ply:SetNWInt("InfectedPercent", 0)

						ply:DeathReward()
						if team.NumPlayers(TEAM_HUNK) > 1 then
							additionalreward = math.Round((reward/#player.GetAll())/team.NumPlayers(TEAM_HUNK))
							ply:SetNWInt("Money",math.Round(ply:GetNWInt("Money")+ reward + additionalreward))
						else
							ply:SetNWInt("Money",math.Round(ply:GetNWInt("Money")+ reward ))
						end

					end
				end
			end
		end,
		}

	GM.Gamemode["Team_VIP"] = {
		Name = "Team VIP",
		Teams = true,
		Condition = function()
			if team.NumPlayers(TEAM_HUNK) <= 1 then
				return false
			end
			return true
		end,

		JoinFunction = function(ply)
			if GetGlobalString("Mode") != "Merchant" then
				if #Re2_Teams.StarsTeam <= #Re2_Teams.UmbrellaTeam then
					ply:SetNWInt("TeamId",1)
					table.insert(Re2_Teams.StarsTeam,ply)
				elseif #Re2_Teams.UmbrellaTeam <= #Re2_Teams.StarsTeam then
					ply:SetNWInt("TeamId",2)
					table.insert(Re2_Teams.StarsTeam,ply)
				end
			end
		end,

		DisconnectFunction = function(ply)
			if GetGlobalString("Mode") != "End" then
			if ply:GetNWInt("TeamId") == 1 then
				for key,data in pairs(Re2_Teams.StarsTeam) do
					if data == ply then
						table.remove(Re2_Teams.StarsTeam,key)
						break
					end
				end
			elseif ply:GetNWInt("TeamId") == 2 then
				for key,data in pairs(Re2_Teams.UmbrellaTeam) do
					if data == ply then
						table.remove(Re2_Teams.UmbrellaTeam,key)
						break
					end
				end
			end
				if GetGlobalEntity("Team01_VIP") == ply then
					local VIP = table.Random(Re2_Teams.StarsTeam)
					SetGlobalEntity( "Team01_VIP", VIP  )
					VIP:Give("weapon_physcannon")
				elseif GetGlobalEntity("Team02_VIP") == ply then
					local VIP = table.Random(Re2_Teams.UmbrellaTeam)
					SetGlobalEntity( "Team01_VIP", VIP  )
					VIP:Give("weapon_physcannon")
				end
			end
		end,

		PrepFunction = function()

			SetGlobalString( "Mode", "prep" )
			GAMEMODE:SelectMusic(GetGlobalString("Mode"))

			SetGlobalInt("Re2_CountDown", GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].StartTime)

			Re2_Teams = {StarsTeam = {},UmbrellaTeam = {} }

			local SelectablePlayers = team.GetPlayers(TEAM_HUNK)

			for _,player in pairs(team.GetPlayers(TEAM_HUNK)) do
				if #Re2_Teams.UmbrellaTeam < #Re2_Teams.StarsTeam then
					local playa = table.Random(SelectablePlayers)
					playa:SetNWInt("TeamId",2)
					table.insert(Re2_Teams.UmbrellaTeam,playa)
					for key,data in pairs(SelectablePlayers) do
						if data == playa then
							table.remove(SelectablePlayers,key)
							break
						end
					end
				elseif #Re2_Teams.StarsTeam < math.Round(#team.GetPlayers(TEAM_HUNK)/2) then
					local plya = table.Random(SelectablePlayers)
					plya:SetNWInt("TeamId",1)
					table.insert(Re2_Teams.StarsTeam,plya)
					for key,data in pairs(SelectablePlayers) do
						if data == plya then
							table.remove(SelectablePlayers,key)
							break
						end
					end
				end
			end

			------------------Choose Vip
			PrintTable(Re2_Teams.StarsTeam)

			local VIP = table.Random(Re2_Teams.StarsTeam)
			SetGlobalEntity( "Team01_VIP", VIP  )
			VIP:Give("weapon_physcannon")

			PrintTable(Re2_Teams.UmbrellaTeam)

			local VIP1 = table.Random(Re2_Teams.UmbrellaTeam)
			SetGlobalEntity( "Team02_VIP", VIP1  )
			VIP1:Give("weapon_physcannon")

			timer.Create("Re2_CountDowntimer_Vip",1,0, function()
			SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
				if GetGlobalInt("Re2_CountDown") <= 0 then

					GAMEMODE:BaseStart()
					timer.Destroy("Re2_CountDowntimer_Vip")
				end

			end
			)
		end,

		StartFunction = function()
		SetGlobalInt("Re2_CountDown", 300 + (table.Count(team.GetPlayers(TEAM_HUNK)) * 60) )

		---------------------Set the Re2_CountDown
				timer.Create("Re2_CountDown_TEAMVIP",1,0, function()

						SetGlobalInt("RE2_GameTime", GetGlobalInt("RE2_GameTime") + 1)
						SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
							for _,ply in pairs(team.GetPlayers(TEAM_HUNK)) do
								ply:SetNWInt("Time",ply:GetNWInt("Time") + 1 )
							end
							if GetGlobalInt("Re2_CountDown") <= 0 then
								timer.Destroy("Re2_CountDown_TEAMVIP")
								GAMEMODE:BaseEndGame()
							end
					end)

		end,

		CheckFunction = function()
					if GetGlobalEntity("Team01_VIP"):Team() != TEAM_HUNK  || GetGlobalEntity("Team02_VIP"):Team() != TEAM_HUNK then
						GAMEMODE:BaseEndGame()
						return
					end
		end,

		EndFunction = function()
				for _,ply in pairs(player.GetAll()) do
					if ply:Team() == TEAM_HUNK then
						ply:SetNWBool("Infected", false)
						ply:SetNWInt("InfectedPercent", 0)

						ply:DeathReward()

					end
				end

				local Starskills = 0
				local Umbrellakills = 0

				if GetGlobalEntity("Team01_VIP"):Team() != TEAM_HUNK && GetGlobalEntity("Team02_VIP"):Team() == TEAM_HUNK then
					SetGlobalString("Re2_TEAMVIP_Winner","Umbrella")
				elseif GetGlobalEntity("Team02_VIP"):Team() != TEAM_HUNK && GetGlobalEntity("Team01_VIP"):Team() == TEAM_HUNK then
					SetGlobalString("Re2_TEAMVIP_Winner","S.T.A.R.S")
				elseif GetGlobalEntity("Team01_VIP"):Team() == TEAM_HUNK && GetGlobalEntity("Team02_VIP"):Team() == TEAM_HUNK && GetGlobalEntity("Team01_VIP"):Health() > GetGlobalEntity("Team02_VIP"):Health() then
					SetGlobalString("Re2_TEAMVIP_Winner","S.T.A.R.S")
				elseif GetGlobalEntity("Team02_VIP"):Team() == TEAM_HUNK && GetGlobalEntity("Team01_VIP"):Team() == TEAM_HUNK && GetGlobalEntity("Team02_VIP"):Health() >= GetGlobalEntity("Team01_VIP"):Health() then
					SetGlobalString("Re2_TEAMVIP_Winner","Umbrella")
				else
					SetGlobalString("Re2_TEAMVIP_Winner","Umbrella")
				end
			timer.Destroy("Re2_CountDowntimer")
		end,

		DifficultyFunction = function()
			if !GetGlobalBool("Re2_Classic") then
				GAMEMODE.ZombieDatafast = GAMEMODE.ZombieDatafast + 1
				//table.insert(GAMEMODE.ZombieData.Zombies,"snpc_zombie_crimzon")
			end
		end,

		RewardFunction = function()

			local reward = math.Round((GetGlobalInt("RE2_DeadZombies") + #player.GetAll() * 60 + 300)  /4)
			reward = reward * GAMEMODE.ZombieData[GetGlobalString("Re2_Difficulty")].Modifier
			for _,ply  in pairs(player.GetAll()) do
				if ply:GetNWInt("TeamId") == 1 && GetGlobalString("Re2_TEAMVIP_Winner") == "S.T.A.R.S" then
					ply:SetNWInt("Money",math.Round(ply:GetNWInt("Money")+ reward))
				elseif ply:GetNWInt("TeamId") == 2 && GetGlobalString("Re2_TEAMVIP_Winner") == "Umbrella" then
					ply:SetNWInt("Money",math.Round(ply:GetNWInt("Money")+ reward))
				end
			end
			PrintMessage( HUD_PRINTTALK, "The "..GetGlobalString("Re2_TEAMVIP_Winner").." Team Won! They are awarded $"..reward.." each. Fine Work!" )
		end,

		HudFunction = function(ply)
				if SERVER then return end
				local SW = ScrW()
				local SH = ScrH()
				local client = LocalPlayer()
				if GetGlobalString("Mode") == "Merchant" then return end

				for _,ply in pairs(team.GetPlayers(TEAM_HUNK)) do
					if ply:GetNWInt("TeamId") == 1 && LocalPlayer() != ply && ply:GetPos():Distance(LocalPlayer():GetPos()) <= 400 then
						local pos = ply:LocalToWorld(ply:OBBCenter() + Vector(0,0,40)):ToScreen()
						DrawIcon(surface.GetTextureID("re2_teams/stars"),pos.x,pos.y,48,48 )
					elseif  ply:GetNWInt("TeamId") == 2 && LocalPlayer() != ply && ply:GetPos():Distance(LocalPlayer():GetPos()) <= 400 then
						local pos = ply:LocalToWorld(ply:OBBCenter() + Vector(0,0,40)):ToScreen()
						DrawIcon(surface.GetTextureID("re2_teams/umbrella"),pos.x,pos.y,48,48 )
					end
				end

				if GetGlobalString("Mode") == "End" then
					if GetGlobalString("Re2_TEAMVIP_Winner") == "Umbrella" then
						DrawIcon(surface.GetTextureID("re2_teams/umbrella" ),SW/2 - 150, SH/2 - 150 ,300,300)
						draw.SimpleText("Umbrella Wins","Trebuchet18o",SW/2 ,SH/2 + 150 + 10,Color(255,255,255,255),1,0)
					elseif GetGlobalString("Re2_TEAMVIP_Winner") == "S.T.A.R.S" then
						DrawIcon(surface.GetTextureID("re2_teams/stars" ),SW/2 - 123, SH/2 - 144 ,246,288)
						draw.SimpleText("S.T.A.R.S Wins","Trebuchet18o",SW/2,SH/2 + 144 + 10,Color(255,255,255,255),1,0)
					end
				end

				if ply:GetNWInt("TeamId") == 1 then
					DrawIcon(surface.GetTextureID("re2_teams/stars" ),SW/2 - 16, SH - SH + 8 ,32,32)
					if ply != GetGlobalEntity("Team01_VIP") && GetGlobalEntity("Team01_VIP"):Team() == TEAM_HUNK then
						local Vipcolor = Color(0,155,0,250)
						if GetGlobalEntity("Team01_VIP"):Health() >= 75 then
								Vipcolor = Color(0,155,0,250)
							elseif GetGlobalEntity("Team01_VIP"):Health() >= 51 and GetGlobalEntity("Team01_VIP"):Health() <= 74 then
								Vipcolor = Color(155,155,0,250)
							elseif GetGlobalEntity("Team01_VIP"):Health() >= 20 and GetGlobalEntity("Team01_VIP"):Health() <= 50 then
								Vipcolor = Color(155,100,0,250)
							elseif GetGlobalEntity("Team01_VIP"):Health() <= 19 then
								Vipcolor = Color(155,0,0,250)
							end
						local min,max,cen = GetGlobalEntity("Team01_VIP"):LocalToWorld(GetGlobalEntity("Team01_VIP"):OBBMins()), GetGlobalEntity("Team01_VIP"):LocalToWorld(GetGlobalEntity("Team01_VIP"):OBBMaxs()), GetGlobalEntity("Team01_VIP"):LocalToWorld(GetGlobalEntity("Team01_VIP"):OBBCenter())
						local minl,maxl,cenp = min:Distance(cen), max:Distance(cen), cen:ToScreen()
						local minp = (cen + (ply:GetRight() * (-1 * minl)) + (ply:GetUp() * (-1 * minl))):ToScreen()
						local maxp = (cen + (ply:GetRight() * maxl) + (ply:GetUp() * maxl)):ToScreen()
						if not cenp.visible then
							DrawTime = nil
						return end
						surface.SetDrawColor(Vipcolor)
						surface.DrawLine(minp.x,maxp.y,maxp.x,maxp.y)
						surface.DrawLine(minp.x,maxp.y,minp.x,minp.y)
						surface.DrawLine(minp.x,minp.y,maxp.x,minp.y)
						surface.DrawLine(maxp.x,maxp.y,maxp.x,minp.y)
						surface.SetDrawColor(255,255,255,155)
						surface.SetTextPos(minp.x+2,maxp.y-15)
						local text = "Protect This Player"
						surface.SetFont("DefaultSmall")
						surface.DrawText(text)
						surface.SetDrawColor(255,255,255,255)
						surface.SetTextPos(minp.x+2,maxp.y-15)
						surface.SetFont("Default")
						surface.DrawText(text)
					elseif ply == GetGlobalEntity("Team01_VIP") && GetGlobalEntity("Team01_VIP"):Team() == TEAM_HUNK then
						surface.SetFont("Trebuchet18o")
						local textx,texty = surface.GetTextSize("You are the Vip")
						draw.SimpleText("You are the Vip","Trebuchet18o",SW/2 - textx/2,SH - SH + 40,Color(255,255,255,255),0,0)
					end
				elseif ply:GetNWInt("TeamId") == 2 then
					DrawIcon(surface.GetTextureID("re2_teams/umbrella" ),SW/2 - 16, SH - SH + 8 ,32,32)
					if ply != GetGlobalEntity("Team02_VIP") && GetGlobalEntity("Team02_VIP"):Team() == TEAM_HUNK then
						DrawIcon(surface.GetTextureID("re2_teams/umbrella"),SW/2 - 16, SH - SH + 8 ,32,32)
						local Vipcolor = Color(0,155,0,250)
							if GetGlobalEntity("Team02_VIP"):Health() >= 75 then
								Vipcolor = Color(0,155,0,250)
							elseif GetGlobalEntity("Team02_VIP"):Health() >= 51 and GetGlobalEntity("Team02_VIP"):Health() <= 74 then
								Vipcolor = Color(155,155,0,250)
							elseif GetGlobalEntity("Team02_VIP"):Health() >= 20 and GetGlobalEntity("Team02_VIP"):Health() <= 50 then
								Vipcolor = Color(155,100,0,250)
							elseif GetGlobalEntity("Team02_VIP"):Health() <= 19 then
								Vipcolor = Color(155,0,0,250)
							end
						local min,max,cen = GetGlobalEntity("Team02_VIP"):LocalToWorld(GetGlobalEntity("Team02_VIP"):OBBMins()), GetGlobalEntity("Team02_VIP"):LocalToWorld(GetGlobalEntity("Team02_VIP"):OBBMaxs()), GetGlobalEntity("Team02_VIP"):LocalToWorld(GetGlobalEntity("Team02_VIP"):OBBCenter())
						local minl,maxl,cenp = min:Distance(cen), max:Distance(cen), cen:ToScreen()
						local minp = (cen + (ply:GetRight() * (-1 * minl)) + (ply:GetUp() * (-1 * minl))):ToScreen()
						local maxp = (cen + (ply:GetRight() * maxl) + (ply:GetUp() * maxl)):ToScreen()
						if not cenp.visible then
							DrawTime = nil
						return end
						surface.SetDrawColor(Vipcolor)
						surface.DrawLine(minp.x,maxp.y,maxp.x,maxp.y)
						surface.DrawLine(minp.x,maxp.y,minp.x,minp.y)
						surface.DrawLine(minp.x,minp.y,maxp.x,minp.y)
						surface.DrawLine(maxp.x,maxp.y,maxp.x,minp.y)
						surface.SetDrawColor(255,255,255,155)
						surface.SetTextPos(minp.x+2,maxp.y-15)
						local text = "Protect This Player"
						surface.SetFont("DefaultSmall")
						surface.DrawText(text)
						surface.SetDrawColor(255,255,255,255)
						surface.SetTextPos(minp.x+2,maxp.y-15)
						surface.SetFont("Default")
						surface.DrawText(text)
					elseif ply == GetGlobalEntity("Team02_VIP") && GetGlobalEntity("Team02_VIP"):Team() == TEAM_HUNK then
						surface.SetFont("Trebuchet18o")
						local textx,texty = surface.GetTextSize("You are the Vip")
						draw.SimpleText("You are the Vip","Trebuchet18o",SW/2 - textx/2,SH - SH + 40,Color(255,255,255,255),0,0)
					end
				end
			end,
		}
