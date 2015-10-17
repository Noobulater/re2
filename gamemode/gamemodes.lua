function GM:EstablishRules()

	local FilePath = "RE2/Rules/Rules.txt"

	if file.Exists(FilePath, "DATA") then
		local NewRules = util.KeyValuesToTable(file.Read(FilePath))

		SetGlobalBool("Re2_Crows",tobool(NewRules["crows"]))
		SetGlobalBool("Re2_Classic",tobool(NewRules["classic"]))
		SetGlobalString("Re2_Difficulty",tostring(NewRules["difficulty"]))

		GAMEMODE.MerchantTime = tonumber(NewRules["merchanttime"])

		local NewGamemode = NewRules["gamemode"]
			if GAMEMODE.Gamemode[NewGamemode] != nil then
				SetGlobalString( "RE2_Game", NewGamemode)
			else
				local chance = math.random(1,3)
				if chance == 1 then
					SetGlobalString( "RE2_Game", "VIP" )
				else
					SetGlobalString( "RE2_Game", "Survivor" )
				end
			end
	else

		SetGlobalString("Re2_Difficulty","Easy")
		SetGlobalBool("Re2_Crows",false)
		SetGlobalBool("Re2_Classic",false)
		GAMEMODE.MerchantTime = 120

		local chance = math.random(1,3)
		if chance == 1 then
			SetGlobalString( "RE2_Game", "VIP" )
		else
			SetGlobalString( "RE2_Game", "Survivor" )
		end
	end

end

function GM:BasePrep()
	GAMEMODE:EstablishRules()

	SetGlobalInt("Re2_CountDown", GAMEMODE.MerchantTime)
	SetGlobalString( "Mode", "Merchant" )

	GAMEMODE:SelectMusic(GetGlobalString("Mode"))

	timer.Create("Re2_CountDowntimer",1,0, function()
		SetGlobalInt("Re2_CountDown", GetGlobalInt("Re2_CountDown") - 1)
		if GetGlobalInt("Re2_CountDown") <= 0 then
			if GAMEMODE.Gamemode[GetGlobalString("Re2_Game")].Condition != nil then
				if !GAMEMODE.Gamemode[GetGlobalString("Re2_Game")].Condition() then
					SetGlobalString("Re2_Game","Survivor")
				PrintMessage(HUD_PRINTTALK,"The condition for this gamemode wasn't met, It is now Survivor")
				end
			end
			if GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].PrepFunction() != nil then
				GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].PrepFunction()
			end
			for _,entity in pairs(ents.FindByName("RE2_Round_Merchant_End")) do
				if entity:IsValid() && entity != nil then
					entity:Fire( "Trigger" )
				end
			end
			for _,ply in pairs(player.GetAll()) do
				for _,spawnpoint in pairs(ents.FindByClass("Re2_player_round_start")) do
					if !spawnpoint.Taken then
						ply:SetPos(spawnpoint:GetPos())
						spawnpoint.Taken = true
						break
					end
				end
			end
			timer.Destroy("Re2_CountDowntimer")
		end
	end)

	for k,v in pairs(ents.FindByClass("snpc_zombie")) do
		v:Remove()
	end

end

function GM:BaseStart()
	GAMEMODE:GamemodeStart()
	GAMEMODE:GameCheck()

	SetGlobalString( "Mode", "On" )
	GAMEMODE:SelectMusic(GetGlobalString("Mode"))

	for _,ply in pairs(player.GetAll()) do
		for _,ammo in pairs(GAMEMODE.AmmoMax) do
			if _ == "StriderMinigun" && inv_HasItem(ply,"item_bandolier") then
				ply:GiveAmmo(ammo.number - ply:GetAmmoCount(tostring(_)),tostring(_),true)
			elseif _ != "none" && _ != "RPG_Round" && _ != "StriderMinigun" then
				ply:GiveAmmo(ammo.number - ply:GetAmmoCount(tostring(_)),tostring(_),true)
			end
		end
	end

	timer.Create("SpawningZombies",1,0, function()
	GAMEMODE.Int_SpawnCounter = GAMEMODE.Int_SpawnCounter + 1
		if GAMEMODE.Int_SpawnCounter >= GAMEMODE.ZombieData[GetGlobalString("RE2_Difficulty")].ZombieSpawnRate[GAMEMODE.int_DifficultyLevel] then
			GAMEMODE.Int_SpawnCounter = 0
			if #ents.FindByClass("snpc_zombie") + #ents.FindByClass("snpc_zombie_crimzon") >= (#player.GetAll() * 2)+20 then
				return
			end
			GAMEMODE:SpawningZombies()
			return
		end
	end )

	---- map Triggers
	for _,entity in pairs(ents.FindByName("RE2_Round_Start")) do
		if entity:IsValid() && entity != nil then
			entity:Fire( "Trigger" )
		end
	end
end

function GM:BaseEndGame()
	--if 1 == 1 then return end
	if GetGlobalString("Mode") == "End" then return end

	GAMEMODE:GamemodeEnd()

	SetGlobalString( "Mode", "End" )
	GAMEMODE:SelectMusic(GetGlobalString("Mode"))

	timer.Simple(3,function()
		for _,ply in pairs(player.GetAll()) do
			timer.Simple(2, function() ply:ConCommand("Re2_VoteMenu_vote") end)
			GAMEMODE:Save(ply)
		end
	end)
	timer.Simple(55,function()
		for _,ply in pairs(player.GetAll()) do
			GAMEMODE:Save(ply)
		end
		GAMEMODE:DecideVotes()
	end)
end


function GM:GameCheck()
	if GetGlobalString("Mode") == "End" then return end

	GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].CheckFunction()

end

function GM:GamemodeStart()

	GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].StartFunction()

end

function GM:GamemodeEnd()

	GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].EndFunction()
	GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].RewardFunction()

end



function GM:GamemodeDifficulty()
	local Amount = math.Round(GetGlobalInt("RE2_GameTime")/60)
	if Amount <= 0 then
		GAMEMODE.int_DifficultyLevel = 1
		for _,ply in pairs(team.GetPlayers(TEAM_SPECTATORS)) do
			ply:BecomeCrow()
		end
	elseif Amount >= 10 then
		GAMEMODE.int_DifficultyLevel = 1
		timer.Destroy("Re2_DifficultyTimer")
	elseif  Amount < 10 && Amount > 0 then
		GAMEMODE.int_DifficultyLevel = Amount
		if 	GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].DifficultyFunction != nil then
			GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].DifficultyFunction()
		else
			table.insert(GAMEMODE.ZombieData.Zombies,"snpc_zombie_crimzon")
		end
	end
end
