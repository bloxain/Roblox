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
local Cache = {0, {}}
local Dissabled_Mutators = {'bunny', 'gravity'}
local CharValues = {
	UseJumpPower = false,
	JumpPower = 0
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
	DefaultGrav = 196.19999694824,
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
			game.ReplicatedStorage.globalSpeed.Value = Flag('Walk')
		end
		if Flag('Gravity') ~= Advanced.DefaultGrav or Override then
			workspace.Gravity = Flag('Gravity')
		end
		if Flag('MaxView') or Override then
			Player.CameraMaxZoomDistance = math.huge
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
	for _, v in next, Char:GetDescendants() do
		if v.ClassName == 'Part' and v.Name ~= 'hitbox' and v.Name ~= 'hitboxInvincible' and v.Name ~= 'HumanoidRootPart' then
			v.Transparency = Value
		end
	end
	Char.Head.face.Transparency = Value
end

local function CheckMutator(Name)
	if Cache[1] == os.time() then
		print('Cached!')
		return Cache[2]
	else
		Cache[1] = os.time()
		Cache[2] = game.ReplicatedStorage.getMutators:InvokeServer()
	end
	if table.find(Cache[2], Name) then
		return true
	end
end

local function HandleInv(value)
	if value == true and Tasks[9] == nil then
		Tasks[9] = {}
		for	_, Player in next, game.Players:GetPlayers() do
			table.insert(Tasks[9], Player.CharacterAdded:Connect(function(Char)
				task.wait(1)
				pcall(function() ChangePlayerVisable(Char, 0) end)
			end))
		end
		table.insert(Tasks[9], game.Players.PlayerAdded:Connect(function(Char)
			table.insert(Tasks[9], Player.CharacterAdded:Connect(function()
				task.wait(1)
				pcall(function() ChangePlayerVisable(Char, 0) end)
			end))
		end))
		for _, Player in next, game.Players:GetPlayers() do
			pcall(function() ChangePlayerVisable(Player.Character, 0) end)
		end
	else
		if CheckMutator('invisibility') then
			for _, Player in next, game.Players:GetPlayers() do
				pcall(function() ChangePlayerVisable(Player.Character, 1) end)
			end
		end
		if Tasks[9] ~= nil then
			for _, v in next, Tasks[9] do
				v:Disconnect()
				v = nil
			end
			Tasks[9] = nil
		end
	end	
end

------------
--| GAME |--
------------
local mt = getrawmetatable(game)
local old = mt.__namecall
local protect = newcclosure or protect_function
if not protect then
	print("Incompatible Exploit Warning", "Your exploit does not support protection against stack trace errors, resulting to fallback function")
	protect = function(f) return f end
end
setreadonly(mt, false)
mt.__namecall = protect(function(self, ...)
	local method = getnamecallmethod()
	if method == "Kick" then
		wait(9e9)
		return
	end
	return old(self, ...)
end)
hookfunction(game.Players.LocalPlayer.Kick,protect(function() wait(9e9) end))
game.Players.LocalPlayer.PlayerScripts.LocalScript.Disabled = true
game.Players.LocalPlayer.PlayerScripts.LocalScript2.Disabled = true



local function FakeDissable()
	for _, Mutator in next, Dissabled_Mutators do
		if CheckMutator(Mutator) then
			for _, Signal in next, getconnections(game.ReplicatedStorage.mutatorChanged.OnClientEvent) do
				Signal:Fire(Mutator, false)
			end
		end
	end
end

Tasks[8] = game.ReplicatedStorage.mutatorChanged.OnClientEvent:Connect(function(Mutator, Active)
	if Active and table.find(Dissabled_Mutators, Mutator) then
		for i, v in next, getconnections(game.ReplicatedStorage.mutatorChanged.OnClientEvent) do
			v:Fire(Mutator, false)
		end
	end
end)
if table.find(Dissabled_Mutators, '') then table.insert(Dissabled_Mutators, '') else table.remove(Dissabled_Mutators, table.find(Dissabled_Mutators, '')) end
local function UpdateMutators()
	if Flag('High Speed') then game.ReplicatedStorage.globalSpeed.Value = 16 elseif CheckMutator('speed') and game.ReplicatedStorage.globalSpeed.Value > 16 then game.ReplicatedStorage.globalSpeed.Value *= 1.25 else game.ReplicatedStorage.globalSpeed.Value = 16 end
	if Flag('Low Gravity') then workspace.Gravity = 196.19999694824 elseif CheckMutator('gravity') and workspace.Gravity ~= 196.19999694824 then workspace.Gravity = 196.19999694824 end
	if Flag('Foggy') then game.Lighting.FogEnd = math.huge end
	if Flag('Negative') then game:GetService("Lighting").Negative.Enabled = false end
	if Flag('Bunny Hop') then table.insert(Dissabled_Mutators, 'bunny') else table.remove(Dissabled_Mutators, table.find(Dissabled_Mutators, 'bunny')) end
	if Flag('Invincibility') then table.insert(Dissabled_Mutators, 'Invincibility') else table.remove(Dissabled_Mutators, table.find(Dissabled_Mutators, 'Invincibility')) end
	
	
	if Flag('') then

	end if Flag('') then

	end if Flag('') then

	end if Flag('') then

	end if Flag('') then

	end
	FakeDissable()
end

local function FindParts()
	local Parts = {}
	local Finder = Instance.new('Part', workspace)
	local timee = 7
	Finder.CanCollide = false
	Finder.Size = Vector3.new(200, 1, 200)
	Finder.Anchored = false
	Finder.Touched:Connect(function(Part)
		if Part.CanCollide and not Part.Parent:FindFirstChild('Humanoid') and Part.Name ~= 'wall' and Part.Position.Y > timee + 1 and Part.Position.Y < workspace.tower.sections.finish.Connections.bottom.Position.Y then
			table.insert(Parts, Part)
			print('Found '..Part.Name..' at y = '..Part.Position.Y)
			timee = Part.Position.Y
		end
	end)	
	
	while Finder.Position.Y < workspace.tower.sections.finish.Connections.bottom.Position.Y do
		task.wait()
		Finder.AssemblyLinearVelocity = Vector3.new(0, 60, 0)
	end
	Finder:Destroy()
	return Parts
end
Tweem = game.TweenService
Player = game.Players.LocalPlayer
local function BeatGame()
	-- text
	AutoFarmStatus:Set('Status: Scaning tower')
	local Parts = FindParts()
	AutoFarmStatus:Set('Starting..')
	Hum = Player.Character.HumanoidRootPart
	pcall(function()
		Player.Character.KillScript:Destroy()
	end)
	for _, Part in next, Parts do
		AutoFarmStatus:Set('Status: Going to Y = '..tostring(math.floor(Part.Position.Y)))
		Tweem:Create(Hum, TweenInfo.new(3, Enum.EasingStyle.Linear), {CFrame = Part.CFrame, Velocity = Vector3.new(0, 0, 0)}):Play()
		task.wait(3)
	end
end


local function HandelAutoFarm(Name)
	if value and Tasks[9] == nil then
		Tasks[9] = workspace.ChildAdded:Connect(function(thing)
			if thing.Name == 'tower' then
				task.wait(.5)
				BeatGame()
			end
		end)
	else
		if Tasks[9] then
			task.cancel(Tasks[9])
			Tasks[9] = nil
		end
	end
end



-- Pages
local Window = UI:MakeWindow({Name = 'Tower Of Hell V2', ConfigFolder = 'BloxainHub/Saves'})
local Movment = Window:MakeTab({Name = 'Movment'})
local TOH = Window:MakeTab({Name = 'TOH'})
local World = Window:MakeTab({Name = 'World'})
local System = Window:MakeTab({Name = 'Enviorment'})
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

-- TOH
local Mutators = TOH:AddSection({Name = 'Stop Mutators'})
Mutators:AddToggle({Name = 'High Speed', Flag = 'High Speed', Save = true, Callback = UpdateMutators})
Mutators:AddToggle({Name = 'Low Gravity', Flag = 'Low Gravity', Save = true, Callback = UpdateMutators})
Mutators:AddToggle({Name = 'Foggy', Flag = 'Foggy', Save = true, Callback = UpdateMutators})
Mutators:AddToggle({Name = 'Negative', Flag = 'Negative', Save = true, Callback = UpdateMutators})
Mutators:AddToggle({Name = 'Bunny Hop', Flag = 'Bunny Hop', Save = true, Callback = UpdateMutators})
Mutators:AddToggle({Name = 'Checkpoints', Flag = 'Checkpoints', Save = true, Callback = UpdateMutators})
Mutators:AddToggle({Name = 'invincibility', Flag = 'invincibility', Save = true, Callback = UpdateMutators})
Mutators:AddToggle({Name = 'invisibility', Flag = 'invisibility', Save = true, Callback = HandleInv})
local AUTOFARM = TOH:AddSection({Name = 'Auto Farm'})
AutoFarmStatus = TOH:AddLabel('Status: idle')
AUTOFARM:AddToggle({Name = 'Enabled', Callback = UpdateMutators})
AUTOFARM:AddButton({Name = "Beat Game", Callback = BeatGame})

TOH:AddMutiToggle({Name = 'test', Flag = 'testg', Save = true, Callback = function(value) print(value) end})
TOH:AddBind({Name = "Time Freeze Key", Flag = "Fre", Default = Enum.KeyCode.E, Save = true, Callback = function() game.Players.LocalPlayer.PlayerScripts.timefreeze.Value = not game.Players.LocalPlayer.PlayerScripts.timefreeze.Value end})
TOH:AddButton({Name = "Give All Tools(local)", Callback = function() for _, v in next, game.ReplicatedStorage.Gear:GetChildren() do v:Clone().Parent = game.Players.LocalPlayer.Backpack end end})




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

-- Settings
Settings:AddLabel('UI')
local UISettings = Settings:AddSection({Name = 'UI Settings'})
UISettings:AddBind({Name = 'Toggle UI', Flag = 'ToggleUi', Save = true, Default = Enum.KeyCode.F3, Callback = function() Window:Toggle() end, Save = true})
UISettings:AddToggle({Name = 'Fast Dragging', Flag = 'FastDrag', Save = true, Callback = function(value) UI.Settings.Movement.Lerp = not value UI.Settings.Control().Write(UI.Settings) end})
UISettings:AddToggle({Name = 'Diffrent Dragging', Flag = 'DIffrentDragging', Save = true, Callback = function(value) UI.Settings.Movement.SmallScreen = value UI.Settings.Control().Write(UI.Settings) end, Default = UI.Settings.Movement.SmallScreen})
UISettings:AddSlider({Name = 'Drag Speed', Flag = 'DragSpeed',Min = 1, Max = 100, Save = true, Default = 10, Callback = function(value) UI.Settings.Movement.LerpSpeed = value / 20 end})
UISettings:AddSlider({Name = 'ESP Size', Min = 75, Max = 400, Flag = 'EspSize', Default = 100, Save = true, Callback = UpdateSizes})
Settings:AddLabel('Basic')
Settings:AddSlider({Name = 'Platform Size', Min = 1, Max = 30, Flag = 'PlatSize', Save = true, Default = 6})
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


-------------
--| START |--
-------------
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
FakeDissable()