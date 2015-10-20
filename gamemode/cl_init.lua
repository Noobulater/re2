include('shared.lua')
include('shared_items.lua')
include('shared_maplists.lua')
include('shared_perks.lua')
include('shared_weapons.lua')
include('cl_hud.lua')
include('cl_scoreboard.lua')
include('cl_voting.lua')
include('cl_shop.lua')
include('cl_chests.lua')
include('cl_inventory.lua')

function TableRandom(tablename) return tablename[math.random(1,table.Count(tablename))] end

function GM:Initialize()

--- Variables

	bool_InvOpen = false
	bool_itemDisplay = false
	bool_IconOptions = false
	bool_IsUpging = false
	string_CurUpgItem = ""
	bool_CanClose = true
	bool_Chating = false

Inventory = {
	{Item = "none", Amount = 0},
	{Item = "none", Amount = 0},
	{Item = "none", Amount = 0},
	{Item = "none", Amount = 0},
	{Item = "none", Amount = 0},
	{Item = "none", Amount = 0},	}
Chest = {
	{Weapon = "none", Upgrades = {pwrlvl = 1, acclvl = 1, clplvl = 1, fislvl = 1,reslvl = 1}},
	{Weapon = "none", Upgrades = {pwrlvl = 1, acclvl = 1, clplvl = 1, fislvl = 1,reslvl = 1}},
	{Weapon = "none", Upgrades = {pwrlvl = 1, acclvl = 1, clplvl = 1, fislvl = 1,reslvl = 1}},
	{Weapon = "none", Upgrades = {pwrlvl = 1, acclvl = 1, clplvl = 1, fislvl = 1,reslvl = 1}},
	{Weapon = "none", Upgrades = {pwrlvl = 1, acclvl = 1, clplvl = 1, fislvl = 1,reslvl = 1}},}
Upgrades = {}


	local FilePath = "re2/options.txt"
	local FilePath1 = "re2/music.txt"
	local FilePath2 = "re2/content.txt"

	Options = {}
	Options["Music"] = 1
	Options["Crosshairs"] = {Red = 0,Green = 0,Blue = 0, Alpha = 0}
	Options["Content"] = false
	if file.Exists(FilePath, "DATA") && file.Exists(FilePath1, "DATA") && file.Exists(FilePath2, "DATA") then
	local tempcross = util.KeyValuesToTable(file.Read(FilePath))
		Options["Music"] = tonumber(file.Read(FilePath1))
		Options["Content"] = tobool(file.Read(FilePath2))
		Options["Crosshairs"]["Red"] = tonumber(tempcross["red"])
		Options["Crosshairs"]["Green"] = tonumber(tempcross["green"])
		Options["Crosshairs"]["Blue"] = tonumber(tempcross["blue"])
	end
	Invframe = nil
	justjoined = false

	timer.Simple(1,function() Sound_CreateTrack(GetGlobalString("Music")) end)
end


--------- Options
function OptionsMenu()
	local OptionsFrame = vgui.Create("DFrame")
	OptionsFrame:SetSize(250,225)
	OptionsFrame:Center();
	OptionsFrame:SetTitle("Options")
	OptionsFrame:MakePopup()
	OptionsFrame.btnClose.DoClick = function()
		OptionsFrame:Remove()
		local FilePath = "re2/options.txt"
		file.Write(FilePath,util.TableToKeyValues(Options["Crosshairs"]))
		local FilePath1 = "re2/music.txt"
		file.Write(FilePath1,Options["Music"])
		local FilePath1 = "re2/content.txt"
		file.Write(FilePath1,tostring(Options["Content"]))
		if Sound_GlobalMusic != nil && Sound_GlobalMusic.Sound != nil then
			Sound_GlobalMusic.Sound:ChangeVolume( Options["Music"] )
		end
	end

	local OptionsContent = vgui.Create("DCheckBoxLabel",OptionsFrame)
	OptionsContent:SetPos(5,35)
	OptionsContent:SetText("Options Message")
	OptionsContent:SetValue(Options["Content"])
	OptionsContent:SizeToContents()
	OptionsContent.OnChange = function() Options["Content"] = tobool(OptionsContent:GetChecked()) end

	local OptionsTutorial = vgui.Create("DButton",OptionsFrame)
	OptionsTutorial:SetPos(5,110)
	OptionsTutorial:SetText("Tutorial")
	OptionsTutorial:SetSize(240,50)
	OptionsTutorial.DoClick = function() GUI_Tutorial() OptionsFrame:Close()  end

	local Volume_Slider = vgui.Create( "DNumSlider", OptionsFrame )
	Volume_Slider:SetPos( 5,60 )
	Volume_Slider:SetWide( 240 )
	Volume_Slider:SetText( "Music Volume" )
	Volume_Slider:SetMin( 0 ) -- Minimum number of the slider
	Volume_Slider:SetMax( 100 ) -- Maximum number of the slider
	Volume_Slider:SetDecimals( 0 ) -- Sets a decimal. Zero means it's a whole number
	Volume_Slider:SetValue(Options["Music"] * 100)
	Volume_Slider.ValueChanged = function(pSelf, fValue)
		Options["Music"] = math.Clamp(math.Round(fValue),0,100)/100
		if Sound_GlobalMusic != nil && Sound_GlobalMusic.Sound != nil then
			Sound_GlobalMusic.Sound:ChangeVolume( Options["Music"] )
		end
	end


	local OptionsMenuCrosshairLabel = vgui.Create("DLabel")
	OptionsMenuCrosshairLabel:SetText("Crosshair Color")
	OptionsMenuCrosshairLabel:SetFont("Trebuchet18")
	OptionsMenuCrosshairLabel:SetParent(OptionsFrame)
	OptionsMenuCrosshairLabel:SetPos(5,170)
	OptionsMenuCrosshairLabel:SetSize(240,15)

	local OptionsMenuCrosshair = vgui.Create("DComboBox")
	OptionsMenuCrosshair:SetParent(OptionsFrame)
	OptionsMenuCrosshair:SetPos(5,190)
	OptionsMenuCrosshair:SetSize(240,20)
	OptionsMenuCrosshair:AddChoice("Red")
	OptionsMenuCrosshair:AddChoice("Gray")
	OptionsMenuCrosshair:AddChoice("Green")
	OptionsMenuCrosshair:AddChoice("Black")
	OptionsMenuCrosshair:AddChoice("White")
	OptionsMenuCrosshair:AddChoice("Blue")
	function OptionsMenuCrosshair:OnSelect(index,value,data)
		if value == "Red" then
			Options["Crosshairs"] = {Red = 255,Green = 50,Blue = 50, Alpha = 0}
		elseif value == "Gray" then
			Options["Crosshairs"] = {Red = 155,Green = 155,Blue = 155, Alpha = 0}
		elseif value == "Green" then
			Options["Crosshairs"] = {Red = 50,Green = 255,Blue = 50, Alpha = 0}
		elseif value == "Black" then
			Options["Crosshairs"] = {Red = 50,Green = 50,Blue = 50, Alpha = 0}
		elseif value == "White" then
			Options["Crosshairs"] = {Red = 255,Green = 255,Blue = 255, Alpha = 0}
		elseif value == "Blue" then
			Options["Crosshairs"] = {Red = 50,Green = 50,Blue = 255, Alpha = 0}
		end
	end
end
concommand.Add("ShowOptionsMenu",OptionsMenu)


--- Data Streams


function SendDataToServer()
	net.Start("VoteTransfer")
		net.WriteTable{ VoteOption["Map"], VoteOption["Game"],VoteOption["Crows"],VoteOption["Difficulty"],VoteOption["PrepTime"],VoteOption["Classic"]  }
	net.SendToServer()
end
concommand.Add("VoteUpdate",SendDataToServer)

net.Receive( "InvTransfer", function(len)
	-- Oh god... my code is so gross. Oh well
																	Inventory = net.ReadTable()
																	Upgrades = net.ReadTable()
																	Chest = net.ReadTable()
																	if bool_InvOpen then
																		ReLoadInvList()
																		bool_CanClose = true
																			if bool_IsUpging then
																				UpgUpdate()
																			end
																			if IsChesting then
																				ReloadChest()
																			end
																	end
																end)


----------- Music

function CL_MakeTrack( umsg )
	local music = umsg:ReadString()
	if Sound_GlobalMusic != nil && Sound_GlobalMusic.Sound != nil then
		Sound_GlobalMusic.Sound:Stop()
	end
	Sound_CreateTrack(music)
end
usermessage.Hook('RE2_MakeTrack', CL_MakeTrack);


function Sound_StopTrack()
	if Sound_GlobalMusic.Sound == nil || !Sound_GlobalMusic.Sound:IsPlaying() then return end
	Sound_GlobalMusic.Sound:Stop()
	Sound_GlobalMusic.Sound:ChangeVolume(0)
end
concommand.Add("Re2_StopTrack",Sound_StopTrack)

function Sound_CreateTrack(InputTrack)
	if Sound_GlobalMusic == nil then
		Sound_GlobalMusic = {}
	end
	Sound_GlobalMusic.Sound = CreateSound(LocalPlayer(),InputTrack)
	Sound_GlobalMusic.Sound:Play()
	Sound_GlobalMusic.Path = InputTrack
	Sound_GlobalMusic.Sound:ChangeVolume(Options["Music"] )

		print(Sound_GlobalMusic.Path)
		for k,v in pairs(GAMEMODE.Music.Safe) do
			if v.Sound == InputTrack  then
				timer.Simple(v.Length, function() if Sound_GlobalMusic.Path == v.Sound && Options["Music"] != 0 then  Sound_PlayTrack(v.Length,v.Sound) end end)
				break
			end
		end
		for k,v in pairs(GAMEMODE.Music.Battle) do
			if v.Sound == InputTrack then
				timer.Simple(v.Length, function() if Sound_GlobalMusic.Path == v.Sound && Options["Music"] != 0 then Sound_PlayTrack(v.Length,v.Sound) end end)
				break
			end
		end
		for k,v in pairs(GAMEMODE.Music.End) do
			if v.Sound == InputTrack then
				timer.Simple(v.Length, function() if Sound_GlobalMusic.Path == v.Sound  && Options["Music"] != 0 then Sound_PlayTrack(v.Length,v.Sound) end end)
				break
			end
		end
end
concommand.Add("Re2_CreateTrack",
	function(ply,command,args)
		local InputTrack = args[1]
		Sound_CreateTrack(GetGlobalString("Music"))
	end)


function Sound_PlayTrack(Length,Sound)
	if Sound_GlobalMusic.Sound == nil then return end
	if Sound_GlobalMusic.Sound:IsPlaying() then
		Sound_GlobalMusic.Sound:Stop()
	end
	Sound_GlobalMusic.Sound:ChangeVolume( Options["Music"] )
	Sound_GlobalMusic.Sound:Play()
	timer.Simple(Length, function() if Sound_GlobalMusic.Path == Sound then Sound_PlayTrack(Length,Sound) end end)
end




--- Tutorial



function GUI_Tutorial()

	local ent_WorldEntity = ents.CreateClientProp("prop_physics")
	ent_WorldEntity:SetAngles(Angle(0,0,0))
	ent_WorldEntity:SetPos(Vector(0,0,0))
	ent_WorldEntity:SetModel("models/re2_merchant.mdl")
	ent_WorldEntity:Spawn()
	ent_WorldEntity:Activate()

	local GUI_Tutorial_frame = vgui.Create("DFrame")
	GUI_Tutorial_frame:SetSize(540,540)
	GUI_Tutorial_frame:Center();
	GUI_Tutorial_frame:SetTitle("Tutorial")
	GUI_Tutorial_frame:MakePopup()
	GUI_Tutorial_frame.btnClose.DoClick = function()
		ent_WorldEntity:Remove()
		GUI_Tutorial_frame:Remove()
	end
		local GUI_Tutorial_Panel = vgui.Create("DPanelList")
		GUI_Tutorial_Panel:SetParent(GUI_Tutorial_frame)
		GUI_Tutorial_Panel:SetSize(520,500)
		GUI_Tutorial_Panel:SetPos(10,30)


		local GUI_Merchant_Icon = vgui.Create("DModelPanel")
		GUI_Merchant_Icon:SetParent(GUI_Tutorial_Panel)
		GUI_Merchant_Icon:SetSize(132,128)
		GUI_Merchant_Icon:SetPos(0,30)
		GUI_Merchant_Icon:SetModel(ent_WorldEntity:GetModel())
		GUI_Merchant_Icon.DoClick = function()
										local SoundTbl = table.Random(GAMEMODE.MerchantSounds)
										LocalPlayer():EmitSound(table.Random(SoundTbl),100,100)
									end
		local center = ent_WorldEntity:OBBCenter()
		local dist = ent_WorldEntity:BoundingRadius()

		GUI_Merchant_Icon:SetLookAt(center)
		GUI_Merchant_Icon:SetCamPos(center+Vector(dist,dist,0))

		local GUI_Merchant_Label_1 = vgui.Create("DLabel")
		GUI_Merchant_Label_1:SetText("This kind fellow will sell you weapons and items.")
		GUI_Merchant_Label_1:SetFont("Trebuchet18")
		GUI_Merchant_Label_1:SetParent(GUI_Tutorial_Panel)
		GUI_Merchant_Label_1:SetPos(132,54)
		GUI_Merchant_Label_1:SizeToContents()


		local GUI_Merchant_Label_2 = vgui.Create("DLabel")
		GUI_Merchant_Label_2:SetText("You can upgrade you weapons here as well." )
		GUI_Merchant_Label_2:SetFont("Trebuchet18")
		GUI_Merchant_Label_2:SetParent(GUI_Tutorial_Panel)
		GUI_Merchant_Label_2:SetPos(132,64)
		GUI_Merchant_Label_2:SizeToContents()

		local GUI_Merchant_Label_3 = vgui.Create("DLabel")
		GUI_Merchant_Label_3:SetText("For a price of course." )
		GUI_Merchant_Label_3:SetFont("Trebuchet18")
		GUI_Merchant_Label_3:SetParent(GUI_Tutorial_Panel)
		GUI_Merchant_Label_3:SetPos(132,74)
		GUI_Merchant_Label_3:SizeToContents()

		ent_WorldEntity:SetModel("models/chest.mdl")

		local GUI_Chest_Icon = vgui.Create("DModelPanel")
		GUI_Chest_Icon:SetParent(GUI_Tutorial_Panel)
		GUI_Chest_Icon:SetSize(132,128)
		GUI_Chest_Icon:SetPos(0,138)
		GUI_Chest_Icon:SetModel(ent_WorldEntity:GetModel())

		local center = ent_WorldEntity:OBBCenter()
		local dist = ent_WorldEntity:BoundingRadius()*1.6

		GUI_Chest_Icon:SetLookAt(center)
		GUI_Chest_Icon:SetCamPos(center+Vector(dist,dist,0))

		local GUI_Chest_Label_1 = vgui.Create("DLabel")
		GUI_Chest_Label_1:SetText("You can deposit your weapons in here. Its merely a storage")
		GUI_Chest_Label_1:SetFont("Trebuchet18")
		GUI_Chest_Label_1:SetParent(GUI_Tutorial_Panel)
		GUI_Chest_Label_1:SetPos(132,192)
		GUI_Chest_Label_1:SizeToContents()

		local GUI_Item_Icon = vgui.Create("DModelPanel")

		GUI_RANDOM_ITEM(GUI_Item_Icon,ent_WorldEntity)

		GUI_Item_Icon:SetParent(GUI_Tutorial_Panel)
		GUI_Item_Icon:SetSize(128,128)
		GUI_Item_Icon:SetPos(0,266)
		GUI_Item_Icon:SetModel(ent_WorldEntity:GetModel())

		local GUI_Item_Label_1 = vgui.Create("DLabel")
		GUI_Item_Label_1:SetText("Items appear throughout the game. They can be used to your benefit")
		GUI_Item_Label_1:SetFont("Trebuchet18")
		GUI_Item_Label_1:SetParent(GUI_Tutorial_Panel)
		GUI_Item_Label_1:SetPos(132,282)
		GUI_Item_Label_1:SizeToContents()

		local GUI_Item_Label_2 = vgui.Create("DLabel")
		GUI_Item_Label_2:SetText("Pick them up with your use key. To use them open your inventory by")
		GUI_Item_Label_2:SetFont("Trebuchet18")
		GUI_Item_Label_2:SetParent(GUI_Tutorial_Panel)
		GUI_Item_Label_2:SetPos(132,292)
		GUI_Item_Label_2:SizeToContents()

		local GUI_Item_Label_3 = vgui.Create("DLabel")
		GUI_Item_Label_3:SetText("pressing your sandbox menu key.")
		GUI_Item_Label_3:SetFont("Trebuchet18")
		GUI_Item_Label_3:SetParent(GUI_Tutorial_Panel)
		GUI_Item_Label_3:SetPos(132,302)
		GUI_Item_Label_3:SizeToContents()


		local GUI_Item_Label_4 = vgui.Create("DLabel")
		GUI_Item_Label_4:SetText("In the inventory you can use an item by left clicking on it.")
		GUI_Item_Label_4:SetFont("Trebuchet18")
		GUI_Item_Label_4:SetParent(GUI_Tutorial_Panel)
		GUI_Item_Label_4:SetPos(132,322)
		GUI_Item_Label_4:SizeToContents()

		local GUI_Item_Label_5 = vgui.Create("DLabel")
		GUI_Item_Label_5:SetText("You can get more options for the item by right clicking on it.")
		GUI_Item_Label_5:SetFont("Trebuchet18")
		GUI_Item_Label_5:SetParent(GUI_Tutorial_Panel)
		GUI_Item_Label_5:SetPos(132,332)
		GUI_Item_Label_5:SizeToContents()

		ent_WorldEntity:SetModel("models/crow.mdl")

		local GUI_Crow_Icon = vgui.Create("DModelPanel")
		GUI_Crow_Icon:SetParent(GUI_Tutorial_Panel)
		GUI_Crow_Icon:SetSize(132,128)
		GUI_Crow_Icon:SetPos(0,384)
		GUI_Crow_Icon:SetModel(ent_WorldEntity:GetModel())

		local center = ent_WorldEntity:OBBCenter()
		local dist = ent_WorldEntity:BoundingRadius()*1.6

		GUI_Crow_Icon:SetLookAt(center)
		GUI_Crow_Icon:SetCamPos(center+Vector(dist,dist,0))

		local GUI_Crow_Label_1 = vgui.Create("DLabel")
		GUI_Crow_Label_1:SetText("As a crow you can either attack survivors or zombies.")
		GUI_Crow_Label_1:SetFont("Trebuchet18")
		GUI_Crow_Label_1:SetParent(GUI_Tutorial_Panel)
		GUI_Crow_Label_1:SetPos(132,434)
		GUI_Crow_Label_1:SizeToContents()

		local GUI_Crow_Label_2 = vgui.Create("DLabel")
		GUI_Crow_Label_2:SetText("You earn small amounts of cash for attacking either.")
		GUI_Crow_Label_2:SetFont("Trebuchet18")
		GUI_Crow_Label_2:SetParent(GUI_Tutorial_Panel)
		GUI_Crow_Label_2:SetPos(132,444)
		GUI_Crow_Label_2:SizeToContents()

end

function GUI_RANDOM_ITEM(GUI_Item_Icon,ent_WorldEntity)

	if !GUI_Item_Icon:IsValid() then return end

	ent_WorldEntity:SetModel(table.Random(GAMEMODE.Items).Model)

	GUI_Item_Icon:SetModel(ent_WorldEntity:GetModel())

	local center = ent_WorldEntity:OBBCenter()
	local dist = ent_WorldEntity:BoundingRadius()*1.3

	GUI_Item_Icon:SetLookAt(center)
	GUI_Item_Icon:SetCamPos(center+Vector(dist,dist,0))

	timer.Simple(1,function() GUI_RANDOM_ITEM(GUI_Item_Icon,ent_WorldEntity) end )
end





























-------Crow Calcview. Yes it sucks ballz

function GM:CalcView( ply, origin, angles, fov )
	local Vehicle = ply:GetVehicle()
	local wep = ply:GetActiveWeapon()
	if ( IsValid( Vehicle ) &&
		 gmod_vehicle_viewmode:GetInt() == 1
		&& ( !IsValid(wep) || !wep:IsWeaponVisible() )
		) then
		return GAMEMODE:CalcVehicleThirdPersonView( Vehicle, ply, origin*1, angles*1, fov )
	end
	local view = {}
	view.origin 	= origin
	view.angles		= angles
	view.fov 		= fov
	// Give the active weapon a go at changing the viewmodel position
	if ( IsValid( wep ) ) then
		local func = wep.GetViewModelPosition
		if ( func ) then
			view.vm_origin,  view.vm_angles = func( wep, origin*1, angles*1 ) // Note: *1 to copy the object so the child function can't edit it.
		end
		local func = wep.CalcView
		if ( func ) then
			view.origin, view.angles, view.fov = func( wep, ply, origin*1, angles*1, fov ) // Note: *1 to copy the object so the child function can't edit it.
		end
		if ply:GetActiveWeapon():GetClass() == "weapon_peck" then
			view.origin 	= origin  - ply:GetForward() * 50
			if LocalPlayer():GetMoveType(MOVETYPE_FLY) then
				local tracedata = {}
				tracedata.start = origin
				tracedata.endpos =  origin - ply:GetForward() * 50
				tracedata.filter = ply,LocalPlayer()
				local trace = util.TraceLine(tracedata)
				if trace.HitWorld then
					view.origin = trace.HitPos
				end
			end
		end
	end
	return view
end
