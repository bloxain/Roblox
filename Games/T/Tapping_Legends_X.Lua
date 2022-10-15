local WaitTime = 10;
local WaitTime2 = .1;
local EggFarm = true
local tapvalue= ''
local UI = loadstring(readfile("BloxainHub/Modules/UI.Lua"))()

local Tap = game.ReplicatedStorage.Remotes.Tap;
local Rep = game.ReplicatedStorage.Remotes;
local Tween = game.TweenService;
local BextUpgrade = nil; -- help speed things up
local Maps = {};


local function GetUnlockedWorld()
	local Last;
	for i, v in next, game.Players.LocalPlayer.PlayerGui.Menus.Teleporter.Frame.List.TemplateList:GetChildren() do
		if v.ClassName == 'ImageLabel' and v.Background.Locked.Visible == true then
			return {Last.Name, i - 2}
		end
		Last = v
	end;
	Last = nil;
end;

local function UpgradeRubys()
	if BextUpgrade then
		for i, connection in pairs(getconnections(BextUpgrade.Upgrade.TextButton.MouseButton1Click)) do
			connection:Fire()
		end
	end
	for i, v in next, game.Players.LocalPlayer.PlayerGui.Menus.Upgrades.Frame.RubyList:GetChildren() do
		if v.ClassName == 'ImageLabel' then
			for o, connection in pairs(getconnections(v.Upgrade.TextButton.MouseButton1Click)) do
				connection:Fire()
			end
			if i == 6 and not BextUpgrade then
				BextUpgrade = v
			end
		end
	end
end

local function UpgradeCoins()
	for i, v in next, game.Players.LocalPlayer.PlayerGui.Menus.Upgrades.Frame.TokensList:GetChildren() do
		if v.ClassName == 'ImageLabel' then
			for o, connection in pairs(getconnections(v.Upgrade.TextButton.MouseButton1Click)) do
				connection:Fire()
			end
		end
	end
end
UpgradeCoins()

local function UpgradeSkins()
	for i, v in next, game.Players.LocalPlayer.PlayerGui.Menus.TapSkins.Frame.List:GetChildren() do
		if v.ClassName == 'ImageLabel' and v.Normal.Visible then
			Rep.TapSkinAction:FireServer('Purchase', i - 2)
			task.wait(1)
			Rep.TapSkinAction:FireServer('Equip', i - 2)
		end
	end
end

local function FindEggFromLand(text)
	for i ,v in next, workspace.Eggs:GetChildren() do
		if text == 'Spawn' then
			return workspace.Eggs['Basic Egg']
		end
		if text == 'Mines' then
			return workspace.Eggs['Mine Egg']
		end
		if string.find(v.Name, text) then
			return v
		end
	end
end

local function DeleteUnsedPets()
	Rep.UnequipAll:InvokeServer()
	task.wait(2)
	Rep.EquipBest:InvokeServer()
	task.wait(2)
	local equipedPets = {}
	for i, v in next, workspace.Pets[game.Players.LocalPlayer.Name]:GetChildren() do
		table.insert(equipedPets, 1, v.Name)
	end
	local Delete = {}
	for i, v in next, game.Players.LocalPlayer.PlayerGui.Menus.Pets.Frame.Pets.List:GetChildren() do
		if v.ClassName == 'Frame' and not table.find(equipedPets, v.Name) then
			table.insert(Delete, 1, v.Name)
		end
	end
	Rep.MultiDelete:InvokeServer(Delete)
end


local function GotoEgg(egg)
	local world;
	if egg == nil then
		local world = GetUnlockedWorld()
		Rep.TeleportToArea:FireServer(world[2])
		task.wait(1)
		Tween:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1), {CFrame = FindEggFromLand(world[1]).E.CFrame}):Play()
		return
	else
		for i, v in next, game.Players.LocalPlayer.PlayerGui.Menus.Teleporter.Frame.List.TemplateList:GetChildren() do
			if v.ClassName == 'ImageLabel' and v.Background.Locked.Visible == false then
				if string.find(egg, v.Name) then
					world = {v.Name, i - 1}
				end
			end
		end;
		
		local egg = GetUnlockedWorld()
		pcall(function()
			Rep.TeleportToArea:FireServer(world[2])
		end)
		task.wait(1)
		Tween:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1), {CFrame = FindEggFromLand(world[1]).E.CFrame}):Play()
	end
end

local function FarmEggs(seconds)
	GotoEgg()
	for i = 1, seconds - 5 do
		Rep.BuyEgg:InvokeServer(FindEggFromLand(GetUnlockedWorld()[1]).Name, tonumber(UI.Flags.EggAmount.Value))
		task.wait(1)
	end
	DeleteUnsedPets()
end

local function FarmCoins(seconds)
	GotoEgg()
	if GetUnlockedWorld()[1] == 'Spawn' then
		return
	end
	for i = 1, seconds / 3 do
		local CoinPack = workspace.Drops[GetUnlockedWorld()[1]]:FindFirstChildOfClass('Model'):Clone()
		tapvalue = CoinPack.Name
		Tween:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1), {CFrame = CoinPack.Circle.CFrame}):Play()
		task.wait(5)
		CoinPack:Destroy()
	end
end

local function Extract(amount)
	for i = 0, amount do
		for i = 1, 3 do
			Rep.Extract:FireServer(i)
		end
		task.wait(.1)
	end
end

local function Rebirth()
	local Last;
	local list = game.Players.LocalPlayer.PlayerGui.Menus.Rebirth.Frame.List:GetChildren()
	for i, v in next, list do
		if v.ClassName == 'Frame' and v.Name ~= 'Max' then
			if v.Make.ImageLabel.ImageColor3 == Color3.fromRGB(255, 59, 59) or v.Visible == false then
				for o, connection in pairs(getconnections(Last.Make.TextButton.MouseButton1Click)) do
					connection:Fire()
				end
			end
			Last = v
		end
	end;
	Last = nil;
end;

local function HandleRebiths()
	List = {}
	local Array = {}
	local list = game.Players.LocalPlayer.PlayerGui.Menus.Rebirth.Frame.List:GetChildren()
	for i, v in ipairs(list) do
		if v.ClassName == 'Frame' then
			List[v.Amount.Text] = v.Make.TextButton
			Array[i] = v.Amount.Text
		end
	end;
	return Array
end

local function HandleEggs()
	EggsList = {}
	local EggsArray = {}
	EggsArray[100] = 'MAX'
	for i ,v in next, workspace.Eggs:GetChildren() do
		if v.Name == 'Basic Egg' then
			EggsList['Spawn Egg'] = v
			EggsArray[i] = 'Basic Egg'
		elseif v.Name == 'Mine egg' then
			EggsList['Mines Egg'] = v
			EggsArray[i] = 'Mine Egg'
		else
			EggsList[v.Name] = v
			EggsArray[i] = v.Name
		end
	end
	return EggsArray
end

local function HandleLand(ToFnd)
	CoinsList = {}
	local ARRAY = {}
	ARRAY[100] = 'MAX'
	for i, v in next, game.Players.LocalPlayer.PlayerGui.Menus.Teleporter.Frame.List.TemplateList:GetChildren() do
		if v.ClassName == 'ImageLabel' and v.Background.Locked.Visible == false then
			CoinsList[v.Name] = {v.Name, i - 1}
			ARRAY[i] = v.Name
		end
	end;
	return ARRAY
end




local Window = UI:MakeWindow({Name = 'Tapping Legends X', ConfigFolder = 'BloxainHub/Saves'})
local Home = Window:MakeTab({Name = 'Home'})
Home:AddParagraph({Content = 'Credit to Bloxain and Legoned king...\n lets talk man you hate for no reason bruh\n anyway this was made for me to beat him'})
Home:AddToggle({Name = 'AutoTap', Flag = 'AutoTap', Default = true, Save = true})
Home:AddToggle({Name = 'Dissable Popups', Flag = 'DissablePopups', Default = false, Save = true})
Home:AddBind({Name = 'Toggle UI', Flag = 'ToggleUIKey', Default = Enum.KeyCode.F3, Callback = function() Window:Toggle() end, Save = true})

local RebirthPage = Window:MakeTab({Name = 'Rebirth'})
RebirthPage:AddLabel('Buttons')
RebirthPage:AddButton({Name = 'Rebirth', Callback = function() Rebirth() end})
RebirthPage:AddLabel('Time Based Settings')
RebirthPage:AddToggle({Name = 'Enabled', Flag = 'TimeBased', Save = true})
RebirthPage:AddSlider({Min = 1, Max = 240, Default = 60, Flag = 'RebithTime', Name = 'Delay', Save = true})
RebirthPage:AddLabel('Amount Based Settings')
RebirthPage:AddToggle({Name = 'Enabled', Flag = 'AmountBased', Save = true})
RebirthPage:AddDropdown({Name = 'Amount', Options = HandleRebiths(), Flag = 'AmountDropDown', Save = true})

local Extra = Window:MakeTab({Name = 'Extracter'})
Extra:AddLabel('Buttons')
Extra:AddButton({Name = 'Extract', Callback = function() Extract(1) end})
Extra:AddButton({Name = 'Max Extract', Callback = function() Extract(100) end})
Extra:AddLabel('Time Based')
Extra:AddToggle({Name = 'Enabeld', Flag = 'Extract', Save = true})
Extra:AddSlider({Min = 1, Max = 240, Default = 60, Flag = 'ExtractTime', Name = 'Delay', Save = true})

local Upgrader = Window:MakeTab({Name = "Upgrader"})
Upgrader:AddLabel('Buttons')
Upgrader:AddButton({Name = 'UpgradeRubys', Callback = function() UpgradeRubys() end})
Upgrader:AddButton({Name = 'Upgrade Pet Coins', Callback = function() UpgradeCoins() end})
Upgrader:AddButton({Name = 'Upgrade Tap Skins', Callback = function() UpgradeSkins() end})
Upgrader:AddLabel('Settings')
local UpgradeToggles = {Upgrader:AddToggle({Name = 'UpgradeRubys', Flag = 'UpgradeRubys'}),
Upgrader:AddToggle({Name = 'Upgrade Pet Coins', Flag = 'UpgradeCoins', Save = true}),
Upgrader:AddToggle({Name = 'Upgrade Tap Skins', Flag = 'UpgradeSkins', Save = true})}
Upgrader:AddToggle({Name = 'Change All', Flag = 'CHnageAll', Callback = function(idk) for i, v in next, UpgradeToggles do v:Set({Value = idk}) end end, Save = true})
Upgrader:AddSlider({Min = 1, Max = 240, Default = 60, Flag = 'UpgradeTime', Name = 'Delay', Save = true})

local Eggs = Window:MakeTab({Name ='Eggs&coins'})
Eggs:AddButton({Name = 'Delete not best pets', Callback = function()  end})
Eggs:AddLabel('Egg Settings')
Eggs:AddDropdown({Name = 'Egg', Options = HandleEggs(), Flag = 'Egg', Save = true})
Eggs:AddDropdown({Name = 'Amount', Options = {'1', '3', '4'}, Flag = 'EggAmount', Save = true})
Eggs:AddToggle({Name = 'Enabled', Flag = 'EggsToggle', Callback = function(Value) if not Value then return end if UI.Flags.Land.Value == 'MAX' then GotoEgg() return end GotoEgg(UI.Flags.Egg.Value) end, Save = true})
Eggs:AddToggle({Name = 'Delete Bad pets(you can still lock them)', Default = '3', Flag = 'DeletePets', Default = true})
Eggs:AddLabel('Coins')
Eggs:AddDropdown({Name = 'Land', Options = HandleLand(), Flag = 'Land', Save = true})
Eggs:AddToggle({Name = 'Enabled', Flag = 'CoinsEnabled', Callback = function(value) if not value then return end if UI.Flags.Land.Value == 'MAX' then GotoEgg() return end GotoEgg(UI.Flags.Land.Value) end, Save = true})
Eggs:AddSlider({Min = 30, Max = 300, Default = 60, Flag = 'sessoin', Name = 'delay between delete switch ect', Save = true})

task.spawn(function()
	while true do
		if UI.Flags.EggsToggle.Value and UI.Flags.CoinsEnabled.Value then
			if UI.Flags.Egg.Value == 'MAX' then
				GotoEgg()
				for i = 1, UI.Flags.sessoin.Value do
					Rep.BuyEgg:InvokeServer(FindEggFromLand(GetUnlockedWorld()[1]).Name, tonumber(UI.Flags.EggAmount.Value))
					task.wait(1)
				end
				if UI.Flags.EggsToggle.Value then
					DeleteUnsedPets()
				end
			else
				GotoEgg(UI.Flags.Egg.Value)
				for i = 0, UI.Flags.sessoin.Value do
					Rep.BuyEgg:InvokeServer(UI.Flags.Egg.Value, tonumber(UI.Flags.EggAmount.Value))
					task.wait(1) 
				end
				if UI.Flags.EggsToggle.Value then
					DeleteUnsedPets()
				end
			end
			
			task.wait(5)
			pcall(function() FarmCoins(UI.Flags.sessoin.Value) end)
		elseif UI.Flags.EggsToggle.Value then
			if UI.Flags.Egg.Value == 'MAX' then
				FarmEggs(UI.Flags.sessoin.Value)
				if UI.Flags.EggsToggle.Value then
					DeleteUnsedPets()
				end
			else
				for i = 1, UI.Flags.sessoin.Value do
					Rep.BuyEgg:InvokeServer(UI.Flags.Egg.Value, tonumber(UI.Flags.EggAmount.Value))
					task.wait(1) 
				end
				if UI.Flags.EggsToggle.Value then
					DeleteUnsedPets()
				end
			end
		elseif UI.Flags.CoinsEnabled.Value then
			pcall(function()
				task.wait(UI.Flags.sessoin.Value - 1.1)
				if UI.Flags.Egg.Value == 'MAX' then
					FarmCoins(3)
				else
					local CoinPack = workspace.Drops[UI.Flags.Land.Value]:FindFirstChildOfClass('Model'):Clone()
					tapvalue = CoinPack.Name
					Tween:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1), {CFrame = CoinPack.Circle.CFrame}):Play()
					task.wait(1.1)
					CoinPack:Destroy()
				end		
			end)
		end
		task.wait()
	end
end)

game.Players.LocalPlayer.PlayerGui.Menus.Main.Popups.ChildAdded:Connect(function(v)
	if v.ClassName == 'Frame' then
		if UI.Flags.DissablePopups.Value then
			v.Visible = false
		end
	end
end)

task.spawn(function()
	while true do
		if UI.Flags.UpgradeRubys.Value then
			UpgradeRubys()
		end
		if UI.Flags.UpgradeCoins.Value then
			UpgradeCoins()
		end
		if UI.Flags.UpgradeSkins.Value then
			UpgradeSkins()
		end
		task.wait(UI.Flags.UpgradeTime.Value)
	end
end)
task.spawn(function()
	while true do
		if UI.Flags.Extract.Value then
			Extract()
		end
		task.wait(UI.Flags.ExtractTime.Value)
	end
end)
task.spawn(function()
	while true do
		if UI.Flags.TimeBased.Value then
			Rebirth()
		end
		task.wait(UI.Flags.RebithTime.Value)
	end
end)
task.spawn(function()
	while true do
		if UI.Flags.AutoTap.Value then
			Tap:FireServer(tapvalue)
		end
		task.wait(.1)
	end
end)
task.spawn(function()
	while true do
		if UI.Flags.AmountBased.Value then
			for o, connection in pairs(getconnections(List[UI.Flags.AmountDropDown.Value].MouseButton1Click)) do
				connection:Fire()
			end
		end
		task.wait(.1)
	end
end)
