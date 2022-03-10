local col = nil
local clickon = false
local deleteon = false
local platform = false
local noclip = false
local Infjump = false
local UIS = game:GetService("UserInputService")
local Size = 6
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Selectedplayer = nil
local firetouchinterest = firetouchinterest or fake_touch or nil
local UseDisplayNames = false
local AntiAFK = false
local HeadSize = 20
local hitboxenabled = false
local PlayerSpeed = 16
local PlayerJump = 50
local UnlockZoom = false
local AddCoins = false
local remote = game:GetService("ReplicatedStorage").Remotes.sellBricks
local FireServer = Instance.new("RemoteEvent").FireServer
local autoSell = false
local HideUItoggle = false
local hideUIData = {}

-----------------------------------IMPORTENT FUNCS------------------------------------------------------------------------------------------

if KANKER_LOADED then
	local backup = debug.getupvalues
	make_writeable(debug)

	getgenv().debug.getupvalues = function(f)
		if typeof(f) == "function" then
			local s, e = pcall(backup, f)
			return (typeof(e) == 'table' and e or {})
		else
			return backup(f + 1)
		end
	end

	make_readonly(debug)
end


function LoadData()
	if not isfile("Simulator#6732.lua") then
		return
	else
		local data = game:GetService("HttpService"):JSONDecode(readfile("Simulator#6732.lua"))
		Size = data.PSize
		UseDisplayNames = data.usedisplayNames
		AntiAFK = data.anti_afk

	end
end

LoadData()

function fastrocket()
	while wait() do
		if true then
			for _,obj in pairs(debug.getregistry()) do
				if type(obj) == "table" then
					if obj.RocketSpeed then
						obj.RocketSpeed = 99999999
					end
				end
			end
		else
			for _,obj in pairs(debug.getregistry()) do
				if type(obj) == "table" then
					if obj.RocketSpeed then
						obj.RocketSpeed = 2
					end
				end
			end
		end
	end
end



function Nocooldown()
	while wait() do
		if true then
			for _,obj in pairs(debug.getregistry()) do
				if type(obj) == "table" then
					if obj.Cooldown then
						obj.Cooldown = 0
						obj.BurstWait = 0
						obj.Bursts = 1
					end
				end
			end
		else
			for _,obj in pairs(debug.getregistry()) do
				if type(obj) == "table" then
					if obj.Cooldown then
						obj.Cooldown = 5
					end
				end
			end
		end
	end
end


-----------------------------------EXTRA----------------------------------------------------------------------------------------------------

game:GetService('RunService').RenderStepped:connect(function()
	if hitboxenabled then
		for i,v in next, game:GetService('Players'):GetPlayers() do
			if v.Name ~= game:GetService('Players').LocalPlayer.Name then
				pcall(function()
					v.Character.HumanoidRootPart.Size = Vector3.new(HeadSize,HeadSize,HeadSize)
					v.Character.HumanoidRootPart.Transparency = 0.8
					v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really white")
					v.Character.HumanoidRootPart.Material = "Neon"
					v.Character.HumanoidRootPart.CanCollide = false
				end)
			end
		end
	end
end)

function GetCharacter()
	return game.Players.LocalPlayer.Character
end

function Teleport(pos)
	if clickon == true then
		local Char = GetCharacter()
		if Char then
			Char:MoveTo(pos)
		end
	end
end


local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
	if AntiAFK == true then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)


UIS.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
		Teleport(Mouse.Hit.p)
	end
end)

UserInput = game:GetService("UserInputService")

function Spawnplatform()
	if platform == true then
		if game.Players.LocalPlayer.Character:FindFirstChild("Left Leg") then
			local Clone = Instance.new("Part")
			Clone.Parent = workspace
			Clone.Anchored = true
			Clone.Position = game.Players.LocalPlayer.Character["Left Leg"].Position
			Clone.Size = Vector3.new(Size, 1, Size)
			Clone.Name = "falksjdhflkjasdhflkjasdhflkjasdfhj"
		else
			local Clone = Instance.new("Part")
			Clone.Parent = workspace
			Clone.Anchored = true
			Clone.Position = game.Players.LocalPlayer.Character["LeftFoot"].Position
			Clone.Size = Vector3.new(Size, 1, Size)
			Clone.Name = "falksjdhflkjasdhflkjasdhflkjasdfhj"
		end
	end
end
--Hold CLTR and click to delete parts (you need to rejoin if you delete something wrong)
local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()

Mouse.Button1Down:connect(function()
	if deleteon == true then
		if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
		if not Mouse.Target then return end
		Mouse.Target:Destroy()
	end 
end)

game:GetService('RunService').Stepped:connect(function()
	if noclip then
		if game:GetService("Players").LocalPlayer.Character ~= nil then
			for _, child in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true then
					child.CanCollide = false
				end
			end
		end
	end

	if PlayerSpeed ~= 16 then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = PlayerSpeed
	end

	if UnlockZoom == true then game.Players.LocalPlayer.CameraMaxZoomDistance = 99999 else game.Players.LocalPlayer.CameraMaxZoomDistance = 128 end

	if PlayerJump ~= 50 then
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = PlayerJump
	end

	if AddCoins then
		game:GetService("ReplicatedStorage").Remotes.generateBoost:FireServer("Coins", 999999, 99999999)
	end

	if autoSell then
		FireServer(remote)
	end

	if UserInput:IsKeyDown(Enum.KeyCode.Space) then
		if Infjump == true then
			if game.Players.LocalPlayer.Character:FindFirstChild("Left Leg") then
				local Clone = Instance.new("Part")
				Clone.Parent = workspace
				Clone.Anchored = true
				Clone.Position = game.Players.LocalPlayer.Character["Left Leg"].Position
				Clone.Size = Vector3.new(6, 1, 6)
				Clone.Name = "falksjdhflkjasdhflkjasdhflkjasdfhjsfdgsd"
				Clone.Transparency = 1
				wait()
				Clone:Destroy()
			else
				local Clone = Instance.new("Part")
				Clone.Parent = workspace
				Clone.Anchored = true
				Clone.Position = game.Players.LocalPlayer.Character["LeftFoot"].Position
				Clone.Size = Vector3.new(6, 1, 6)
				Clone.Name = "falksjdhflkjasdhflkjasdhflkjsfdgsdfgasdfhj"
				Clone.Transparency = 1
				wait()
				Clone:Destroy()
			end
		end
	end
end)

UserInput.InputBegan:Connect(function(input , gameProccesedevent)
	if gameProccesedevent then
	else
		if input.KeyCode == Enum.KeyCode.Space then
			if Infjump == true then
				if game.Players.LocalPlayer.Character:FindFirstChild("Left Leg") then
					local Clone = Instance.new("Part")
					Clone.Parent = workspace
					Clone.Anchored = true
					Clone.Position = game.Players.LocalPlayer.Character["Left Leg"].Position
					Clone.Size = Vector3.new(6, 1, 6)
					Clone.Name = "falksjdhflkjasdhflkjasdhflkjasdfhjsfdgsd"
					Clone.Transparency = 1
					wait(0.1)
					Clone:Destroy()
				else
					local Clone = Instance.new("Part")
					Clone.Parent = workspace
					Clone.Anchored = true
					Clone.Position = game.Players.LocalPlayer.Character["LeftFoot"].Position
					Clone.Size = Vector3.new(6, 1, 6)
					Clone.Name = "falksjdhflkjasdhflkjasdhflkjsfdgsdfgasdfhj"
					Clone.Transparency = 1
					wait(0.1)
					Clone:Destroy()
				end
			end
		end		
	end

end)


-- https://raw.githubusercontent.com/Stefanuk12/Venyx-UI-Library/main/source.lua
-- https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Reuploaded
-- // Initialising the UI
local Venyx = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Venyx-UI-Library/main/source.lua"))()
local UI = Venyx.new("Destruction Simulator GUI")
local Themes = {
	Background = Color3.fromRGB(24, 24, 24),
	Glow = Color3.fromRGB(0, 0, 0),
	Accent = Color3.fromRGB(10, 10, 10),
	LightContrast = Color3.fromRGB(188, 51, 54),
	DarkContrast = Color3.fromRGB(14, 14, 14),  
	TextColor = Color3.fromRGB(255, 255, 255)
}



local main = UI:addPage("Main")
local AD = main:addSection("additional features")
local MainGame = main:addSection("Game")
local localplayer = main:addSection("localplayer")

local server = UI:addPage("Server")
local Splayer = server:addSection("Players")

local DS = UI:addPage("Destruction Simulator")
local DSSel = DS:addSection("basic")

local theme = UI:addPage("Settings")
local Confic = theme:addSection("Config")
local Colors = theme:addSection("Colors")




localplayer:addSlider("Player Speed", 16, 16, 300, function(value) PlayerSpeed = value game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value end)

localplayer:addSlider("Player jumpPower", 50, 50, 300, function(value) PlayerJump = value game.Players.LocalPlayer.Character.Humanoid.JumpPower = value end)

MainGame:addSlider("Gravity", 196.2, 0, 196.2, function(value) workspace.Gravity = value end)

AD:addButton("save location", function() col = workspace[game.Players.LocalPlayer.Name].HumanoidRootPart.Position end)

AD:addButton("Load location", function() workspace[game.Players.LocalPlayer.Name]:MoveTo(col) end)

AD:addButton("Clear Platforms", function() clearplatforms() end)

AD:addButton("Load Dark Dex", function() game:HttpGet('https://raw.githubusercontent.com/SpeedSterKawaii/Dark-Dex/main/dex.lua', true) end)

AD:addToggle("noclip", false, function(value) noclip = value end)

AD:addToggle("Inf jump", false,function(value) Infjump = value end)

AD:addToggle("cntrl click teleport", false, function(value) clickon = value end)

AD:addToggle("alt click delete", false, function(value) deleteon = value end)

AD:addToggle("spawn platform", false, function(value) platform = value end)

AD:addToggle("Anti AFK", AntiAFK, function(value) AntiAFK = value end)

AD:addToggle("Unlock Zomm Distance", false, function(value) UnlockZoom = value end)

AD:addKeybind("Hide UI", nil, function() toggleUI(HideUItoggle) HideUItoggle = not HideUItoggle end)

Splayer:addTextbox("Player", Size, function(text) FindPlayer(text) end)

Splayer:addButton("teleport to player", function() game.Players.LocalPlayer.character:MoveTo(workspace[Selectedplayer.Name].HumanoidRootPart.Position) end)

Splayer:addButton("Kill Player", function() KillPlayer() end)

Splayer:addButton("Bring Player", function() BringPlayer() end)

Splayer:addButton("Give Player Tool", function() GiveTool() end)

Splayer:addToggle("Hitbox expander", false, function(value) hitboxenabled = value if value == false then for i,v in next, game:GetService('Players'):GetPlayers() do 	v.Character.HumanoidRootPart.Size = Vector3.new(2,1,2)v.Character.HumanoidRootPart.Transparency = 1	v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really white")	v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end end end)

DSSel:addToggle("Inf Coins", false, function(value) AddCoins = value end)

DSSel:addToggle("autoSell", false, function(value) autoSell = value end)

DSSel:addTextbox("Change Level(max 55)", "", function(value) game:GetService("ReplicatedStorage").Remotes.generateBoost:FireServer("Levels", 480, tonumber(value)) end)

DSSel:addButton("Fastrocket", function() fastrocket() end)

DSSel:addButton("No Cool Down", function() Nocooldown() end)

Confic:addTextbox("Platform size", "", function(value) Size = value end)

Confic:addTextbox("Hitbox size", "20", function(value) HeadSize = tonumber(value) end)

Confic:addToggle("Use Display Names", UseDisplayNames, function(value) UseDisplayNames = value end)

Confic:addKeybind("Noclip key", nil, function() noclip = not noclip end)

Confic:addKeybind("spawn platform key", Enum.KeyCode.Q, function() Spawnplatform()() end)

Confic:addButton("Save", function() SaveData() end)

for theme, color in pairs(Themes) do
	Colors:addColorPicker(theme, color, function(color3) UI:setTheme(theme, color3) end) -- // Adding a color picker for each type of theme customisable
end

Colors:addKeybind("Toggle UI Keybind", Enum.KeyCode.F3, function() UI:toggle() end)

Colors:addButton("Kill GUI", function() game.CoreGui["universal Gui"]:Destroy() script:Destroy()end)


--             functions
--------------------------------------

function toggleUI(show)
	if not hideUIData then
		for i, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
			if v:IsA("ScreenGui") then
				if v.Enabled then
					hideUIData = {}
					table.insert(hideUIData, 1, v.Name)
				end
			end
		end
	end

	for i = 1, #hideUIData do
		if game.Players.LocalPlayer.PlayerGui:FindFirstChild(hideUIData[i]) then
			game.Players.LocalPlayer.PlayerGui[hideUIData[i]].Enabled = show
		end
	end

	for i, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do		
		if v:IsA("ScreenGui") and show then
			if v.Enabled then
				for i = 1, #hideUIData do
					table.remove(hideUIData, 1)
				end
				table.insert(hideUIData, 1, v.Name)
			end
		end
	end
	game.CoreGui.ThemeProvider.Enabled = show
end

function clearplatforms()
	for i, v in pairs(workspace:GetChildren()) do
		if v.Name == "falksjdhflkjasdhflkjasdhflkjasdfhj" then
			v:Destroy()
		end
	end
end



function FindPlayer(target)
	if UseDisplayNames == true then
		for i,v in pairs(game.Players:GetPlayers()) do 
			if v.DisplayName:lower():sub(1,#target) == target:lower() then
				Selectedplayer = v
			end
		end
	else
		for i,v in pairs(game.Players:GetPlayers()) do 
			if v.Name:lower():sub(1,#target) == target:lower() then
				Selectedplayer = v
			end
		end
	end
end

function KillPlayer()
	local player = game.Players.LocalPlayer
	if not firetouchinterest then
		UI:Notify("Upgrade exploit.", "Your exploit requires firetouchinterest!")
		return
	end
	local target = Selectedplayer
	player.Character.Humanoid.Name = 1
	local l = player.Character["1"]:Clone()
	l.Parent = player.Character
	l.Name = "Humanoid"
	wait(.2)
	player.Character["1"]:Destroy()
	workspace.CurrentCamera.CameraSubject = player.Character
	player.Character.Humanoid.DisplayDistanceType = "None"
	player.Character.Humanoid:UnequipTools()
	local v = player.Backpack:FindFirstChildOfClass("Tool")
	if not v then
		UI:Notify("Please get a tool.", "Tool not found!")
		return
	end
	v.Parent = player.Character
	v.Parent = player.Character.HumanoidRootPart
	firetouchinterest(target.Character.HumanoidRootPart, v.Handle, 0)
	firetouchinterest(target.Character.HumanoidRootPart, v.Handle, 1)
	pcall(function() player.Character.HumanoidRootPart.CFrame = CFrame.new(0, workspace.FallenPartsDestroyHeight + 5, 0) end)
	wait(.3)
	player.Character:Remove()
	player.CharacterAdded:Wait()
end


function BringPlayer()
	local savepos = workspace[game.Players.LocalPlayer.Name].HumanoidRootPart.Position
	local player = game.Players.LocalPlayer
	if not firetouchinterest then
		UI:Notify("Upgrade exploit.", "Your exploit requires firetouchinterest!")
		return
	end
	local target = Selectedplayer
	player.Character.Humanoid.Name = 1
	local l = player.Character["1"]:Clone()
	l.Parent = player.Character
	l.Name = "Humanoid"
	wait(.2)
	player.Character["1"]:Destroy()
	workspace.CurrentCamera.CameraSubject = player.Character
	player.Character.Humanoid.DisplayDistanceType = "None"
	player.Character.Humanoid:UnequipTools()
	local v = player.Backpack:FindFirstChildOfClass("Tool")
	if not v then
		UI:Notify("Please get a tool.", "Tool not found!")
		return
	end
	v.Parent = player.Character
	v.Parent = player.Character.HumanoidRootPart
	firetouchinterest(target.Character.HumanoidRootPart, v.Handle, 0)
	firetouchinterest(target.Character.HumanoidRootPart, v.Handle, 1)
	pcall(function() player.Character.HumanoidRootPart.CFrame = NormPos end)
	wait(.3)
	player.Character:Remove()
	player.CharacterAdded:Wait()
	workspace[game.Players.LocalPlayer.Name]:MoveTo(savepos)
end

function GiveTool()
	local player = game.Players.LocalPlayer
	local target = Selectedplayer
	player.Character.Humanoid.Name = 1
	local l = player.Character["1"]:Clone()
	l.Parent = player.Character
	l.Name = "Humanoid"
	wait(.2)
	player.Character["1"]:Destroy()
	player.Character.Humanoid.DisplayDistanceType = "None"
	player.Character.Humanoid:UnequipTools()
	local v = player.Backpack:FindFirstChildOfClass("Tool")
	if not v then
		UI:Notify("Please get a tool.", "Tool not found!")
		return
	end
	v.Parent = player.Character
	v.Parent = player.Character.HumanoidRootPart
end

function SaveData()
	local datatosave = {
		PSize = Size;
		usedisplayNames = UseDisplayNames;
		anti_afk = AntiAFK
	}
	writefile("Destruction Simulator#6732.lua", game:GetService("HttpService"):JSONEncode(datatosave))
end
