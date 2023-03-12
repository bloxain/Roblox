repeat task.wait() until game:IsLoaded()
local UI = loadstring(readfile("BloxainHub/Modules/UI.Lua"))()
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
	DBright = 1
}

-- Get Update Function
local UpdateMutator;
for i, v in pairs(getgc()) do
	if type(v) == 'function' and not is_synapse_function(v) and getinfo(v).name and getinfo(v).name == "updateMutator" then
		UpdateMutator = v
	end
end

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
			wait()
			SetValues()
			return
		end
		if Flag('Jump') ~= CharValues.JumpPower or Override then
				Humanoid.JumpPower = Flag('Jump')
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
				Distance = (v.Character.HumanoidRootPart.Position - Char().HumanoidRootPart.Position).Magnitude -- I know this now correct but i have no idea how vectors like this work
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
	if Cache[1] ~= os.time() then
		Cache[1] = os.time()
		Cache[2] = game.ReplicatedStorage.getMutators:InvokeServer()
	end
	if table.find(Cache[2], Name) then
		return true
	end
end

local function HandleInv(value , Tranceparncy)
	if value == true and Tasks[9] == nil then
		Tasks[9] = {}
		for	_, Player in next, game.Players:GetPlayers() do
			table.insert(Tasks[9], Player.CharacterAdded:Connect(function(Char)
				task.wait(1)
				pcall(function() ChangePlayerVisable(Char, Tranceparncy) end)
			end))
		end
		table.insert(Tasks[9], game.Players.PlayerAdded:Connect(function(Char)
			table.insert(Tasks[9], Player.CharacterAdded:Connect(function()
				task.wait(1)
				pcall(function() ChangePlayerVisable(Char, Tranceparncy) end)
			end))
		end))
		for _, Player in next, game.Players:GetPlayers() do
			pcall(function() ChangePlayerVisable(Player.Character, Tranceparncy) end)
		end
	else
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



local function ChangeMutator(Mutator, value)
	for _, Signal in ipairs(getconnections(game.ReplicatedStorage.mutatorChanged.OnClientEvent)) do
		UpdateMutator(Mutator, value)
	end
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
		Tasks[9] = workspace.ChildAdded:Connect(function(Child)
			if Child.Name == 'tower' then
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

local function UpdateMutators()
	if Flag('Jumps') ~= 0 then
		game.ReplicatedStorage.globalJumps.Value = Flag('Jumps')
	end
	
	if Flag('High Speed') == 0 then
		game.ReplicatedStorage.globalSpeed.Value = Flag('Walk')
		ChangeMutator('speed', false)
	elseif Flag('High Speed') == 1 and CheckMutator('speed') then
		game.ReplicatedStorage.globalSpeed.Value = 25
		ChangeMutator('speed', true)
	elseif Flag('High Speed') == 2 then
		game.ReplicatedStorage.globalSpeed.Value = 25
		ChangeMutator('speed', true)
	end
	
	if Flag('Foggy') == 0 then
		game.Lighting.FogEnd = math.huge
		ChangeMutator('fog', false)
	elseif Flag('Foggy') == 1 and CheckMutator('foggy') and game.Lighting.Negative.Saturation ~= -2 then
		game.Lighting.FogEnd = 50
		ChangeMutator('fog', true)
	elseif Flag('Foggy') == 2 then
		game.Lighting.FogEnd = 50
		ChangeMutator('fog', true)
	end
	
	if Flag('double jump') == 0 then
		game.ReplicatedStorage.globalJumps.Value = 0;
		ChangeMutator('double jump', false)
	elseif Flag('double jump') == 1 and CheckMutator('foggy') and game.Lighting.Negative.Saturation ~= -2 then
		game.ReplicatedStorage.globalJumps.Value = 1;
		ChangeMutator('double jump', true)
	elseif Flag('double jump') == 2 then
		game.ReplicatedStorage.globalJumps.Value = 1;
		ChangeMutator('double jump', true)
	end
	
	if Flag('Negative') == 0 then
		game.Lighting.Negative.Saturation = 0
		game.Lighting.Negative.Enabled = false
		ChangeMutator('negative', false)
	elseif Flag('Negative') == 1 and CheckMutator('negative') and game.Lighting.Negative.Saturation ~= -2 then
		game.Lighting.Negative.Saturation = -2
		game.Lighting.Negative.Enabled = true
		ChangeMutator('negative', true)
	elseif Flag('Negative') == 2 then
		game.Lighting.Negative.Saturation = -2
		game.Lighting.Negative.Enabled = true
		ChangeMutator('negative', true)
	end
	
	if Flag('Bunny Hop') == 0 then
		game.ReplicatedStorage.bunnyJumping.Value = false
		ChangeMutator('bunny', false)
	elseif Flag('Bunny Hop') == 1 and CheckMutator('bunny') and game.Lighting.Negative.Saturation ~= -2 then
		ChangeMutator('bunny', true)
		game.ReplicatedStorage.bunnyJumping.Value = true
	elseif Flag('Bunny Hop') == 2 then
		game.ReplicatedStorage.bunnyJumping.Value = true
		ChangeMutator('bunny', true)
	end
	
	if Flag('Low Gravity') == 0 then
		workspace.Gravity = 192.2
		ChangeMutator('gravity', false)
	elseif Flag('Low Gravity') == 1 and CheckMutator('gravity') and game.Lighting.Negative.Saturation ~= -2 then
		ChangeMutator('gravity', true)
		workspace.Gravity = 147
	elseif Flag('Low Gravity') == 2 then
		workspace.Gravity = 147
		ChangeMutator('gravity', true)
	end
	
	if Flag('invincibility') == 0 then
		for _, v in next, Char():GetChildren() do
			if v.Name == 'hitboxInvincible' then
				v.Name = 'hitbox'
			end
		end
		ChangeMutator('invincibility', false)
	elseif Flag('invincibility') == 1 and CheckMutator('invincibility') then
		for _, v in next, Char():GetChildren() do
			if v.Name == 'hitbox' then
				v.Name = 'hitboxInvincible'
			end
		end
		ChangeMutator('invincibility', true)
	elseif Flag('invincibility') == 2 then
		for _, v in next, Char():GetChildren() do
			if v.Name == 'hitbox' then
				v.Name = 'hitboxInvincible'
			end
		end
		ChangeMutator('invincibility', true)
	end
	
	if Flag('invisibility') == 0 then
		HandleInv(false)
		task.wait()
		HandleInv(true, 0)
		ChangeMutator('invisibility', false)
	elseif Flag('invisibility') == 1 and CheckMutator('negative') and game.Lighting.Negative.Saturation ~= -2 then
		ChangeMutator('invisibility', true)
		HandleInv(false)
		task.wait()
		HandleInv(false)
	elseif Flag('invisibility') == 2 then
		HandleInv(false)
		task.wait()
		HandleInv(true, 1)
		ChangeMutator('invisibility', true)
	end
end

--RTX?

function RTXON(value, Update, Typef)
	for _, Parent in next, workspace:GetChildren() do
		for __, Child in next, Parent:GetChildren() do
			spawn(function()
				for _, Part in next, Child:GetDescendants() do
					if table.find({'Part', 'MeshPart'}, Part.ClassName) and Part.Material == Enum.Material.Neon then
						if value == false then
							for ___, Light in next, Part:GetChildren() do
								if Update == nil and Light.ClassName == 'SurfaceLight' or Light.ClassName == 'PointLight' and Update == nil then
									Light:Destroy()
								elseif Light.ClassName == 'SurfaceLight' or Light.ClassName == 'PointLight' then -- CHanged Brightness
									Light.Brightness = Brightness or Flag('RTXBrightness')/10
									Light.Range = Flag('RTXRange')
									Light.Color = Light.Parent.Color
								end
							end
						else
							pcall(function() Part.CashShadow = false end)
							if Flag('Surface') then
								for ___, Surface in next, {'Back', 'Bottom', 'Front', 'Left', 'Right', 'Top'} do
									local light = Instance.new('SurfaceLight', Part)
									light.Shadows = true
									light.Range = Flag('RTXRange')
									light.Brightness= Flag('RTXBrightness')/10
									light.Color = Part.Color
									light.Face = Enum.NormalId[Surface]
									light.Angle= 120
								end
							else
								local light = Instance.new('PointLight', Part)
								light.Shadows = true
								light.Range = Flag('RTXRange')
								light.Brightness= Flag('RTXBrightness')/10
								light.Color = Part.Color
							end
						end
					end
				end
			end)
		end
	end
end
-- Events
Tasks[10] = workspace.ChildAdded:Connect(function(Child)
	if Child.Name == 'tower' then
		wait(1)
		if Flag('RTX') == true then RTXON(false) wait(.5) RTXON(true) end
		pcall(function()
			workspace.tower.sections.start.floor.floor.Material = Enum.Material.Glass
			workspace.tower.sections.start.floor.floor.Transparency = 0.8
		end)
	end
end)

Tasks[8] = game.ReplicatedStorage.mutatorChanged.OnClientEvent:Connect(function()
	wait()
	UpdateMutators()
end)

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
Movment:AddSlider({Name = 'JumpPower', Min = 50, Max = 200, Flag = 'Jump', Save = true, Callback = SetValues})
Movment:AddLabel('Standerd')
Movment:AddToggle({Name = 'Inf Jump', Flag = 'InfJump', Save = true})
Movment:AddToggle({Name = "NoClip", Flag = "Noclip", Save = true, Default = false, Callback = HandelNoClip})
Movment:AddBind({Name = 'ClickTp', Flag = 'ClickTp', Save = true})
Movment:AddBind({Name = 'Spawn Platform', Flag = 'SpawnplatKey', Save = true, Default = Enum.KeyCode.Q, Callback = Spawnplatform})
Movment:AddBind({Name = 'Clear Platforms', Flag = 'DeleteplatKey', Save = true, Callback = clearplatforms})

-- TOH Mutators
local Mutators = TOH:AddSection({Name = 'Stop Mutators'})
Mutators:AddMutiToggle({Name = 'High Speed', Default = 1, Flag = 'High Speed', Save = true, Callback = UpdateMutators})
Mutators:AddMutiToggle({Name = 'Low Gravity', Default = 1, Flag = 'Low Gravity', Save = true, Callback = UpdateMutators})
Mutators:AddMutiToggle({Name = 'Foggy', Default = 1, Flag = 'Foggy', Save = true, Callback = UpdateMutators})
Mutators:AddMutiToggle({Name = 'Negative', Default = 1, Flag = 'Negative', Save = true, Callback = UpdateMutators})
Mutators:AddMutiToggle({Name = 'Bunny Hop', Default = 1, Flag = 'Bunny Hop', Save = true, Callback = UpdateMutators})
Mutators:AddMutiToggle({Name = 'invincibility', Default = 1, Flag = 'invincibility', Save = true, Callback = UpdateMutators})
Mutators:AddMutiToggle({Name = 'invisibility', Default = 1, Flag = 'invisibility', Save = true, Callback = UpdateMutators})
Mutators:AddMutiToggle({Name = 'Double Jump', Default = 1, Flag = 'double jump', Save = true, Callback = UpdateMutators})
local AUTOFARM = TOH:AddSection({Name = 'Auto Farm'})
AutoFarmStatus = TOH:AddLabel('Status: idle')
AUTOFARM:AddToggle({Name = 'Enabled', Callback = UpdateMutators})
AUTOFARM:AddButton({Name = "Beat Game", Callback = BeatGame})

-- RTX
local RTX = TOH:AddSection({Name = 'RTX'})
RTX:AddToggle({Name = 'Shadows', Save = true, Flag = 'Shadows', Callback = function(value) if value then game.Lighting.GlobalShadows = value end end}) --Callback = function(value) if value then RTXToggle:Set({Locked = false}) else RTXToggle:Set({Locked = true, Toggled = false}) end end
RTXToggle = RTX:AddToggle({Name = 'RTX', Save = true, Flag = 'RTX', Callback = RTXON})
RTX:AddSlider({Name = 'RTX brightness', Min = 1, Max = 100, Default = 7, Flag = 'RTXBrightness', Save = true, Callback = function(Value) RTXON(false, true) end})
RTX:AddSlider({Name = 'RTX Range', Min = 1, Max = 100, Default = 20, Flag = 'RTXRange', Save = true, Callback = function(Value) RTXON(false, true) end})
RTX:AddToggle({Name = 'Surface Light', Flag = 'Surface', Save = true, Callback = function() RTXON(false) wait(1) RTXON(true) end})
RTX:AddSlider({Name = 'Exposure', Min = -20, Max = 20, Default = 3, Flag = 'Exposure', Save = true, Callback = function(Value) game.Lighting.ExposureCompensation = Value/10 end})
RTX:AddSlider({Name = 'Time of day', Min = 0, Max = 24, Default = 14, Flag = 'TimeOfDay', Save = true, Callback = function(Value) game.Lighting.TimeOfDay = tostring(Value) end})

-- Genral TOH
TOH:AddButton({Name = "Make everyone a furry", Callback = function() game.ReplicatedStorage.buy:InvokeServer({kind = 'mutator', item = 'fluffy', method = 'regular'}); end})
TOH:AddBind({Name = "Time Freeze Key", Flag = "Fre", Default = Enum.KeyCode.E, Save = true, Callback = function() game.Players.LocalPlayer.PlayerScripts.timefreeze.Value = not game.Players.LocalPlayer.PlayerScripts.timefreeze.Value end})
TOH:AddButton({Name = "Give All Tools(local)", Callback = function() for _, v in next, game.ReplicatedStorage.Gear:GetChildren() do v:Clone().Parent = game.Players.LocalPlayer.Backpack end end})
TOH:AddSlider({Name = 'Change total jumps(in air)', Min = 0, Max = 500, Default = 0, Flag = 'Jumps', Callback = function(value) game.ReplicatedStorage.globalJumps.Value = value end})

-- World
World:AddToggle({Name = 'Max View Distance', Flag = 'MaxView', Save = true, Callback = function(value) if value then Player.CameraMaxZoomDistance = math.huge else Player.CameraMaxZoomDistance = Advanced.DefaultView end end})
World:AddBind({Name = 'Click Delete', Flag = 'ClickDelete', Save = true, Default = Enum.KeyCode.LeftAlt})
World:AddButton({Name = 'Undo', Callback = function() if Undo[1] then Undo[1]:Clone().Parent = workspace table.remove(Undo, 1) end end})
World:AddSlider({Name = 'Gravity', Min = 0, Max = 500, Default = Advanced.DefaultGrav, Flag = 'Gravity', Callback = SetValues})
World:AddSlider({Name = 'Fps Cap', Min = 30, Max = 488, Default = 120, Flag = 'FpsCap', Save = true, Callback = function(Value) setfpscap(Value) end})
World:AddDropdown({Name = 'Change Lighting', Options = {'Future', 'Voxel', 'Legacy', 'ShadowMap', 'Compatibility', 'Default'}, Flag = 'Lighting', Save = true, Default = 'Default', Callback = function(value) if value ~= 'Default' then sethiddenproperty(game.Lighting,"Technology",Enum.Technology[value]) else sethiddenproperty(game.Lighting,"Technology", 'Compatibility') end end})
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
UISettings:AddButton({Name = 'KILL SCRIPT', Callback = function() EMERGENCY_STOP() end})
Settings:AddLabel('Basic')
Settings:AddSlider({Name = 'Platform Size', Min = 1, Max = 30, Flag = 'PlatSize', Save = true, Default = 6})
local UISystem = Settings:AddSection({Name = 'SYSTEM 64'})
UISystem:AddSlider({Name = 'TickTime(milliseconds)', Min = 0, Max = 10000, Default = 1000, Flag = 'Tick', Save = true})
UISystem:AddSlider({Name = 'FastTickTime(milliseconds)', Min = 0, Max = 10000, Flag = 'FastTick', Save = true})
UISystem:AddSlider({Name = 'Max Undo Storage', Min = 1, Max = 1000, Default = 100, Flag = 'UndoStorage', Save = true})

-- Credits
Credit:AddLabel('Credit to Robloxain_Pro & CPU_Accelerator and a little ChatGPT')
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
	clearplatforms()
	HandelAutoFarm(false)
	HandleInv(false)
	RTXON(false)
	if Flag('Lighting') ~= 'Default' then  sethiddenproperty(game.Lighting,"Technology", 'Compatibility') end
	game.Lighting.ExposureCompensation = 0.3
	game.Lighting.TimeOfDay = '14'
	game.Lighting.GlobalShadows = false
	game.Lighting.ExposureCompensation = 0.3
	workspace.tower.sections.start.floor.floor.Material = Enum.Material.Plastic
	workspace.tower.sections.start.floor.floor.Transparency = 1
	if workspace.Gravity ~= Char().Humanoid.JumpPower ~= Flag('Jump') then
		--Char().Humanoid.JumpPower = CharValues.JumpPower
	end
	if Tasks[5] then
		Tasks[5]:Disconnect()
		Tasks[5] = nil
	end
	if Tasks[6] then
		Tasks[6]:Disconnect()
		Tasks[6] = nil
	end
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

if Flag('FpsCap') ~= 120 then setfpscap(Flag('FpsCap')) end 
if Flag('Shadows') ~= 120 then game.Lighting.GlobalShadows = true end 
if Flag('Lighting') ~= 'Default' then sethiddenproperty(game.Lighting,"Technology",Enum.Technology[Flag('Lighting')]) end 
game.Lighting.ExposureCompensation = Flag('Exposure')/10
game.Lighting.TimeOfDay = tostring(Flag('TimeOfDay'))
game.Lighting.GlobalShadows = Flag('Shadows')
pcall(function()
	workspace.tower.sections.start.floor.floor.Material = Enum.Material.Glass
	workspace.tower.sections.start.floor.floor.Transparency = 0.8
end)

if Flag('RTX') == true then
	RTXON(true)
	Player.PlayerGui.shop2.shop.items.settings.killparthue.slider.hueChanged.Event:Connect(function()
		RTXON(false, true)
	end)
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
UpdateMutators()
