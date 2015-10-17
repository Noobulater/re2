---------VOTING

util.AddNetworkString("VoteTransfer")

net.Receive("VoteTransfer", function(len, ply)
		if ply.Voted then
			GAMEMODE:RemoveVote(ply,ply.Voted)
		end
		local decoded = net.ReadTable()
		local VoteMap = decoded[1]
		local VoteGame = decoded[2]
		local VoteCrows = decoded[3]
		local VoteDifficulty = decoded[4]
		local VoteMerchantTime = decoded[5]
		local VoteClassic = decoded[6]

		local classicmessage = ""

		GAMEMODE.VotingMaps[tostring(VoteMap)] = GAMEMODE.VotingMaps[tostring(VoteMap)] + 1

		GAMEMODE.VotingCrows.Votes = GAMEMODE.VotingCrows.Votes + 1
		GAMEMODE.VotingClassic.Votes = GAMEMODE.VotingClassic.Votes + 1

		if tobool(VoteCrows) then
			GAMEMODE.VotingCrows.Value = GAMEMODE.VotingCrows.Value + 1
		end
		if tobool(VoteClassic) then
			GAMEMODE.VotingClassic.Value = GAMEMODE.VotingClassic.Value + 1
		end

		GAMEMODE.VotingDifficulty[tostring(VoteDifficulty)] = GAMEMODE.VotingDifficulty[tostring(VoteDifficulty)] + 1
		if VoteDifficulty == "Easy" then
			GAMEMODE.VotingDifficulty["Normal"] = GAMEMODE.VotingDifficulty["Normal"] + .4
		elseif VoteDifficulty == "Normal" then
			GAMEMODE.VotingDifficulty["Easy"] = GAMEMODE.VotingDifficulty["Easy"] + .4
			GAMEMODE.VotingDifficulty["Difficult"] = GAMEMODE.VotingDifficulty["Difficult"] + .4
		elseif VoteDifficulty == "Difficult" then
			GAMEMODE.VotingDifficulty["Normal"] = GAMEMODE.VotingDifficulty["Normal"] + .4
			GAMEMODE.VotingDifficulty["Expert"] = GAMEMODE.VotingDifficulty["Expert"] + .4
		elseif VoteDifficulty == "Expert" then
			GAMEMODE.VotingDifficulty["Difficult"] = GAMEMODE.VotingDifficulty["Difficult"] + .4
			GAMEMODE.VotingDifficulty["Suicidal"] = GAMEMODE.VotingDifficulty["Suicidal"] + .4
		elseif VoteDifficulty == "Suicidal" then
			GAMEMODE.VotingDifficulty["Expert"] = GAMEMODE.VotingDifficulty["Expert"] + .4
		end

		GAMEMODE.VotingMerchantTime[tonumber(VoteMerchantTime)] = GAMEMODE.VotingMerchantTime[tonumber(VoteMerchantTime)] + 1
		if tobool(VoteClassic) then
			classicmessage = "Classic-"
		end
		PrintMessage(HUD_PRINTTALK,ply:Nick().." Voted "..VoteDifficulty.." on "..VoteMap.." and gamemode "..classicmessage..VoteGame)

		for tablename,data in pairs(GAMEMODE.Gamemode) do
			if data.Name != nil && VoteGame == data.Name then
				VoteGame = tablename
			end
		end

		if VoteGame == "Team_VIP" then
			GAMEMODE.VotingGamemodes["VIP"] = GAMEMODE.VotingGamemodes["VIP"] + .5
		elseif VoteGame == "VIP" then
			GAMEMODE.VotingGamemodes["Team_VIP"] = GAMEMODE.VotingGamemodes["Team_VIP"] + .5
		end
		GAMEMODE.VotingGamemodes[tostring(VoteGame)] = GAMEMODE.VotingGamemodes[tostring(VoteGame)] + 1

		ply.Voted = {VoteMap,VoteGame,VoteCrows,VoteDifficulty,VoteMerchantTime,VoteClassic,}

	end
)


function GM:RemoveVote(ply,RemoveTable)
	local VoteMap = RemoveTable[1]
	local VoteGame = RemoveTable[2]
	local VoteCrows = RemoveTable[3]
	local VoteDifficulty = RemoveTable[4]
	local VoteMerchantTime = RemoveTable[5]
	local VoteClassic = RemoveTable[6]

	local classicmessage = ""

	GAMEMODE.VotingMaps[tostring(VoteMap)] = GAMEMODE.VotingMaps[tostring(VoteMap)] - 1

	GAMEMODE.VotingCrows.Votes = GAMEMODE.VotingCrows.Votes - 1
	GAMEMODE.VotingClassic.Votes = GAMEMODE.VotingClassic.Votes - 1

	if tobool(VoteCrows) then
		GAMEMODE.VotingCrows.Value = GAMEMODE.VotingCrows.Value - 1
	end
	if tobool(VoteClassic) then
		GAMEMODE.VotingClassic.Value = GAMEMODE.VotingClassic.Value - 1
	end

	GAMEMODE.VotingDifficulty[tostring(VoteDifficulty)] = GAMEMODE.VotingDifficulty[tostring(VoteDifficulty)] - 1
	if VoteDifficulty == "Easy" then
		GAMEMODE.VotingDifficulty["Normal"] = GAMEMODE.VotingDifficulty["Normal"] - .4
	elseif VoteDifficulty == "Normal" then
		GAMEMODE.VotingDifficulty["Easy"] = GAMEMODE.VotingDifficulty["Easy"] - .4
		GAMEMODE.VotingDifficulty["Difficult"] = GAMEMODE.VotingDifficulty["Difficult"] - .4
	elseif VoteDifficulty == "Difficult" then
		GAMEMODE.VotingDifficulty["Normal"] = GAMEMODE.VotingDifficulty["Normal"] - .4
		GAMEMODE.VotingDifficulty["Expert"] = GAMEMODE.VotingDifficulty["Expert"] - .4
	elseif VoteDifficulty == "Expert" then
		GAMEMODE.VotingDifficulty["Difficult"] = GAMEMODE.VotingDifficulty["Difficult"] - .4
		GAMEMODE.VotingDifficulty["Suicidal"] = GAMEMODE.VotingDifficulty["Suicidal"] - .4
	elseif VoteDifficulty == "Suicidal" then
		GAMEMODE.VotingDifficulty["Expert"] = GAMEMODE.VotingDifficulty["Expert"] - .4
	end

	GAMEMODE.VotingMerchantTime[tonumber(VoteMerchantTime)] = GAMEMODE.VotingMerchantTime[tonumber(VoteMerchantTime)] - 1
	if tobool(VoteClassic) then
		classicmessage = "Classic-"
	end

	for tablename,data in pairs(GAMEMODE.Gamemode) do
		if data.Name != nil && VoteGame == data.Name then
			VoteGame = tablename
		end
	end

	if VoteGame == "Team_VIP" then
		GAMEMODE.VotingGamemodes["VIP"] = GAMEMODE.VotingGamemodes["VIP"] - .5
	elseif VoteGame == "VIP" then
		GAMEMODE.VotingGamemodes["Team_VIP"] = GAMEMODE.VotingGamemodes["Team_VIP"] - .5
	end

	GAMEMODE.VotingGamemodes[tostring(VoteGame)] = GAMEMODE.VotingGamemodes[tostring(VoteGame)] - 1

end

local RandomMapNames = {}
local RandomDifficulties = {}



function GM:DecideVotes()
	local FilePath = "RE2/Rules/Rules.txt"

	local gamemode = "Survivor"

		for a,b in pairs(GAMEMODE.VotingGamemodes) do
			if GAMEMODE.VotingGamemodes[a] > GAMEMODE.VotingGamemodes[gamemode] && a != gamemode then
				gamemode = tostring(a)
			end
		end
		RandomMapNames = {}
		for k,v in pairs(GAMEMODE.MapListTable) do
			table.insert(RandomMapNames,k)
		end
		RandomDifficulties = {}
		for k,v in pairs(GAMEMODE.ZombieData) do
			if k != "Zombies" then
				table.insert(RandomDifficulties,k)
			end
		end

	local NewMap = table.Random(RandomMapNames)

		for map,data in pairs(GAMEMODE.VotingMaps) do
			if GAMEMODE.VotingMaps[map] > GAMEMODE.VotingMaps[NewMap] && map != NewMap then
				NewMap = tostring(map)
			end
		end
		for map,data in pairs(GAMEMODE.MapListTable) do
			if NewMap == map && GAMEMODE.MapListTable[NewMap].Escape != nil && gamemode != "Escape" then
				local RandomVotemaps = {}
				for name,votes in pairs(GAMEMODE.VotingMaps) do
					if GAMEMODE.MapListTable[name].Escape == nil && votes >= 0 then
						table.insert(RandomVotemaps,name)
					end
				end
				NewMap = table.Random(RandomVotemaps)
				break
			elseif NewMap == map && GAMEMODE.MapListTable[NewMap].Escape == nil && gamemode == "Escape" then
				gamemode = "Survivor"
			end
		end

	local Crows = false
	if GAMEMODE.VotingCrows.Value != 0 && GAMEMODE.VotingCrows.Value >= GAMEMODE.VotingCrows.Votes * (2/3)  then
		Crows = true
	end

	local Classic = false
	if GAMEMODE.VotingClassic.Value != 0 && GAMEMODE.VotingClassic.Value >= GAMEMODE.VotingClassic.Votes * (2/3)  then
		Classic = true
	end

	local NewDifficulty = table.Random(RandomDifficulties)
		for key,difficulty in pairs(GAMEMODE.VotingDifficulty) do
			if key != "Zombies" && GAMEMODE.VotingDifficulty[key] > 0 && difficulty >= GAMEMODE.VotingDifficulty[NewDifficulty] && GAMEMODE.VotingDifficulty[key] != NewDifficulty then
				NewDifficulty = key
			end
		end

	local NewMerchantTime = 120

	for MerchantTime,Amount in pairs(GAMEMODE.VotingMerchantTime) do
		if Amount > GAMEMODE.VotingMerchantTime[NewMerchantTime] then
			NewMerchantTime = MerchantTime
		end
	end

	local VoteTable = {gamemode = gamemode,crows = tostring(Crows),difficulty = NewDifficulty,merchanttime = NewMerchantTime,classic = tostring(Classic),}
	if (!file.Exists("RE2/Rules/","DATA")) then
		file.CreateDir("RE2/Rules/", "DATA")
	end

	file.Write(FilePath,util.TableToKeyValues(VoteTable))

	timer.Simple(5,function() RunConsoleCommand("changelevel", tostring(NewMap) ) end)
	if GAMEMODE.Gamemode[gamemode].Name != nil then
		gamemode = GAMEMODE.Gamemode[gamemode].Name
	end
	if Classic then
		PrintMessage(HUD_PRINTTALK,"Changing to "..NewMap.." in 5 seconds. The gamemode will be Classic-"..gamemode.." and it will be "..NewDifficulty)
	else
		print(NewMap)
		PrintMessage(HUD_PRINTTALK,"Changing to "..NewMap.." in 5 seconds. The gamemode will be "..gamemode.." and it will be "..NewDifficulty)
	end
end
