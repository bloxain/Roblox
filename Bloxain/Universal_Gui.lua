repeat task.wait() until game:IsLoaded()
local Modules = _G.BloxainSettings.Modules
local UI = loadstring(readfile(Modules.."/UI.Lua"))()
local Createfunction = Instance.new('BindableEvent')

local UserInput = game:GetService('UserInputService')
local Tweem = game.TweenService

local Players = game.Players
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local bypassed = {}
local Tasks = {}
local Undo = {}
local CharValues = {
	UseJumpPower = false,
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
		return math.ceil(number) * idkvs
	else
		return math.floor(number) * idk
	end
end

local Advanced = {
	TickTime = .1,
	FastTickTime = 0,
	DefaultGrav = Round(workspace.Gravity),
--	DefaultView = Round(Player.CameraMaxZoomDistance), --test
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
		if Flag('NoFog') or Override then
			game.Lighting.FogEnd = math.huge
		elseif Override == false then
			game.Lighting.FogEnd = Advanced.DFog
		end
		if Flag('FullBright') or Override then
			game.Lighting.Brightness = 3
		elseif Override == false then
			game.Lighting.Brightness = Advanced.DBright
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

local function CreateBypass(Obj, Proporty, StopFlag)
	local gameMT = getrawmetatable(Obj.Parent)
	local psuedoEnv = {
		["__index"] = gameMT.__index
	}
	setreadonly(gameMT, false)
	bypassed[Proporty] = Obj[Proporty]
	----------------------------------------------- Gavity Bypass
	gameMT.__index = newcclosure(function(self, index, ...)
		if self == Obj and index == Proporty and not checkcaller() and Flag(StopFlag) then
			return bypassed[Proporty]
		end
		return psuedoEnv.__index(self, index, ...)
	end)
	-----------------------------------------------
	setreadonly(gameMT, true)
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
				Distance = Distance.x + Distance.Y + Distance.Z -- I know this now correct but i have no idea how vectors like this work
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

local function HandleNoPartDetect(value)
	if value == true then
		for i, connection in pairs(getconnections(workspace.ChildAdded)) do
			connection:Disable()
		end

		for i, connection in pairs(getconnections(workspace.DescendantAdded)) do
			connection:Disable()
		end
	else
		for i, connection in pairs(getconnections(workspace.ChildAdded)) do
			connection:Enable()
		end

		for i, connection in pairs(getconnections(workspace.DescendantAdded)) do
			connection:Enable()
		end
	end
end
local Tasks = {}
local Player = game.Players.LocalPlayer

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

local function HandeHitBoxExpander(value)
	if value == true and Tasks[3] == nil then
		Tasks[4] = task.spawn(function()
			while true do
				pcall(function()
					for _, v in ipairs(game.Players:GetPlayers()) do
						if v ~= Player then
							local HitBoxSize = Flag('HitBoxSize')
							v.Character[Flag('HitBoxPart')].Size = Vector3.new(HitBoxSize, HitBoxSize, HitBoxSize)
							v.Character[Flag('HitBoxPart')].Transparency = Flag('HitBoxTran') / 100
						end
						task.wait(Flag('FastTick') / 1000)
					end
				end)
			end
		end)
	else
		if Tasks[4] then
			task.cancel(Tasks[4])
			Tasks[4] = nil
			pcall(function()
				for _, v in ipairs(game.Players:GetPlayers()) do
					if v ~= Player then
						v.Character[Flag('HitBoxPart')].Size = Vector3.new(2, 2, 1)
						v.Character[Flag('HitBoxPart')].Transparency = 0
					end
				end
			end)
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

local function ChangePlayerVisable(Char, Value)
	task.wait(1)
	for _, v in next, Char:GetDescendants() do
		if v.ClassName == 'Part' then
			v.Transparency = Value or 0
		end
	end
	Char.Head.face.Transparency = Value or 0
end

local function HandeInv(value)
	if value == true and Tasks[8] == nil then
		Tasks[8] = {}
		table.insert(Tasks[8], game.Players.PlayerAdded:Connect(function(SPlayer)
			table.insert(Tasks[8], SPlayer.CharacterAdded:Connect(ChangePlayerVisable))
		end))
		for _, SPlayer in game.Players:GetChildren() do
			pcall(function()
				table.insert(Tasks[8], SPlayer.CharacterAdded:Connect(ChangePlayerVisable))
				ChangePlayerVisable(SPlayer.Character)
			end)
		end
	else
		if Tasks[8] then
			for _, v in Tasks[8] do
				v:Disconnect()
				v = nil
			end
			Tasks[8] = nil
		end
	end
end


-----------------
--| Top Logic |--
-----------------
local JpowerName='JumpHeight';
CharValues['JumpPower'] = Char().Humanoid.JumpPower
if not CharValues.UseJumpPower then
	JpowerName = 'JumpPower'
	CharValues['JumpPower'] = Char().Humanoid.JumpHeight
end

-- Pages
local Window = UI:MakeWindow({Name = 'UniversalGUI', ConfigFolder = 'BloxainHub/Saves'})
local Movment = Window:MakeTab({Name = 'Movment'})
local World = Window:MakeTab({Name = 'World'})
local System = Window:MakeTab({Name = 'Enviorment'})
local Playerpage = Window:MakeTab({Name = 'Players'})
local Settings = Window:MakeTab({Name = 'Settings'})
local Credit = Window:MakeTab({Name = 'Credits'})

-- MoveMent
Movment:AddLabel('Basic')
Movment:AddSlider({Name = 'Walkspeed', Min = 16, Max = 100, Flag = 'Walk', Callback = SetValues, Save = true})
Movment:AddSlider({Name = JpowerName, Min = CharValues.JumpPower, Max = 200, Flag = 'Jump', Save = true, Callback = SetValues})
Movment:AddLabel('Standerd')
Movment:AddToggle({Name = 'Inf Jump', Flag = 'InfJump', Save = true})
Movment:AddToggle({Name = "NoClip", Flag = "Noclip", Save = true, Default = false, Callback = HandelNoClip})
Movment:AddBind({Name = 'ClickTp', Flag = 'ClickTp', Save = true})
Movment:AddBind({Name = 'Spawn Platform', Flag = 'SpawnplatKey', Save = true, Default = Enum.KeyCode.Q, Callback = Spawnplatform})
Movment:AddBind({Name = 'Clear Platforms', Flag = 'DeleteplatKey', Save = true, Callback = clearplatforms})


-- World
World:AddToggle({Name = 'Max View Distance', Flag = 'MaxView', Save = true, Callback = function(value) if value then Player.CameraMaxZoomDistance = math.huge else Player.CameraMaxZoomDistance = Advanced.DefaultView end end})
World:AddBind({Name = 'Click Delete', Flag = 'ClickDelete', Save = true, Default = Enum.KeyCode.LeftAlt})
World:AddButton({Name = 'Undo', Callback = function() if Undo[1] then Undo[1]:Clone().Parent = workspace table.remove(Undo, 1) end end})
World:AddSlider({Name = 'Gravity', Min = 0, Max = 500, Default = Advanced.DefaultGrav, Flag = 'Gravity', Callback = SetValues})
World:AddSlider({Name = 'Fps Cap', Min = 30, Max = 488, Default = 120, Flag = 'FpsCap', Save = true, Callback = function(Value) setfpscap(Value) end})
World:AddDropdown({Name = 'Change Lighting', Options = {'Future', 'Voxel', 'Legacy', 'ShadowMap', 'Compatibility', 'Default'}, Flag = 'Lighting', Save = true, Default = 'Default', Callback = function(value) if value ~= 'Default' then sethiddenproperty(game.Lighting,"Technology",Enum.Technology[value]) else sethiddenproperty(game.Lighting,"Technology", Advanced.DLighting) end end})
World:AddToggle({Name = 'Remove Fog', Flag = 'NoFog', Save = true, Callback = SetValues})
World:AddToggle({Name = 'Full Bright', Flag = 'FullBright', Save = true, Callback = SetValues})

-- Enveriment
local RandomBypass = System:AddSection({Name = 'Force Random Output'})
RandomBypass:AddToggle({Name = 'Enabled', Flag = 'RandReturn', Save = true})
RandomBypass:AddSlider({Name = 'Return Value', Max = 100, Flag = 'RandomReturn', Save = true})
RandomBypass:AddButton({Name = 'Start(Required)', Callback = function() Mathbypass('RandomReturn', 'RandReturn') end})
-- Players
Playerpage:AddLabel('LocalPlayer')
Playerpage:AddToggle({Name = 'AntiAFK', Flag = 'AntiAfk', Save = true})
Playerpage:AddTextbox({Name = 'PlayerName', Flag = 'UserName', TextDisappear = true})
Playerpage:AddButton({Name = 'Teleport', Callback = function() local Hum if Char(Flag('UserName')) then Hum = Char(Flag('UserName')).HumanoidRootPart else return end if Flag('Instanttp') then Char():MoveTo(Hum.Position) else Tweem:Create(Char().HumanoidRootPart, TweenInfo.new(3), {CFrame = Hum.CFrame}):Play() end end})
local HitBoxSec = Playerpage:AddSection({Name = 'HitBox Expander'})
HitBoxSec:AddDropdown({Name = 'Part', Options = {'Head', 'HumanoidRootPart'}, Flag = 'HitBoxPart', Save = true, Default = 'Head'})
HitBoxSec:AddSlider({Name = 'Size', Min = 2, Max = 50, Flag = 'HitBoxSize', Save = true, Default = 5})
HitBoxSec:AddSlider({Name = 'Transparency', Min = 0, Max = 100, Flag = 'HitBoxTran', Save = true, Default = 85})
HitBoxSec:AddToggle({Name = 'Enabled', Callback = HandeHitBoxExpander})
Playerpage:AddToggle({Name = 'ESP', Flag = 'ESPON', Callback = HandeEsp})
Playerpage:AddToggle({Name = 'HidePlayers', Flag = 'ESPON', Callback = HandeInv})

-- Settings
Settings:AddLabel('UI')
local UISettings = Settings:AddSection({Name = 'UI Settings'})
UISettings:AddBind({Name = 'Toggle UI', Flag = 'ToggleUi', Save = true, Default = Enum.KeyCode.F3, Callback = function() Window:Toggle() end, Save = true})
UISettings:AddToggle({Name = 'Fast Dragging', Flag = 'FastDrag', Save = true, Callback = function(value) UI.Settings.Movement.Lerp = not value UI.Settings.Control().Write(UI.Settings) end})
UISettings:AddToggle({Name = 'Diffrent Dragging', Flag = 'DIffrentDragging', Save = true, Callback = function(value) UI.Settings.Movement.SmallScreen = value UI.Settings.Control().Write(UI.Settings) end, Default = UI.Settings.Movement.SmallScreen})
UISettings:AddSlider({Name = 'Drag Speed', Flag = 'DragSpeed',Min = 1, Max = 100, Save = true, Default = 10, Callback = function(value) UI.Settings.Movement.LerpSpeed = value / 20 end})
UISettings:AddSlider({Name = 'ES Size', Min = 75, Max = 400, Flag = 'EspSize', Default = 100, Save = true, Callback = UpdateSizes})
Settings:AddLabel('Basic')
Settings:AddSlider({Name = 'Platform Size', Min = 1, Max = 30, Flag = 'PlatSize', Save = true, Default = 6})
local AcBypasses = Settings:AddSection({Name = 'AntiCheat'})
AcBypasses:AddToggle({Name = 'InstantTp', Flag = 'Instanttp', Save = true})
AcBypasses:AddToggle({Name = 'Gravity', Flag = 'BypassGravity', Save = true})
AcBypasses:AddToggle({Name = 'WalkSpeed', Flag = 'BypassWalk', Save = true})
AcBypasses:AddToggle({Name = 'JumpPower', Flag = 'BypassJumpP', Save = true})
AcBypasses:AddButton({Name = 'Acivate(last resort can cuase bugs)', Callback = function() 		
	CreateBypass(workspace, 'Gravity', 'BypassGravity')
	CreateBypass(Char().Humanoid, 'WalkSpeed', 'BypassWalk')
	CreateBypass(Char().Humanoid, 'JumpPower', 'BypassJumpP')
end})
AcBypasses:AddToggle({Name = 'Stop Part Dection(will prob break things or not work & no acivate required)', Flag = 'StopPartDetect', Callback = HandleNoPartDetect})
local UISystem = Settings:AddSection({Name = 'SYSTEM 64'})
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
	HandeHitBoxExpander(false)
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
		local Hum
		if Flag('Instanttp') then 
			Char():MoveTo(Mouse.Hit.p) 
		else
			Tweem:Create(Char().HumanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(Mouse.Hit.p.X, Mouse.Hit.p.Y + 2, Mouse.Hit.p.Z), Velocity = Vector3.new()}):Play()
		end
	end
end)

local instance = game.Players.LocalPlayer.Character.Humanoid
old = hookmetamethod(game, "__index", newcclosure(function(self, key)
	if self == instance and key == "SeatPart" then
		return workspace.Baseplate
	end
	return old(self, key)
end))

if Flag('FpsCap') ~= 120 then
	setfpscap(Flag('FpsCap'))
end if Flag('Lighting') ~= 'Default' then
	sethiddenproperty(game.Lighting,"Technology",Enum.Technology[Flag('Lighting')]) 
end

if Flag('Noclip') then
	Tasks[3] = game["Run Service"].Stepped:Connect(function()
		for _, v in next, Player.Character:GetChildren() do
			if v.ClassName == 'Part' then
				v.CanCollide = false
			end
		end
	end)
end

