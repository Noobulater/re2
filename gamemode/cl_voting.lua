
VoteOption = {}

local RandomMapNames = {}
for k,v in pairs(GM.MapListTable) do
	table.insert(RandomMapNames,k)
end
local randommapchoice = table.Random(RandomMapNames)

if GM.MapListTable[randommapchoice].Escape != nil then randommapchoice = "re2_ambush_b5" end

VoteOption["Map"] = randommapchoice

VoteOption["Game"] = "Survivor"

VoteOption["Difficulty"] = "Normal"

VoteOption["Crows"] = false

VoteOption["Classic"] = false

VoteOption["PrepTime"] = 120

function GUI_VoteMenu(voting)

	--if GetGlobalEntity("Mode") != "End" then return end
	local Iconent = ents.CreateClientProp("prop_physics")
	Iconent:SetPos(Vector(0,0,0))
	Iconent:Spawn()
	Iconent:Activate()

	local GUI_EndGameFrame = vgui.Create("DFrame")
	GUI_EndGameFrame:SetSize(630,700)
	GUI_EndGameFrame:Center()
	GUI_EndGameFrame:SetTitle("Results")
	GUI_EndGameFrame:MakePopup()

	local GUI_Property_Sheet = vgui.Create("DPropertySheet")
	GUI_Property_Sheet:SetParent(GUI_EndGameFrame)
	GUI_Property_Sheet:SetPos(5,25)
	GUI_Property_Sheet:SetSize(620,650)

	GUI_Property_Sheet.Paint = function()
									surface.SetDrawColor(150,150,150,255)
									surface.DrawRect(0,22,GUI_Property_Sheet:GetWide(),GUI_Property_Sheet:GetTall() - 2 )
								end

	local GUI_Scoreboard_Background_Panel = vgui.Create("DPanelList")
	GUI_Scoreboard_Background_Panel:SetSize(600,600)
	GUI_Scoreboard_Background_Panel:SetPos(10,60)
	GUI_Scoreboard_Background_Panel:SetParent(GUI_Property_Sheet)
	GUI_Scoreboard_Background_Panel.Paint = function()
											end
	GUI_Scoreboard_Background_Panel:SetSpacing( 5 ) -- Spacing between items
	GUI_Scoreboard_Background_Panel:EnableVerticalScrollbar( true )

		local WinnerTable = GAMEMODE:Sort_Top_Stats()

		local GUI_Scoreboard_LocalPlayer = vgui.Create("DCollapsibleCategory")
		GUI_Scoreboard_LocalPlayer:SetParent(GUI_Scoreboard_Background_Panel)
		GUI_Scoreboard_LocalPlayer:SetSize(580,160)
		GUI_Scoreboard_LocalPlayer:SetPos(10,40)
		GUI_Scoreboard_LocalPlayer:SetLabel("Your Statistics")
		GUI_Scoreboard_LocalPlayer.Paint = function()
												surface.SetDrawColor(60,60,60,255)
												surface.DrawRect(0,0,GUI_Scoreboard_LocalPlayer:GetWide()-1,22-1)
												surface.SetDrawColor(0,0,0,255)
												surface.DrawOutlinedRect(0,0,GUI_Scoreboard_LocalPlayer:GetWide(),22)
											end

			local GUI_Scoreboard_LocalPlayer_Panel = vgui.Create("DPanelList")
			GUI_Scoreboard_LocalPlayer_Panel:SetParent(GUI_Scoreboard_LocalPlayer)
			GUI_Scoreboard_LocalPlayer_Panel:SetSize(580,120)
			GUI_Scoreboard_LocalPlayer_Panel:SetPos(0,40)
			GUI_Scoreboard_LocalPlayer_Panel.Paint = function()
														surface.SetDrawColor(0,0,0,255)
														surface.DrawOutlinedRect(0,0,GUI_Scoreboard_LocalPlayer_Panel:GetWide(),GUI_Scoreboard_LocalPlayer_Panel:GetTall())
														surface.SetDrawColor(40,40,40,255)
														surface.DrawRect(1,0,GUI_Scoreboard_LocalPlayer_Panel:GetWide()-2,GUI_Scoreboard_LocalPlayer_Panel:GetTall()-1)
													end

		GUI_LoadStats(GUI_Scoreboard_LocalPlayer_Panel,{},LocalPlayer())

		GUI_Scoreboard_LocalPlayer:SetContents(GUI_Scoreboard_LocalPlayer_Panel)

		GUI_Scoreboard_Background_Panel:AddItem(GUI_Scoreboard_LocalPlayer)

		local GUI_Scoreboard_TopKiller = vgui.Create("DCollapsibleCategory")
		GUI_Scoreboard_TopKiller:SetParent(GUI_Scoreboard_Background_Panel)
		GUI_Scoreboard_TopKiller:SetSize(580,160)
		GUI_Scoreboard_TopKiller:SetPos(10,40)
		GUI_Scoreboard_TopKiller:SetExpanded(0)
		GUI_Scoreboard_TopKiller:SetLabel(WinnerTable.kills:Nick().." is Unforgiving (Killed the most zombies)")
		GUI_Scoreboard_TopKiller.Paint = function()
												surface.SetDrawColor(60,60,60,255)
												surface.DrawRect(0,0,GUI_Scoreboard_TopKiller:GetWide()-1,22-1)
												surface.SetDrawColor(0,0,0,255)
												surface.DrawOutlinedRect(0,0,GUI_Scoreboard_TopKiller:GetWide(),22)
											end

			local GUI_Scoreboard_TopKiller_Panel = vgui.Create("DPanelList")
			GUI_Scoreboard_TopKiller_Panel:SetParent(GUI_Scoreboard_TopKiller)
			GUI_Scoreboard_TopKiller_Panel:SetSize(580,120)
			GUI_Scoreboard_TopKiller_Panel:SetPos(0,40)
			GUI_Scoreboard_TopKiller_Panel.Paint = function()
														surface.SetDrawColor(0,0,0,255)
														surface.DrawOutlinedRect(0,0,GUI_Scoreboard_TopKiller_Panel:GetWide(),GUI_Scoreboard_TopKiller_Panel:GetTall())
														surface.SetDrawColor(40,40,40,255)
														surface.DrawRect(1,0,GUI_Scoreboard_TopKiller_Panel:GetWide()-2,GUI_Scoreboard_TopKiller_Panel:GetTall()-1)
													end

		GUI_LoadStats(GUI_Scoreboard_TopKiller_Panel,{"Kills"},WinnerTable.kills)

		GUI_Scoreboard_TopKiller:SetContents(GUI_Scoreboard_TopKiller_Panel)

		GUI_Scoreboard_Background_Panel:AddItem(GUI_Scoreboard_TopKiller)


		local GUI_Scoreboard_TeamPlayer = vgui.Create("DCollapsibleCategory")
		GUI_Scoreboard_TeamPlayer:SetParent(GUI_Scoreboard_Background_Panel)
		GUI_Scoreboard_TeamPlayer:SetSize(580,160)
		GUI_Scoreboard_TeamPlayer:SetPos(10,40)
		GUI_Scoreboard_TeamPlayer:SetExpanded(0)
		GUI_Scoreboard_TeamPlayer:SetLabel(WinnerTable.Teamplayer:Nick().." is a Team Player (Assisted Teammates the most)")
		GUI_Scoreboard_TeamPlayer.Paint = function()
												surface.SetDrawColor(60,60,60,255)
												surface.DrawRect(0,0,GUI_Scoreboard_TeamPlayer:GetWide()-1,22-1)
												surface.SetDrawColor(0,0,0,255)
												surface.DrawOutlinedRect(0,0,GUI_Scoreboard_TeamPlayer:GetWide(),22)
											end

			local GUI_Scoreboard_TeamPlayer_Panel = vgui.Create("DPanelList")
			GUI_Scoreboard_TeamPlayer_Panel:SetParent(GUI_Scoreboard_TeamPlayer)
			GUI_Scoreboard_TeamPlayer_Panel:SetSize(580,120)
			GUI_Scoreboard_TeamPlayer_Panel:SetPos(0,40)
			GUI_Scoreboard_TeamPlayer_Panel.Paint = function()
														surface.SetDrawColor(0,0,0,255)
														surface.DrawOutlinedRect(0,0,GUI_Scoreboard_TeamPlayer_Panel:GetWide(),GUI_Scoreboard_TeamPlayer_Panel:GetTall())
														surface.SetDrawColor(40,40,40,255)
														surface.DrawRect(1,0,GUI_Scoreboard_TeamPlayer_Panel:GetWide()-2,GUI_Scoreboard_TeamPlayer_Panel:GetTall()-1)
													end

		GUI_LoadStats(GUI_Scoreboard_TeamPlayer_Panel,{"Team_Supply","Team_Sprays","Team_Cures"},WinnerTable.Teamplayer)

		GUI_Scoreboard_TeamPlayer:SetContents(GUI_Scoreboard_TeamPlayer_Panel)

		GUI_Scoreboard_Background_Panel:AddItem(GUI_Scoreboard_TeamPlayer)

		local GUI_Scoreboard_HeadShots = vgui.Create("DCollapsibleCategory")
		GUI_Scoreboard_HeadShots:SetParent(GUI_Scoreboard_Background_Panel)
		GUI_Scoreboard_HeadShots:SetSize(580,160)
		GUI_Scoreboard_HeadShots:SetPos(10,40)
		GUI_Scoreboard_HeadShots:SetExpanded(0)
		GUI_Scoreboard_HeadShots:SetLabel(WinnerTable.headshots:Nick().." is a Perfectionist (Most Headshots)")
		GUI_Scoreboard_HeadShots.Paint = function()
												surface.SetDrawColor(60,60,60,255)
												surface.DrawRect(0,0,GUI_Scoreboard_HeadShots:GetWide()-1,22-1)
												surface.SetDrawColor(0,0,0,255)
												surface.DrawOutlinedRect(0,0,GUI_Scoreboard_HeadShots:GetWide(),22)
											end

			local GUI_Scoreboard_HeadShots_Panel = vgui.Create("DPanelList")
			GUI_Scoreboard_HeadShots_Panel:SetParent(GUI_Scoreboard_HeadShots)
			GUI_Scoreboard_HeadShots_Panel:SetSize(580,120)
			GUI_Scoreboard_HeadShots_Panel:SetPos(0,40)
			GUI_Scoreboard_HeadShots_Panel.Paint = function()
														surface.SetDrawColor(0,0,0,255)
														surface.DrawOutlinedRect(0,0,GUI_Scoreboard_HeadShots_Panel:GetWide(),GUI_Scoreboard_HeadShots_Panel:GetTall())
														surface.SetDrawColor(40,40,40,255)
														surface.DrawRect(1,0,GUI_Scoreboard_HeadShots_Panel:GetWide()-2,GUI_Scoreboard_HeadShots_Panel:GetTall()-1)
													end

		GUI_LoadStats(GUI_Scoreboard_HeadShots_Panel,{"HeadShots",},WinnerTable.headshots)

		GUI_Scoreboard_HeadShots:SetContents(GUI_Scoreboard_HeadShots_Panel)

		GUI_Scoreboard_Background_Panel:AddItem(GUI_Scoreboard_HeadShots)

		local GUI_Scoreboard_Tank = vgui.Create("DCollapsibleCategory")
		GUI_Scoreboard_Tank:SetParent(GUI_Scoreboard_Background_Panel)
		GUI_Scoreboard_Tank:SetSize(580,160)
		GUI_Scoreboard_Tank:SetPos(10,40)
		GUI_Scoreboard_Tank:SetExpanded(0)
		GUI_Scoreboard_Tank:SetLabel(WinnerTable.damageTaken:Nick().." is a Tank ( Took the most damage )")
		GUI_Scoreboard_Tank.Paint = function()
												surface.SetDrawColor(60,60,60,255)
												surface.DrawRect(0,0,GUI_Scoreboard_Tank:GetWide()-1,22-1)
												surface.SetDrawColor(0,0,0,255)
												surface.DrawOutlinedRect(0,0,GUI_Scoreboard_Tank:GetWide(),22)
											end

			local GUI_Scoreboard_Tank_Panel = vgui.Create("DPanelList")
			GUI_Scoreboard_Tank_Panel:SetParent(GUI_Scoreboard_Tank)
			GUI_Scoreboard_Tank_Panel:SetSize(580,120)
			GUI_Scoreboard_Tank_Panel:SetPos(0,40)
			GUI_Scoreboard_Tank_Panel.Paint = function()
														surface.SetDrawColor(0,0,0,255)
														surface.DrawOutlinedRect(0,0,GUI_Scoreboard_Tank_Panel:GetWide(),GUI_Scoreboard_Tank_Panel:GetTall())
														surface.SetDrawColor(40,40,40,255)
														surface.DrawRect(1,0,GUI_Scoreboard_Tank_Panel:GetWide()-2,GUI_Scoreboard_Tank_Panel:GetTall()-1)
													end

		GUI_LoadStats(GUI_Scoreboard_Tank_Panel,{"Damage_Taken",},WinnerTable.damageTaken)

		GUI_Scoreboard_Tank:SetContents(GUI_Scoreboard_Tank_Panel)

		GUI_Scoreboard_Background_Panel:AddItem(GUI_Scoreboard_Tank)

		local GUI_Scoreboard_Evader = vgui.Create("DCollapsibleCategory")
		GUI_Scoreboard_Evader:SetParent(GUI_Scoreboard_Background_Panel)
		GUI_Scoreboard_Evader:SetSize(580,160)
		GUI_Scoreboard_Evader:SetPos(10,40)
		GUI_Scoreboard_Evader:SetExpanded(0)
		GUI_Scoreboard_Evader:SetLabel(WinnerTable.leastdamageTaken:Nick().." is an Evader ( Took the least damage )")
		GUI_Scoreboard_Evader.Paint = function()
												surface.SetDrawColor(60,60,60,255)
												surface.DrawRect(0,0,GUI_Scoreboard_Evader:GetWide()-1,22-1)
												surface.SetDrawColor(0,0,0,255)
												surface.DrawOutlinedRect(0,0,GUI_Scoreboard_Evader:GetWide(),22)
											end

			local GUI_Scoreboard_Evader_Panel = vgui.Create("DPanelList")
			GUI_Scoreboard_Evader_Panel:SetParent(GUI_Scoreboard_Evader)
			GUI_Scoreboard_Evader_Panel:SetSize(580,120)
			GUI_Scoreboard_Evader_Panel:SetPos(0,40)
			GUI_Scoreboard_Evader_Panel.Paint = function()
														surface.SetDrawColor(0,0,0,255)
														surface.DrawOutlinedRect(0,0,GUI_Scoreboard_Evader_Panel:GetWide(),GUI_Scoreboard_Evader_Panel:GetTall())
														surface.SetDrawColor(40,40,40,255)
														surface.DrawRect(1,0,GUI_Scoreboard_Evader_Panel:GetWide()-2,GUI_Scoreboard_Evader_Panel:GetTall()-1)
													end

		GUI_LoadStats(GUI_Scoreboard_Evader_Panel,{"Damage_Taken",},WinnerTable.leastdamageTaken)

		GUI_Scoreboard_Evader:SetContents(GUI_Scoreboard_Evader_Panel)

		GUI_Scoreboard_Background_Panel:AddItem(GUI_Scoreboard_Evader)

		local GUI_Scoreboard_Infection = vgui.Create("DCollapsibleCategory")
		GUI_Scoreboard_Infection:SetParent(GUI_Scoreboard_Background_Panel)
		GUI_Scoreboard_Infection:SetSize(580,160)
		GUI_Scoreboard_Infection:SetPos(10,40)
		GUI_Scoreboard_Infection:SetExpanded(0)
		GUI_Scoreboard_Infection:SetLabel(WinnerTable.Infections:Nick().." is HIV Positive( Was Infected the most )")
		GUI_Scoreboard_Infection.Paint = function()
												surface.SetDrawColor(60,60,60,255)
												surface.DrawRect(0,0,GUI_Scoreboard_Infection:GetWide()-1,22-1)
												surface.SetDrawColor(0,0,0,255)
												surface.DrawOutlinedRect(0,0,GUI_Scoreboard_Infection:GetWide(),22)
											end

			local GUI_Scoreboard_Infection_Panel = vgui.Create("DPanelList")
			GUI_Scoreboard_Infection_Panel:SetParent(GUI_Scoreboard_Infection)
			GUI_Scoreboard_Infection_Panel:SetSize(580,120)
			GUI_Scoreboard_Infection_Panel:SetPos(0,40)
			GUI_Scoreboard_Infection_Panel.Paint = function()
														surface.SetDrawColor(0,0,0,255)
														surface.DrawOutlinedRect(0,0,GUI_Scoreboard_Infection_Panel:GetWide(),GUI_Scoreboard_Infection_Panel:GetTall())
														surface.SetDrawColor(40,40,40,255)
														surface.DrawRect(1,0,GUI_Scoreboard_Infection_Panel:GetWide()-2,GUI_Scoreboard_Infection_Panel:GetTall()-1)
													end

		GUI_LoadStats(GUI_Scoreboard_Infection_Panel,{"Infections",},WinnerTable.Infections)

		GUI_Scoreboard_Infection:SetContents(GUI_Scoreboard_Infection_Panel)

		GUI_Scoreboard_Background_Panel:AddItem(GUI_Scoreboard_Infection)

		local GUI_Scoreboard_Knife = vgui.Create("DCollapsibleCategory")
		GUI_Scoreboard_Knife:SetParent(GUI_Scoreboard_Background_Panel)
		GUI_Scoreboard_Knife:SetSize(580,160)
		GUI_Scoreboard_Knife:SetPos(10,40)
		GUI_Scoreboard_Knife:SetExpanded(0)
		GUI_Scoreboard_Knife:SetLabel(WinnerTable.KnifeKills:Nick().." is a Madman ( Killed the most zombies with a knife )")
		GUI_Scoreboard_Knife.Paint = function()
												surface.SetDrawColor(60,60,60,255)
												surface.DrawRect(0,0,GUI_Scoreboard_Knife:GetWide()-1,22-1)
												surface.SetDrawColor(0,0,0,255)
												surface.DrawOutlinedRect(0,0,GUI_Scoreboard_Knife:GetWide(),22)
											end

			local GUI_Scoreboard_Knife_Panel = vgui.Create("DPanelList")
			GUI_Scoreboard_Knife_Panel:SetParent(GUI_Scoreboard_Knife)
			GUI_Scoreboard_Knife_Panel:SetSize(580,120)
			GUI_Scoreboard_Knife_Panel:SetPos(0,40)
			GUI_Scoreboard_Knife_Panel.Paint = function()
														surface.SetDrawColor(0,0,0,255)
														surface.DrawOutlinedRect(0,0,GUI_Scoreboard_Knife_Panel:GetWide(),GUI_Scoreboard_Knife_Panel:GetTall())
														surface.SetDrawColor(40,40,40,255)
														surface.DrawRect(1,0,GUI_Scoreboard_Knife_Panel:GetWide()-2,GUI_Scoreboard_Knife_Panel:GetTall()-1)
													end
		GUI_LoadStats(GUI_Scoreboard_Knife_Panel,{"Knife_Kills",},WinnerTable.KnifeKills)

		GUI_Scoreboard_Knife:SetContents(GUI_Scoreboard_Knife_Panel)

		GUI_Scoreboard_Background_Panel:AddItem(GUI_Scoreboard_Knife)

	GUI_Property_Sheet:AddSheet( "Scoreboard", GUI_Scoreboard_Background_Panel, "icon16/user.png", true, true, "The good, the bad, and the ugly are shown here." )

	local GUI_Vote_Background_Panel = vgui.Create("DPanelList")
	GUI_Vote_Background_Panel:SetSize(600,600)
	GUI_Vote_Background_Panel:SetPos(10,60)
	GUI_Vote_Background_Panel:SetParent(GUI_Property_Sheet)
	GUI_Vote_Background_Panel.Paint = function()
										end

		local GUI_Vote_Maps_Panel = vgui.Create("DPanelList")
		GUI_Vote_Maps_Panel:SetSize(280,540)
		GUI_Vote_Maps_Panel:SetPos(10,40)
		GUI_Vote_Maps_Panel:SetParent(GUI_Vote_Background_Panel)

			local GUI_Map_List_Menu = vgui.Create("DListView")
			GUI_Map_List_Menu:SetParent(GUI_Vote_Maps_Panel)
			GUI_Map_List_Menu:SetSize(280,530)
			GUI_Map_List_Menu:SetPos(0,0)
			GUI_Map_List_Menu:SetMultiSelect(false)
			GUI_Map_List_Menu:AddColumn("Select A Map")

			for k,v in pairs(GAMEMODE.MapListTable) do
				if v.Escape == nil then
					GUI_Map_List_Menu:AddLine(k)
				end
			end

			GUI_Map_List_Menu:SelectFirstItem()

			GUI_Map_List_Menu.OnRowSelected = function(GUI_Map_List_Menu)

			VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)

			end


		local GUI_Vote_Settings_Panel = vgui.Create("DPanelList")
		GUI_Vote_Settings_Panel:SetSize(280  ,350)
		GUI_Vote_Settings_Panel:SetPos(310,40)
		GUI_Vote_Settings_Panel:SetParent(GUI_Vote_Background_Panel)

			local GUI_Difficulty_Label = vgui.Create("DLabel")
			GUI_Difficulty_Label:SetText("Difficulty")
			GUI_Difficulty_Label:SizeToContents()
			GUI_Difficulty_Label:SetPos(10,120)
			GUI_Difficulty_Label:SetParent(GUI_Vote_Settings_Panel)


			local GUI_Difficulty = vgui.Create( "DListView" )
			GUI_Difficulty:AddColumn("Difficulty")
			GUI_Difficulty:SetParent(GUI_Vote_Settings_Panel)
			GUI_Difficulty:SetMultiSelect( false )

			local easy = GUI_Difficulty:AddLine( "Easy" ) -- Add our options
			local norm = GUI_Difficulty:AddLine( "Normal" )
			local diff = GUI_Difficulty:AddLine( "Difficult" )
			local exp = GUI_Difficulty:AddLine( "Expert" )
			local suc = GUI_Difficulty:AddLine( "Suicidal" )

			GUI_Difficulty:SetSize(100,120)
			GUI_Difficulty:SetPos(10,140)
			GUI_Difficulty:SelectItem(norm)

			function GUI_Difficulty:Think()
				if GUI_Difficulty:GetSelectedLine() == 1 then
					VoteOption["Difficulty"] = "Easy"
				elseif GUI_Difficulty:GetSelectedLine() == 2 then
						VoteOption["Difficulty"] = "Normal"
				elseif GUI_Difficulty:GetSelectedLine() == 3 then
						VoteOption["Difficulty"] = "Difficult"
				elseif GUI_Difficulty:GetSelectedLine() == 4 then
						VoteOption["Difficulty"] = "Expert"
				elseif GUI_Difficulty:GetSelectedLine() == 5 then
						VoteOption["Difficulty"] = "Suicidal"
				end
			end



			local GUI_Prep_Time = vgui.Create( "DNumSlider", GUI_Vote_Settings_Panel )

			local GUI_Misc_Label = vgui.Create("DLabel", GUI_Prep_Time)
			GUI_Misc_Label:SetText("Misc. Options")
			GUI_Misc_Label:SizeToContents()
			GUI_Misc_Label:SetPos(10,280)
			GUI_Misc_Label:SetTextColor(Color(0,0,0,255))

			GUI_Prep_Time:SetPos( 5,60 )
			GUI_Prep_Time:SetWide( 240 )
			GUI_Prep_Time:SetText( "Next Merchant Time" )
			GUI_Prep_Time:SetValue(120)
			GUI_Prep_Time:SetMin(60)
			GUI_Prep_Time:SetMax(180)
			GUI_Prep_Time:SetDecimals(0)

			function GUI_Prep_Time:ValueChanged(fValue)
				VoteOption["PrepTime"] = fValue
				GUI_Misc_Label:SetText(string.ToMinutesSeconds(fValue))
				GUI_Misc_Label:SizeToContents()
				GUI_Misc_Label:SetPos(GUI_Prep_Time:GetWide() - GUI_Misc_Label:GetWide() - 5 ,0)
			end

			local GUI_Misc_Label = vgui.Create("DLabel")
			GUI_Misc_Label:SetText("Misc. Options")
			GUI_Misc_Label:SizeToContents()
			GUI_Misc_Label:SetPos(10,280)
			GUI_Misc_Label:SetParent(GUI_Vote_Settings_Panel)

			/*local GUI_Player_Zombies = vgui.Create( "DCheckBoxLabel" )
			GUI_Player_Zombies:SetParent(GUI_Vote_Settings_Panel)
			GUI_Player_Zombies:SetText( "Allow Crows" )
			GUI_Player_Zombies:SetValue( 0 )
			GUI_Player_Zombies:SizeToContents()
			GUI_Player_Zombies:SetPos(10,300)
			GUI_Player_Zombies.OnChange = function()
												VoteOption["Crows"] = GUI_Player_Zombies:GetChecked()
											end
			local GUI_Classic_Mode = vgui.Create( "DCheckBoxLabel" )
			GUI_Classic_Mode:SetParent(GUI_Vote_Settings_Panel)
			GUI_Classic_Mode:SetText( "Classic Mode" )
			GUI_Classic_Mode:SetValue( 0 )
			GUI_Classic_Mode:SizeToContents()
			GUI_Classic_Mode:SetPos(10,320)
			GUI_Classic_Mode.OnChange = function()
												VoteOption["Classic"] = GUI_Classic_Mode:GetChecked()
											end*/

			local GUI_Gamemode_Label = vgui.Create("DLabel")
			GUI_Gamemode_Label:SetText("Gamemode")
			GUI_Gamemode_Label:SizeToContents()
			GUI_Gamemode_Label:SetPos(10,10)
			GUI_Gamemode_Label:SetParent(GUI_Vote_Settings_Panel)

			local GUI_Gamemode_Selection = vgui.Create("DComboBox")
			GUI_Gamemode_Selection:SetParent(GUI_Vote_Settings_Panel)
			GUI_Gamemode_Selection:SetPos(10,25)
			GUI_Gamemode_Selection:SetSize( 220, 20 )
				for h,j in pairs(GAMEMODE.Gamemode) do
					if j.Name != nil then
						GUI_Gamemode_Selection:AddChoice(tostring(j.Name))
					else
						GUI_Gamemode_Selection:AddChoice(tostring(h))
					end
				end
			GUI_Gamemode_Selection:ChooseOption( "Survivor" )



			function GUI_Gamemode_Selection:OnSelect(index,value,data)
				if value == "Escape" then
					local bool = false
					for k,v in pairs(GAMEMODE.MapListTable) do
						if v.Escape != nil then
							if (!bool) then
								GUI_Map_List_Menu:Clear()
							end
							GUI_Map_List_Menu:AddLine(k)
						end
					end
					if (bool) then
						GUI_Map_List_Menu:SelectFirstItem()
						VoteOption["Game"] = value
						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)
					else
						GUI_Gamemode_Selection:ChooseOption( "Survivor" )
						LocalPlayer():ChatPrint("No maps available for ".. value)
					end

				elseif value != "Escape" && VoteOption["Game"] == "Escape" then

					local bool = false
					for k,v in pairs(GAMEMODE.MapListTable) do
						if v.Escape == nil then
							if (!bool) then
								GUI_Map_List_Menu:Clear()
							end
							GUI_Map_List_Menu:AddLine(k)
							bool = true
						end
					end
					if bool then
						VoteOption["Game"] = value

						GUI_Map_List_Menu:SelectFirstItem()

						VoteOption["Map"] = GUI_Map_List_Menu:GetSelected()[1]:GetValue(1)
					else
						LocalPlayer():ChatPrint("No maps available for ".. value)
					end
				else
					VoteOption["Game"] = value
				end
			end


		local GUI_Vote_Confirmation_Panel = vgui.Create("DPanelList")
		GUI_Vote_Confirmation_Panel:SetSize(280  ,170)
		GUI_Vote_Confirmation_Panel:SetPos(310,410)
		GUI_Vote_Confirmation_Panel:SetParent(GUI_Vote_Background_Panel)

			local GUI_Difficulty_Vote_Label = vgui.Create("DLabel")

			function GUI_Difficulty_Vote_Label:Think()
				GUI_Difficulty_Vote_Label:SetText("You selected "..VoteOption["Difficulty"].." for the next difficulty.")
			end

			GUI_Difficulty_Vote_Label:SetSize( 260,20 )
			GUI_Difficulty_Vote_Label:SetPos(20,10)
			GUI_Difficulty_Vote_Label:SetParent(GUI_Vote_Confirmation_Panel)

			local GUI_Map_Vote_Label = vgui.Create("DLabel")

			function GUI_Map_Vote_Label:Think()
				GUI_Map_Vote_Label:SetText("You selected "..VoteOption["Map"].." for the next map.")
			end

			GUI_Map_Vote_Label:SetSize( 260,20 )
			GUI_Map_Vote_Label:SetPos(20,35)
			GUI_Map_Vote_Label:SetParent(GUI_Vote_Confirmation_Panel)

			local GUI_Gamemode_Vote_Label = vgui.Create("DLabel")

			function GUI_Gamemode_Vote_Label:Think()
				GUI_Gamemode_Vote_Label:SetText("You selected "..VoteOption["Game"].." for the next gamemode.")
			end

			GUI_Gamemode_Vote_Label:SetSize( 240,20 )
			GUI_Gamemode_Vote_Label:SetPos(20,60)
			GUI_Gamemode_Vote_Label:SetParent(GUI_Vote_Confirmation_Panel)

			local GUI_Crows_Vote_Label = vgui.Create("DLabel")

			function GUI_Crows_Vote_Label:Think()
				if VoteOption["Crows"] then
					GUI_Crows_Vote_Label:SetText("You want spectators to become crows.")
				else
					GUI_Crows_Vote_Label:SetText("You don't want spectators to become crows.")
				end
			end

			GUI_Crows_Vote_Label:SetSize( 260,20 )
			GUI_Crows_Vote_Label:SetPos(20,85)
			GUI_Crows_Vote_Label:SetParent(GUI_Vote_Confirmation_Panel)

			local GUI_Classic_Vote_Label = vgui.Create("DLabel")

			function GUI_Classic_Vote_Label:Think()
				if VoteOption["Classic"] then
					GUI_Classic_Vote_Label:SetText("You want to play Classic mode.")
				else
					GUI_Classic_Vote_Label:SetText("You don't to play Classic mode.")
				end
			end

			GUI_Classic_Vote_Label:SetSize( 260,20 )
			GUI_Classic_Vote_Label:SetPos(20,110)
			GUI_Classic_Vote_Label:SetParent(GUI_Vote_Confirmation_Panel)

			local GUI_Submit_Vote = vgui.Create("DButton")
			GUI_Submit_Vote:SetParent( GUI_Vote_Confirmation_Panel )
			GUI_Submit_Vote:SetText( "Submit Your Vote" )

			local x,y = GUI_Vote_Confirmation_Panel:GetSize()

			GUI_Submit_Vote:SetPos(20, 140)
			GUI_Submit_Vote:SetSize( x - 40,20 )
			GUI_Submit_Vote.DoClick = function ( btn )
				if GUI_Difficulty:GetSelectedLine() == easy then
					VoteOption["Difficulty"] = "Easy"
				elseif GUI_Difficulty:GetSelectedLine() == norm then
						VoteOption["Difficulty"] = "Normal"
				elseif GUI_Difficulty:GetSelectedLine() == diff then
						VoteOption["Difficulty"] = "Difficult"
				elseif GUI_Difficulty:GetSelectedLine() == exp then
						VoteOption["Difficulty"] = "Expert"
				elseif GUI_Difficulty:GetSelectedLine() == suc then
						VoteOption["Difficulty"] = "Suicidal"
				end
				SendDataToServer()
				GUI_Submit_Vote:SetText("Change Vote")
			end

	GUI_Property_Sheet:AddSheet( "Vote Menu", GUI_Vote_Background_Panel, "icon16/user.png", true, true, "Vote for the next game here." )
	if (input == true) then
		GUI_Property_Sheet:SwitchToName("Vote Menu")
	end
end
concommand.Add("Re2_VoteMenu",GUI_VoteMenu)
concommand.Add("Re2_VoteMenu_vote",function(ply,cmd,args) GUI_VoteMenu(true) end)

function GUI_LoadStats(parent, highlighttable, ply)

	local GUI_Kills_Label = vgui.Create("DLabel")
	GUI_Kills_Label:SetText("Kills : "..ply:GetNWInt("killcount"))
	GUI_Kills_Label:SetFont("Trebuchet18")
	GUI_Kills_Label:SizeToContents()
	GUI_Kills_Label:SetPos(10,10)
	GUI_Kills_Label:SetParent(parent)

	local GUI_HeadShots_Label = vgui.Create("DLabel")
	GUI_HeadShots_Label:SetText("HeadShots : "..ply:GetNWInt("HeadShots"))
	GUI_HeadShots_Label:SetFont("Trebuchet18")
	GUI_HeadShots_Label:SizeToContents()
	GUI_HeadShots_Label:SetPos(10,30)
	GUI_HeadShots_Label:SetParent(parent)

	local GUI_Sprays_Label = vgui.Create("DLabel")
	GUI_Sprays_Label:SetText("Sprays Used : "..ply:GetNWInt("SpraysUsed"))
	GUI_Sprays_Label:SetFont("Trebuchet18")
	GUI_Sprays_Label:SizeToContents()
	GUI_Sprays_Label:SetPos(10,50)
	GUI_Sprays_Label:SetParent(parent)

	local GUI_Cures_Label = vgui.Create("DLabel")
	GUI_Cures_Label:SetText("Cures Used : "..ply:GetNWInt("CuresUsed"))
	GUI_Cures_Label:SetFont("Trebuchet18")
	GUI_Cures_Label:SizeToContents()
	GUI_Cures_Label:SetPos(10,70)
	GUI_Cures_Label:SetParent(parent)

	local GUI_Team_Spray_Label = vgui.Create("DLabel")
	GUI_Team_Spray_Label:SetText("Teammates Healed : "..ply:GetNWInt("TeammatesSprayed"))
	GUI_Team_Spray_Label:SetFont("Trebuchet18")
	GUI_Team_Spray_Label:SizeToContents()
	GUI_Team_Spray_Label:SetPos(310,10)
	GUI_Team_Spray_Label:SetParent(parent)

	local GUI_Team_Cures_Label = vgui.Create("DLabel")
	GUI_Team_Cures_Label:SetText("Teammates Cured : "..ply:GetNWInt("TeammatesCured"))
	GUI_Team_Cures_Label:SetFont("Trebuchet18")
	GUI_Team_Cures_Label:SizeToContents()
	GUI_Team_Cures_Label:SetPos(310,30)
	GUI_Team_Cures_Label:SetParent(parent)

	local GUI_Team_Supply_Label = vgui.Create("DLabel")
	GUI_Team_Supply_Label:SetText("Teammates Supplied : "..ply:GetNWInt("TeammatesSupplied"))
	GUI_Team_Supply_Label:SetFont("Trebuchet18")
	GUI_Team_Supply_Label:SizeToContents()
	GUI_Team_Supply_Label:SetPos(310,50)
	GUI_Team_Supply_Label:SetParent(parent)

	local GUI_Damage_Taken_Label = vgui.Create("DLabel")
	GUI_Damage_Taken_Label:SetText("Damage Taken : "..ply:GetNWInt("DamageTaken"))
	GUI_Damage_Taken_Label:SetFont("Trebuchet18")
	GUI_Damage_Taken_Label:SizeToContents()
	GUI_Damage_Taken_Label:SetPos(310,70)
	GUI_Damage_Taken_Label:SetParent(parent)

	local GUI_Knife_Kills_Label = vgui.Create("DLabel")
	GUI_Knife_Kills_Label:SetText("Knife Kills : "..ply:GetNWInt("KnifeKills"))
	GUI_Knife_Kills_Label:SetFont("Trebuchet18")
	GUI_Knife_Kills_Label:SizeToContents()
	GUI_Knife_Kills_Label:SetPos(310,90)
	GUI_Knife_Kills_Label:SetParent(parent)

	local GUI_Infection_Label = vgui.Create("DLabel")
	GUI_Infection_Label:SetText("Infections : "..ply:GetNWInt("Infections"))
	GUI_Infection_Label:SetFont("Trebuchet18")
	GUI_Infection_Label:SizeToContents()
	GUI_Infection_Label:SetPos(10,90)
	GUI_Infection_Label:SetParent(parent)

	local GoldColor = Color(255,200,0)
	for _,derma in pairs(highlighttable) do
		if derma == "Team_Supply" then
			GUI_Team_Supply_Label:SetFont("trebuchet24")
			GUI_Team_Supply_Label:SetTextColor(GoldColor)
			GUI_Team_Supply_Label:SizeToContents()
		elseif derma == "Team_Cures" then
			GUI_Team_Cures_Label:SetFont("trebuchet24")
			GUI_Team_Cures_Label:SetTextColor(GoldColor)
			GUI_Team_Cures_Label:SizeToContents()
		elseif derma == "Team_Sprays" then
			GUI_Team_Spray_Label:SetFont("trebuchet24")
			GUI_Team_Spray_Label:SetTextColor(GoldColor)
			GUI_Team_Spray_Label:SizeToContents()
		elseif derma == "Cures" then
			GUI_Cures_Label:SetFont("trebuchet24")
			GUI_Cures_Label:SetTextColor(GoldColor)
			GUI_Cures_Label:SizeToContents()
		elseif derma == "Sprays" then
			GUI_Sprays_Label:SetFont("trebuchet24")
			GUI_Sprays_Label:SetTextColor(GoldColor)
			GUI_Sprays_Label:SizeToContents()
		elseif derma == "HeadShots" then
			GUI_HeadShots_Label:SetFont("trebuchet24")
			GUI_HeadShots_Label:SetTextColor(GoldColor)
			GUI_HeadShots_Label:SizeToContents()
		elseif derma == "Kills" then
			GUI_Kills_Label:SetFont("trebuchet24")
			GUI_Kills_Label:SetTextColor(GoldColor)
			GUI_Kills_Label:SizeToContents()
		elseif derma == "Damage_Taken" then
			GUI_Damage_Taken_Label:SetFont("trebuchet24")
			GUI_Damage_Taken_Label:SetTextColor(GoldColor)
			GUI_Damage_Taken_Label:SizeToContents()
		elseif derma == "Knife_Kills" then
			GUI_Knife_Kills_Label:SetFont("trebuchet24")
			GUI_Knife_Kills_Label:SetTextColor(GoldColor)
			GUI_Knife_Kills_Label:SizeToContents()
		elseif derma == "Infections" then
			GUI_Infection_Label:SetFont("trebuchet24")
			GUI_Infection_Label:SetTextColor(GoldColor)
			GUI_Infection_Label:SizeToContents()
		end
	end

end
