function GM:ShowTeam( ply )
	if ply:Team() == TEAM_SPECTATOR || #ents.FindByClass("Re2_Merchant") == 0 || (GetGlobalString("Mode") == "Merchant" && ply:Team() == TEAM_HUNK ) then
		ply:ConCommand( "Re2_MerchantMenu" )
	end
end

function GM:ShowHelp( ply )
	ply:ConCommand( "ShowOptionsMenu" )
end

function GM:ShowSpare1( ply )
	if ply:Team() == TEAM_SPECTATOR || #ents.FindByClass("Re2_Chest") == 0 || (GetGlobalString("Mode") == "Merchant" && ply:Team() == TEAM_HUNK) then
		ply:ConCommand( "Re2_ChestMenu" )
	end
end

function GM:ShowSpare2( ply )
	ply:ConCommand( "Re2_VoteMenu" )
end
function GM:PlayerInitialSpawn(ply)
	--ply:SetNoCollideWithTeammates( true )

	ply:SetViewEntity(ply)

	ply.CanEarn = true

	ply:SetNWString("RE2_DisplayAmmotype", "CombineCannon")

	ply:SetNWInt("SpraysUsed",0)
	ply:SetNWInt("CuresUsed",0)
	ply:SetNWInt("TeammatesSprayedUsed",0)
	ply:SetNWInt("TeammatesCuredUsed",0)
	ply:SetNWInt("TeammatesSupplied",0)
	ply:SetNWInt("DamageTaken",0)
	ply:SetNWInt("DamageDealt",0)
	ply:SetNWInt("Infections",0)
	ply:SetNWInt("KnifeKills",0)
	ply:SetNWInt("HeadShots",0)

	if GAMEMODE.TEMP_DeadPlayers[ply:UniqueID()] || GAMEMODE.TEMP_DeadPlayers[ply:UniqueID()] == nil then
		ply:SetTeam(TEAM_HUNK)
	elseif !GAMEMODE.TEMP_DeadPlayers[ply:UniqueID()] then
		ply:SetTeam(TEAM_SPECTATOR)
		ply:Spectate( OBS_MODE_ROAMING )
	end

	ply:SetNWInt("Speed",165)

	GAMEMODE:Load(ply)
	timer.Simple(3,function()
		if GetGlobalString("Mode") != "Merchant" && ents.FindByClass("Re2_player_round_start") != nil then
			local randomspawnpoint = table.Random(ents.FindByClass("Re2_player_round_start"))
			ply:SetPos(randomspawnpoint:GetPos())
		end
	end)

	if GAMEMODE.Gamemode[GetGlobalString("Re2_Game")].JoinFunction != nil then
		GAMEMODE.Gamemode[GetGlobalString("Re2_Game")].JoinFunction(ply)
	end

end

function GM:PlayerSpawn(ply)

	if ply:Team() == TEAM_HUNK then
		ply:SetNWBool("Infected", false)
		ply:SetNWInt("InfectedPercent", 0)
		GAMEMODE:PlayerSetModel( ply )
		GAMEMODE:PlayerLoadout(ply)
		ply:SetNWInt("killcount",0)
		ply:SetNWInt("Time",0)
		ply:SetNWInt("MaxHP", 100)
		ply:SetNWInt("Immunity", 25)
		ply:AllowFlashlight(true)
	else
		ply:AllowFlashlight(false)
		if GetGlobalBool("Re2_Crows") then
			ply:BecomeCrow()
		else
			ply:Spectate( OBS_MODE_ROAMING )
		end
	end
	GAMEMODE:SetPlayerSpeed(ply,ply:GetNWInt("Speed"),ply:GetNWInt("Speed"))
	ply.CanUse = true
	GAMEMODE:SendDataToAClient(ply)
end

function GM:DoPlayerDeath(ply,attacker,dmginfo)
	ply:CreateRagdoll()

	ply:SetTeam(TEAM_SPECTATOR)

	ply:Freeze(false)

	ply.NextSpawnTime = CurTime() + 30
	ply.DeathTime = CurTime()

	for _,explosive in pairs(ents.FindByClass("item_base")) do
		if explosive:GetNWString("Class") == "item_c4" || explosive:GetNWString("Class") == "item_landmine" then
			if explosive.Owner == ply && explosive.Armed then
				explosive.Owner = nil
				explosive.Armed = nil
				explosive.Flare:Remove()
			end
		end
	end

	if ply:Team() == TEAM_SPECTATOR && GetGlobalBool("Re2_Crows") then
		SetGlobalInt("RE2_DeadZombies", GetGlobalInt("RE2_DeadZombies") + 1)
	end

	GAMEMODE:GameCheck()
end

function GM:CanPlayerSuicide( ply )
	--ply:PrintMessage(HUD_PRINTTALK, "You can't suicide!")
	return true
end


function GM:PlayerDeathThink( ply )

	if (  ply.NextSpawnTime && ply.NextSpawnTime > CurTime() ) then return end

	if ( ply:KeyPressed( IN_ATTACK ) || ply:KeyPressed( IN_ATTACK2 ) || ply:KeyPressed( IN_JUMP ) ) then
		ply:SetNWBool("Infected", false)
		ply:SetNWInt("InfectedPercent", 0)

		ply:DeathReward()

		ply:SetTeam(TEAM_SPECTATOR)
		ply:Spawn()
	end

end

function GM:PlayerLoadout(ply)
	for k,v in pairs(ply.RE2Data["Inventory"]) do
		for a,b in pairs(GAMEMODE.Weapons) do
			if v.Item == a && b.Weapon != nil then
				ply:Give(b.Weapon)
			end
		end
	end
	ply:Give("weapon_detonator_re")
	ply:Give("weapon_knife")
	ply:SelectWeapon("weapon_knife")
	for _,ammo in pairs(GAMEMODE.AmmoMax) do
		if _ != "none" then
			ply:GiveAmmo(ammo.number,tostring(_),true)
		end
	end
end

function GM:PlayerHurt(ply,attacker)
	if ply:Team() == TEAM_HUNK then
		if ply:Health() >= 51 and ply:Health() <= 74 then
			ply:SetNWInt("Speed",155)
		elseif ply:Health() >= 20 and ply:Health() <= 50 then
			ply:SetNWInt("Speed",145)
		elseif ply:Health() <= 19 then
			ply:SetNWInt("Speed",135)
		end
		if ply.CurSpeed == ply:GetNWInt("Speed") then
			GAMEMODE:SetPlayerSpeed(ply,ply:GetNWInt("Speed"),ply:GetNWInt("Speed"))
		end
	end
	if attacker:GetClass() == "snpc_shambler" then
		local ResistChance = math.random(1,100)
		if ResistChance >= ply:GetNWInt("Immunity") then
			if !ply:GetNWBool("Infected") then
				ply:EmitSound("HL1/fvox/biohazard_detected.wav",110,100)
				ply:SetNWBool("Infected",true)

				ply:AddStat("Infections",1)

				GAMEMODE:DoInfection(ply)
			end
		elseif ply:GetNWBool("Infected") == false then
			//ply:PrintMessage(HUD_PRINTTALK,"resisted infection")
		end
	elseif attacker:IsPlayer() && attacker:Team() == ply:Team() then
		return false
	end
end

function GM:SetPlayerSpeed( ply, walk, run )

	ply.CurSpeed = tonumber(walk)
	ply.Speeds = {Walk = walk, Run = walk, Sprint = run}
	ply:SetWalkSpeed( walk )
	ply:SetRunSpeed( run )

end


function GM:PlayerUse( ply, ent )
	if !ply.CanUse then return end
	if ply:Team() != TEAM_HUNK then return false end
		local pos = ply:GetShootPos()
		local ang = ply:GetAimVector()
		local tracedata = {}
		tracedata.start = pos
		tracedata.endpos = pos+(ang*80)
		tracedata.filter = ply
		local trace = util.TraceLine(tracedata)
		if trace.HitNonWorld && trace.Entity:GetClass() == "item_base" then
		   ent = trace.Entity
		end
	return true
end

function GM:PlayerDisconnected( ply )
	GAMEMODE:Save(ply)
	if GetGlobalString("Mode") == "On" then
		GAMEMODE.TEMP_DeadPlayers[ply:UniqueID()] = false
	end
	if GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].DisconnectFunction != nil then
		GAMEMODE.Gamemode[GetGlobalString("RE2_Game")].DisconnectFunction(ply)
	end
	GAMEMODE:GameCheck()
end

function GM:PlayerShouldTakeDamage(victim,attacker)
	if victim == attacker then return true end
		if attacker:IsPlayer() && victim:IsPlayer() && attacker:Team() == victim:Team()   then
			return false
		end
	if attacker:GetClass() == "env_explosion" && attacker.Owner != nil then
		if attacker.Suicidal && attacker.Owner != victim then
			return false
		elseif attacker.Suicidal && attacker.Owner == victim then
			return true
		elseif attacker.Owner == victim || (attacker.Owner:IsPlayer() && attacker.Owner:Team() == victim:Team())  then
			return false
		else
			return true
		end
	end
	return true
end

function GM:EntityTakeDamage( ent, dmginfo )

	if ( ent:IsPlayer() ) then
		ent:AddStat("DamageTaken",math.Round(dmginfo:GetDamage()))
	end

end
