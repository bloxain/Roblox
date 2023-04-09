repeat task.wait() until game:IsLoaded()
local UI = loadstring(readfile(Modules.."/UI.Lua"))()
local Createfunction = Instance.new('BindableEvent')

local UserInput = game:GetService('UserInputService')
local Tweem = game.TweenService

local Players = game.Players
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local WorstWasher = 0
local bypassed = {}
local Tasks = {}
local Undo = {}
local CharValues = {
	UseJumpPower = false,
	JumpPower = 0
}
local Locations = {
	pickup = Vector3.new(-39.4496, -7, -11.3961),
	Dropoff = Vector3.new(-138.862, -7, -7.86725)

}

-- Table Funcs
object = {
	Find = function(Object, str, Property)
		str = string.lower(str)
		for i, v in ipairs(Object:GetChildren()) do
			if Property and string.find(string.lower(v[Property]), str) then
				return v
			end
			if string.find(string.lower(v.Name), str) then
				return v
			end
		end
	end
}
-- Needed at the top
local function Flag(flag)
	if UI.Flags[flag] then
		return UI.Flags[flag].Value
	end
end

local function Round(number, idk)
	if not idk then
		idk	= 1
	end
	number = number / idk
	local decimal = number - math.floor(number)
	if decimal >= .5 then
		return math.ceil(number) * idk
	else
		return math.floor(number) * idk
	end
end

local Advanced = {
	TickTime = .1,
	FastTickTime = 0,
	DefaultGrav = Round(workspace.Gravity),
	DefaultView = Round(Player.CameraMaxZoomDistance),
	PlayerName = Player.DisplayName,
	DLighting = gethiddenproperty(game.Lighting, 'Technology'),
	DFog = game.Lighting.FogEnd,
	DBright = game.Lighting.Brightness
}



-- Character funcs
local function Char(player)
	if not player then
		if Player.Character and Player.Character:FindFirstChild('Humanoid') then
			return Player.Character
		else
			task.wait(.1)
			Char()
			return
		end
	end

	local Return = object.Find(Players, player, 'DisplayName')
	if not Return then
		task.wait(.1)
		Char(player)
		return
	end
	return Return.Character
end

local function SetCharValues(Char)
	if not Char.Humanoid then
		SetCharValues()
		return
	end
	local Humanoid = Char.Humanoid
	CharValues.UseJumpPower = Humanoid.UseJumpPower
	if CharValues.UseJumpPower then
		CharValues.JumpPower = Humanoid.JumpPower
		return
	end
	CharValues.JumpPower = Round(Humanoid.JumpHeight)
end
SetCharValues(Char())

-- SCRIPT FUNCS
local function SetValues(Override)
	pcall(function()
		local Humanoid = Char().Humanoid
		if not Humanoid then
			SetValues()
			return
		end
		if Flag('Jump') ~= CharValues.JumpPower or Override then
			if CharValues.UseJumpPower then
				Humanoid.JumpPower = Flag('Jump')
			else
				Humanoid.JumpHeight = Flag('Jump')
			end
		end
		if Flag('Walk') ~= 16 or Override then
			Humanoid.WalkSpeed = Flag('Walk')
		end
		if Flag('Gravity') ~= Advanced.DefaultGrav or Override then
			workspace.Gravity = Flag('Gravity')
		end
		if Flag('MaxView') or Override then
			Player.CameraMaxZoomDistance = math.huge
		end 
	end)
end

local function Spawnplatform(Transparency)
	local Clone = Instance.new("Part")
	Clone.Parent = workspace
	Clone.Anchored = true
	Clone.Size = Vector3.new(Flag('PlatSize'), 1, Flag('PlatSize'))
	Clone.Name = "falksjdhflkjasdhflkjasdhflkjasdfhj"
	Clone.Transparency = Transparency or 0

	if game.Players.LocalPlayer.Character:FindFirstChild("Left Leg") then
		Clone.Position = Player.Character["Left Leg"].Position
	else
		Clone.Position = Player.Character["LeftFoot"].Position
	end
	return Clone
end

local function clearplatforms()
	for i, v in ipairs(workspace:GetChildren()) do
		if v.Name == "falksjdhflkjasdhflkjasdhflkjasdfhj" then
			v:Destroy()
		end
	end
end

local function Mathbypass(Returnflag, StopFlag)
	local oldRandom
	oldRandom = hookfunction(math.random, newcclosure(function(Min, Max)
		if Flag(StopFlag) then
			return Flag(Returnflag)
		end
		return oldRandom(Min, Max)
	end))
end

-- UI FUNCS
local function UpdateSizes()
	pcall(function()
		for _, v in ipairs(game.Players:GetPlayers()) do
			if v.Character.HumanoidRootPart:FindFirstChild('BillboardGui') and v ~= Player then
				v.Character.HumanoidRootPart:FindFirstChild('BillboardGui').Main_Frame.Size = UDim2.new(0, Flag('EspSize'), 0, Flag('EspSize') / 4)
			end
		end
	end)
end


local function CreatePlayerEsp()
	for _, v in ipairs(game.Players:GetPlayers()) do
		if v.Character.HumanoidRootPart:FindFirstChild('BillboardGui') and v ~= Player then
			local BillBoard = v.Character.HumanoidRootPart:FindFirstChild('BillboardGui')
			local function GetDistance()
				local Distance = {
					x = v.Character.HumanoidRootPart.Position.X - Char().HumanoidRootPart.Position.X,
					Y = v.Character.HumanoidRootPart.Position.Y - Char().HumanoidRootPart.Position.Y,
					Z = v.Character.HumanoidRootPart.Position.Z - Char().HumanoidRootPart.Position.Z
				}
				local Distance = Distance.x + Distance.Y + Distance.Z -- I know this now correct but i have no idea how vectors like this work
				if Distance < 0 then
					Distance *= -1
				end
				if Distance > 1000 then
					return tostring(Round(Distance / 1000))..'K'
				elseif Distance > 1000000 then
					return tostring(Round(Distance / 1000000))..'M'
				end
				return tostring(Round(Distance))
			end
			print(v.Name..': '..GetDistance())

			if v.Team == Player.Team then
				BillBoard.Main_Frame.Fill.BackgroundColor3 = Color3.fromRGB(0, 217, 0)
			else
				BillBoard.Main_Frame.Fill.BackgroundColor3 = Color3.fromRGB(203, 0, 0)
			end

			BillBoard.Main_Frame.TextLabel.Text = v.Name..': '..GetDistance()
			Tweem:Create(BillBoard.Main_Frame.Fill, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.fromScale(v.Character.Humanoid.Health / v.Character.Humanoid.MaxHealth, 1)}):Play()
		elseif v ~= Player then
			local Main_Frame = Instance.new("Frame")
			local Fill = Instance.new("Frame")
			local TextLabel = Instance.new("TextLabel")
			local BillBoardGui = Instance.new('BillboardGui', v.Character.HumanoidRootPart)

			Main_Frame.Name = "Main_Frame"
			Main_Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Main_Frame.BackgroundTransparency = 0.700
			Main_Frame.Position = UDim2.new(0.450, 0, 0.518, 0)
			Main_Frame.Size = UDim2.new(0, Flag('EspSize'), 0, Flag('EspSize') / 4)

			Fill.Name = "Fill"
			Fill.Parent = Main_Frame
			Fill.Size = UDim2.fromScale(1, 1)

			TextLabel.Parent = Main_Frame
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Position = UDim2.fromScale(0.035, 0)
			TextLabel.Size = UDim2.fromScale(0.92, 1)
			TextLabel.Font = Enum.Font.Ubuntu
			TextLabel.FontFace.Weight = Enum.FontWeight.Bold
			TextLabel.Text = v.Name
			TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel.TextScaled = true
			TextLabel.TextSize = 14.000
			TextLabel.TextWrapped = true
			Instance.new('UICorner', Main_Frame)
			Instance.new('UICorner', Fill)

			BillBoardGui.ClipsDescendants = false
			BillBoardGui.AlwaysOnTop = true
			BillBoardGui.ResetOnSpawn = false
			BillBoardGui.Active = true
			BillBoardGui.ExtentsOffset = Vector3.new(-.6, 3, 0)
			BillBoardGui.Size = UDim2.fromOffset(200, 50)
			BillBoardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			Main_Frame.Parent = BillBoardGui
		end
		task.wait(Advanced.FastTickTime)
	end
end

local function HandelNoClip(value)
	if value == true and Tasks[3] == nil then
		Tasks[3] = game["Run Service"].Stepped:Connect(function()
			for _, v in next, Player.Character:GetChildren() do
				if v.ClassName == 'Part' then
					v.CanCollide = false
				end
			end
		end)
	else
		if Tasks[3] then
			Tasks[3]:Disconnect()
			Tasks[3] = nil
		end
	end
end

local function HandeEsp(value)
	if value == true and Tasks[7] == nil then
		Tasks[7] = task.spawn(function()
			while true do
				pcall(function()
					CreatePlayerEsp()
					task.wait(Advanced.FastTickTime)
				end)
			end
		end)
	else
		if Tasks[7] then
			task.cancel(Tasks[7])
			Tasks[7] = nil
			pcall(function()
				for _, v in ipairs(game.Players:GetPlayers()) do
					if v.Character.HumanoidRootPart:FindFirstChild('BillboardGui') and v ~= Player then
						v.Character.HumanoidRootPart:FindFirstChild('BillboardGui'):Destroy()
					end
				end
			end)
		end
	end
end
--MeshPart
Player = game.Players.LocalPlayer
local function FillBasket()
	Char():MoveTo(Locations.pickup)
	Spawnplatform()
	task.wait(Advanced.TickTime)
	game.ReplicatedStorage.Events.DropClothesInChute:FireServer()
	for i = 0, 1000 do
		if Player.NonSaveVars.BackpackAmount.Value ~= Player.NonSaveVars.BasketSize.Value and Player.NonSaveVars.TotalWashingMachineCapacity.Value ~= Player.NonSaveVars.BackpackAmount.Value then
			if Player.NonSaveVars.BasketStatus.Value ~= 'Dirty' and Player.NonSaveVars.BackpackAmount.Value ~= 0 then if Player.NonSaveVars.BasketStatus.Value ~= '' then
					break
				end end
			local Clothing = workspace.Debris.Clothing:FindFirstChildOfClass('MeshPart')
			if Clothing then
				Char().HumanoidRootPart.CFrame = CFrame.new(Clothing.Position.X, Locations.pickup.Y, Clothing.Position.Z)
				task.wait(Advanced.FastTickTime)
				game.ReplicatedStorage.Events.GrabClothing:FireServer(Clothing)
				print(Clothing)
			end
			task.wait(Advanced.FastTickTime)
		end
	end
end

local function LoadWashers() -- Base
	local Washers = Player.NonSaveVars.OwnsPlot.Value.WashingMachines
	Char():MoveTo(Vector3.new(Player.NonSaveVars.OwnsPlot.Value.Base.Position.X, Player.NonSaveVars.OwnsPlot.Value.Base.Position.Y - 10, Player.NonSaveVars.OwnsPlot.Value.Base.Position.Z))
	Spawnplatform()
	task.wait(Advanced.TickTime)
	--while Player.NonSaveVars.BackpackAmount.Value == Player.NonSaveVars.BasketSize.Value do
	for _, v in next, Washers:GetChildren() do
		game.ReplicatedStorage.Events.LoadWashingMachine:FireServer(v)
	end
	task.wait(Advanced.FastTickTime)
	--end
end
local function UnLoadWashers() -- Base
	local Washers = Player.NonSaveVars.OwnsPlot.Value.WashingMachines
	Char():MoveTo(Vector3.new(Player.NonSaveVars.OwnsPlot.Value.Base.Position.X, Player.NonSaveVars.OwnsPlot.Value.Base.Position.Y - 10, Player.NonSaveVars.OwnsPlot.Value.Base.Position.Z))
	Spawnplatform()
	task.wait(Advanced.TickTime)
	task.wait(Advanced.TickTime)
	for _, v in next, Washers:GetChildren() do
		--	while Player.NonSaveVars.TotalWashingMachineCapacity.Value == Player.NonSaveVars.BackpackAmount.Value do
		game.ReplicatedStorage.Events.UnloadWashingMachine:FireServer(v)
		task.wait(Advanced.FastTickTime)
		--	end
	end
	task.wait(Advanced.FastTickTime)
end
function DropOffClothes()
	Char():MoveTo(Locations.Dropoff)
	task.wait(Advanced.TickTime)
	game.ReplicatedStorage.Events.DropClothesInChute:FireServer()
end
function GetBaskets()
	local function GetBest()
		local ReturnVal;
		for _, v in next, Player.SaveVars.Baskets:GetChildren() do
			ReturnVal = v.Name
		end
		return ReturnVal
	end
	game.ReplicatedStorage.Events.BuyBasket:InvokeServer(tostring(GetBest() + 1))
end

local function PlaceBestWashers()
	local TotalWashers = {};
	for _, v in next, Player.SaveVars.Inventory:GetChildren() do
		TotalWashers[v.Name] = v.Value
	end
	for _, v in next, Player.NonSaveVars.OwnsPlot.Value.WashingMachines:GetChildren() do
		if TotalWashers[v.Name] then
			TotalWashers[v.Name] += 1
		end
		TotalWashers[v.Name] = 1
	end
	local PlaceNum = 1
	for i = 1, 1000 do -- Bad but who cares
		if TotalWashers[tostring(1000 - i)] then
			if PlaceNum == 8 then
				break
			end
			print(1000-i)
			for _ = 1, TotalWashers[tostring(1000 - i)] do
				game.ReplicatedStorage.Events.PlaceWashingMachine:InvokeServer(tostring(1000 - i), PlaceNum, {})
				WorstWasher = tostring(1000 - i)
				PlaceNum += 1
			end
		end
	end
end
local function BuyWashers()
	local ohString1 = "79"
	for i = 1, 80 do
		pcall(function()
			local washer = tostring(80-i)
			if game.ReplicatedStorage.Events.BuyWashingMachine:InvokeServer(washer) == true and washer > WorstWasher then
				repeat task.wait(Advanced.FastTickTime) until game.ReplicatedStorage.Events.BuyWashingMachine:InvokeServer(washer) ~= true
			end
		end)
	end
end

local function FormatUI()
	for _, v in next, Player.PlayerGui.Buttons:GetChildren() do
		v:Destroy()
	end
	Player.PlayerGui.Info.Frame.Coins.ImageColor3 = Color3.fromRGB(25, 25, 25)
	Player.PlayerGui.Info.Frame.Gems.ImageColor3 = Color3.fromRGB(25, 25, 25)
	Player.PlayerGui.EditMode.EditButton.ImageColor3 = Color3.fromRGB(25, 25, 25)
	Player.PlayerGui.EditMode.EditButton.Furniture.ImageColor3 = Color3.fromRGB(25, 25, 25)
	Player.PlayerGui.Info.Frame.Backpack.ImageColor3 = Color3.fromRGB(25, 25, 25)
	Player.PlayerGui.Info.Frame.Coins.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Player.PlayerGui.Info.Frame.Gems.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Player.PlayerGui.EditMode.EditButton.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Player.PlayerGui.Info.Frame.Backpack.Label.TextColor3 = Color3.fromRGB(255, 255, 255)

	local Slider = Instance.new('ImageLabel', Player.PlayerGui.Info.Frame.Backpack) Slider.ImageColor3 = Color3.fromRGB(0, 160, 0) Slider.Size = UDim2.fromOffset(0, Player.PlayerGui.Info.Frame.Backpack.AbsoluteSize.Y) Slider.Image = 'rbxassetid://3570695787' Slider.BackgroundTransparency = 1 Slider.ScaleType = Enum.ScaleType.Slice Slider.SliceScale = 0.15 Slider.SliceCenter = Rect.new(100, 100, 100, 100)
	local function Update()
		Player.PlayerGui.Info.Frame.Backpack.ImageColor3 = Color3.fromRGB(25, 25, 25)
		Player.PlayerGui.Info.Frame.Backpack.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
		Tweem:Create(Slider, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.fromOffset((Player.PlayerGui.Info.Frame.Backpack.AbsoluteSize.X / Player.NonSaveVars.BasketSize.Value) * Player.NonSaveVars.BackpackAmount.Value, Player.PlayerGui.Info.Frame.Backpack.AbsoluteSize.Y)}):Play()
	end
	Player.PlayerGui.Info.Frame.Backpack.Changed:Connect(Update)
	Player.PlayerGui.Info.Frame.Backpack.Label.Changed:Connect(Update)
end
FormatUI()

local function HandleAutoFarm(value)
	if value == true and Tasks[10] == nil then
		Tasks[10] = task.spawn(function()
			while true do
				pcall(function()
					if Flag('AutoFill') then
						FillBasket()
					end if Flag('AutoLoad') then
						LoadWashers()
					end if Flag('AutoUnload') then
						UnLoadWashers()
					end if Flag('AutoSell') then
						DropOffClothes()
					end
					clearplatforms()
				end)
			end
		end)
	else
		if Tasks[10] then
			task.cancel(Tasks[10])
			Tasks[10] = nil
		end
	end
end

local function HandleAutoBuy(value) -- There is lot to be done here but the game wont let you buy any more than 8 of each washing things so i will always progress
	if value == true and Tasks[11] == nil then
		Tasks[11] = task.spawn(function()
			while true do
				pcall(function()
					BuyWashers()
					PlaceBestWashers()
					task.wait(100)
					GetBaskets()
					task.wait(100)
				end)
			end
		end)
	else
		if Tasks[11] then
			task.cancel(Tasks[10])
			Tasks[11] = nil
		end
	end
end

pcall(function() -- Start
	PlaceBestWashers()
end)

-- Pages
local Window = UI:MakeWindow({Name = 'Laundry Simulator', ConfigFolder = 'BloxainHub/Saves'})
local Movment = Window:MakeTab({Name = 'Movment'})
local World = Window:MakeTab({Name = 'World'})
local System = Window:MakeTab({Name = 'AutoFarm'})
local Playerpage = Window:MakeTab({Name = 'Players'})
local Settings = Window:MakeTab({Name = 'Settings'})
local Credit = Window:MakeTab({Name = 'Credits'})

-- MoveMent
Movment:AddLabel('Basic')
Movment:AddSlider({Name = 'Walkspeed', Min = 16, Max = 100, Flag = 'Walk', Callback = SetValues, Save = true})
Movment:AddSlider({Name = 'JumpPower', Min = CharValues.JumpPower, Max = 200, Flag = 'Jump', Save = true, Callback = SetValues})
Movment:AddLabel('Standerd')
Movment:AddToggle({Name = 'Inf Jump', Flag = 'InfJump', Save = true})
Movment:AddToggle({Name = "NoClip", Flag = "Noclip", Save = true, Default = false, Callback = HandelNoClip})
Movment:AddBind({Name = 'ClickTp', Flag = 'ClickTp', Save = true})
Movment:AddBind({Name = 'Spawn Platform', Flag = 'SpawnplatKey', Save = true, Default = Enum.KeyCode.Q, Callback = Spawnplatform})
Movment:AddBind({Name = 'Clear Platforms', Flag = 'DeleteplatKey', Save = true, Callback = clearplatforms})


-- World
World:AddToggle({Name = 'Max View Distance', Flag = 'MaxView', Default = true, Save = true, Callback = function(value) if value then Player.CameraMaxZoomDistance = math.huge else Player.CameraMaxZoomDistance = Advanced.DefaultView end end})
World:AddBind({Name = 'Click Delete', Flag = 'ClickDelete', Save = true, Default = Enum.KeyCode.LeftAlt})
World:AddButton({Name = 'Undo', Callback = function() if Undo[1] then Undo[1]:Clone().Parent = workspace table.remove(Undo, 1) end end})
World:AddSlider({Name = 'Gravity', Min = 0, Max = 500, Default = Advanced.DefaultGrav, Flag = 'Gravity', Callback = SetValues})
World:AddSlider({Name = 'Fps Cap', Min = 30, Max = 488, Default = 120, Flag = 'FpsCap', Save = true, Callback = function(Value) setfpscap(Value) end})
World:AddDropdown({Name = 'Change Lighting', Options = {'Future', 'Voxel', 'Legacy', 'ShadowMap', 'Compatibility', 'Default'}, Flag = 'Lighting', Save = true, Default = 'Default', Callback = function(value) if value ~= 'Default' then sethiddenproperty(game.Lighting,"Technology",Enum.Technology[value]) else sethiddenproperty(game.Lighting,"Technology", Advanced.DLighting) end end})

-- Game
System:AddToggle({Name = 'Enabled (idk why there are even toggles)', Flag = 'Autofarming', Default = false, Save = false, Callback = HandleAutoFarm})
System:AddToggle({Name = 'Auto Fill Basket', Flag = 'AutoFill', Default = true, Save = true})
System:AddToggle({Name = 'Auto Load Washers', Flag = 'AutoLoad', Default = true, Save = true})
System:AddToggle({Name = 'Auto UnLoad', Flag = 'AutoUnload', Default = true, Save = true})
System:AddToggle({Name = 'Auto Sell', Flag = 'AutoSell', Default = true, Save = true})
System:AddLabel('AutoBuy')
System:AddToggle({Name = 'Auto buy/place washers & baskets', Flag = 'AutoBuying', Default = false, Save = false, Callback = HandleAutoBuy})
System:AddButton({Name = 'Buy Washers', Callback = BuyWashers})
System:AddButton({Name = 'Equip Washers', Callback = PlaceBestWashers})
System:AddButton({Name = 'Buy Basket', Callback = GetBaskets})

-- Players
Playerpage:AddLabel('LocalPlayer')
Playerpage:AddToggle({Name = 'AntiAFK', Flag = 'AntiAfk', Save = true})
Playerpage:AddTextbox({Name = 'PlayerName', Flag = 'UserName', TextDisappear = true})
Playerpage:AddButton({Name = 'Teleport', Callback = function() local Hum if Char(Flag('UserName')) then Hum = Char(Flag('UserName')).HumanoidRootPart else return end if Flag('Instanttp') then Char():MoveTo(Hum.Position) else Tweem:Create(Char().HumanoidRootPart, TweenInfo.new(3), {CFrame = Hum.CFrame}):Play() end end})
Playerpage:AddToggle({Name = 'ESP', Flag = 'ESPON', Callback = HandeEsp})

-- Settings
Settings:AddLabel('UI')
Settings:AddBind({Name = 'Toggle UI', Flag = 'ToggleUi', Save = true, Default = Enum.KeyCode.F3, Callback = function() Window:Toggle() end, Save = true})
Settings:AddButton({Name = 'Kill Script', Callback = function() EMERGENCY_STOP() end})
local UISettings = Settings:AddSection({Name = 'UI Settings'})
UISettings:AddBind({Name = 'Toggle UI', Flag = 'ToggleUi', Save = true, Default = Enum.KeyCode.F3, Callback = function() Window:Toggle() end, Save = true})
UISettings:AddToggle({Name = 'Fast Dragging', Flag = 'FastDrag', Save = true, Callback = function(value) UI.Settings.Movement.Lerp = not value UI.Settings.Control().Write(UI.Settings) end})
UISettings:AddToggle({Name = 'Diffrent Dragging', Flag = 'DIffrentDragging', Save = true, Callback = function(value) UI.Settings.Movement.SmallScreen = value UI.Settings.Control().Write(UI.Settings) end, Default = UI.Settings.Movement.SmallScreen})
UISettings:AddSlider({Name = 'Drag Speed', Flag = 'DragSpeed',Min = 1, Max = 100, Save = true, Default = 10, Callback = function(value) UI.Settings.Movement.LerpSpeed = value / 20 end})
Settings:AddLabel('Basic')
local UISystem = Settings:AddSection({Name = 'SYSTEM 64'})
UISystem:AddSlider({Name = 'Platform Size', Min = 1, Max = 30, Flag = 'PlatSize', Save = true, Default = 50})
UISystem:AddSlider({Name = 'TickTime(milliseconds)', Min = 0, Max = 10000, Default = 1000, Flag = 'Tick', Save = true})
UISystem:AddSlider({Name = 'FastTickTime(milliseconds)', Min = 0, Max = 10000, Flag = 'FastTick', Save = true})
UISystem:AddSlider({Name = 'Max Undo Storage', Min = 1, Max = 1000, Default = 100, Flag = 'UndoStorage', Save = true})

-- Credits
Credit:AddLabel('Credit to Robloxain_Pro and CPU_Accelerator')
Credit:AddButton({Name = 'Join Discord', Callback = function() setclipboard('https://discord.gg/PPFYacGb2b') end})

-- Lopps
function Tick()
	SetValues(true)
	return task.spawn(function()
		while true do
			SetValues()
			task.wait(Flag('Tick') / 1000)
		end
	end)
end

function FastTick()
	return task.spawn(function()
		while true do
			if UserInput:IsKeyDown(Enum.KeyCode.Space) and Flag('InfJump') then
				task.spawn(function()
					local Plat = Spawnplatform(1)
					task.wait(.1)
					Plat:Destroy()
				end)
			end
			task.wait(Flag('FastTick') / 1000)
		end
	end)
end
Tasks[1] = FastTick()
Tasks[2] = Tick()

function EMERGENCY_STOP()
	Window:Delete()
	task.cancel(Tasks[1])
	task.cancel(Tasks[2])
	HandelNoClip(false)
	HandeEsp(false)
	if Tasks[5] then
		Tasks[5]:Disconnect()
		Tasks[5] = nil
	end
	if Tasks[6] then
		Tasks[6]:Disconnect()
		Tasks[6] = nil
	end
	Char().Humanoid.Health = 0
	Window = nil
end

local VirtualUser=game:service'VirtualUser'
Tasks[6] = Player.Idled:connect(function()
	if Flag('AntiAfk') then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)

Tasks[5] = Mouse.Button1Down:connect(function()
	if Mouse.Target and Flag('ClickDelete') ~= 'None' and UserInput:IsKeyDown(Flag('ClickDelete')) then
		table.insert(Undo, 1, Mouse.Target:Clone())
		Undo[Flag('UndoStorage')] = nil
		Mouse.Target:Destroy()
	elseif Mouse.Target and Flag('ClickTp') ~= 'None' and UserInput:IsKeyDown(Flag('ClickTp')) then
		Char():MoveTo(Mouse.Hit.p) 
	end
end)
