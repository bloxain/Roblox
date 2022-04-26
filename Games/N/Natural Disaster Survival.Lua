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
local unlockzoom = false
local walkspeed = 16
local jumpPower = 50
local HideUItoggle = false
local touchon = false
local Vote = true
local Fall = false
local NoScreen = false
local AwalysWin = false
local AntiAcid = false
local AntiVius = false
local NoCloud = false
local AntiTsunami = false
local AntiAlll = false
local hideUIData = {}
local Accessorys = {}

function SaveData()
	local datatosave = {
		["UseDisplayNames"] = UseDisplayNames,
		["AntiAFK"] = AntiAFK,
		["Vote"] = Vote,
		["platform"] = platform,
		["clickon"] = clickon,
		["deleteon"] = deleteon,
		["Infjump"] = Infjump,
		["noclip"] = noclip,
		["unlockzoom"] = unlockzoom,
		["Fall"] = Fall,
		["NoScreen"] = NoScreen,
		["AntiAcid"] = AntiAcid,
		["AntiVius"] = AntiVius,
		["NoCloud"] = NoCloud,
		["AntiTsunami"] = AntiTsunami
	}
	writefile("Disater#1283.lua", game:GetService("HttpService"):JSONEncode(datatosave))
end

function LoadData()
	if not isfile("Disater#1283.lua") then
		return
	else
		local data = game:GetService("HttpService"):JSONDecode(readfile("Disater#1283.lua"))
		UseDisplayNames = data.UseDisplayNames
		AntiAFK = data.AntiAFK
		Vote = data.Vote
		platform = data.platform
		clickon = data.clickon
		deleteon = data.deleteon
		Infjump = data.Infjump
		noclip = data.noclip
		unlockzoom = data.unlockzoom
		Fall = data.Fall
		NoScreen = data.NoScreen
		AntiAcid = data.AntiAcid
		AntiVius = data.AntiVius
		NoCloud = data.NoCloud
		noclip = data.noclip
		AntiTsunami = data.AntiTsunami
	end
end

LoadData()

for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
	if v:IsA("Accessory") then
		table.insert(Accessorys, 1, v.Name)
	end
end

if game.Players.LocalPlayer.Character.Humanoid.UseJumpPower == false then
	jumpPower = 7
end

UserInput = game:GetService("UserInputService")

--Hold CLTR and click to delete parts (you need to rejoin if you delete something wrong)
local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()


-- https://raw.githubusercontent.com/Stefanuk12/Venyx-UI-Library/main/source.lua
-- https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Reuploaded
-- // Initialising the UI
local Venyx = loadstring(game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Venyx_UI.Lua"))()
local UI = Venyx.new("Natural Disaster Survival")
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

local Natral = UI:addPage("Natural Disaster")
local disaster = Natral:addSection("Game Scripts(Anti Beta")

local FePage = UI:addPage("FE Scripts")
local FE = FePage:addSection("Scripts(good Exploit Reqiured) sometimes synapse x")

local theme = UI:addPage("Settings")
local Confic = theme:addSection("Config")
local Colors = theme:addSection("Colors")


localplayer:addSlider("Player Speed", 16, 16, 300, function(value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value walkspeed = value end)

localplayer:addSlider("Player jumpPower", jumpPower, jumpPower, 300, function(value) game.Players.LocalPlayer.Character.Humanoid.JumpPower = value jumpPower = value end)

MainGame:addSlider("Gravity", 196.2, 0, 196.2, function(value) workspace.Gravity = value end)

AD:addButton("save location", function() col = workspace[game.Players.LocalPlayer.Name].HumanoidRootPart.Position end)

AD:addButton("Load location", function() workspace[game.Players.LocalPlayer.Name]:MoveTo(col) end)

AD:addButton("Clear Platforms", function() clearplatforms() end)

AD:addToggle("noclip", false, function(value) noclip = value end)

AD:addToggle("Inf jump", Infjump ,function(value) Infjump = value end)

AD:addToggle("cntrl click teleport", clickon, function(value) clickon = value end)

AD:addToggle("alt click delete", deleteon, function(value) deleteon = value end)

AD:addToggle("spawn platform", platform, function(value) platform = value end)

AD:addToggle("Anti AFK", AntiAFK, function(value) AntiAFK = value end)

AD:addToggle("Hide UI", HideUIs, function(value) AntiAFK = value end)

AD:addToggle("Unlock Zomm Distance", unlockzoom, function(value) if value == false then game.Players.LocalPlayer.CameraMaxZoomDistance = 128 end unlockzoom = value end)

AD:addKeybind("Hide UI", nil, function() toggleUI(HideUItoggle) HideUItoggle = not HideUItoggle end)

Splayer:addTextbox("Player", Size, function(text) FindPlayer(text) end)

Splayer:addButton("teleport to player", function() game.Players.LocalPlayer.character:MoveTo(workspace[Selectedplayer.Name].HumanoidRootPart.Position) end)

Splayer:addButton("Kill Player", function() KillPlayer() end)

Splayer:addButton("Bring Player", function() BringPlayer() end)

Splayer:addButton("Give Player Tool", function() GiveTool() end)

disaster:addToggle("MapVote", Vote, function(value) Vote = value end)

disaster:addToggle("No Fall Damage", Fall, function(value) Fall = value if value == false then UI:Notify("Reset This To Apply") end end)

disaster:addToggle("Awalys Win", AwalysWin, function(value) AwalysWin = value end)

disaster:addToggle("Anti Acid Disaster", AntiAcid, function(value) AntiAcid = value end)

disaster:addToggle("Anti Vius Disaster", AntiVius, function(value) AntiVius = value end)

disaster:addToggle("Anti Tsunami Disaster", AntiTsunami, function(value) AntiTsunami = value end)

disaster:addToggle("No Disaster Screen Thing", NoScreen, function(value) NoScreen = value end)

disaster:addToggle("No Disaster Could", NoCloud, function(value) NoCloud = value end)

disaster:addToggle("Anti All(Fall, disasters, ect INVISABLE)", AntiAlll, function(value) AntiAlll = value AntiAll(value) end)

FE:addButton("Grow(body Scale:All 100% except BodyProportionScale: 0%) ONLY ARTHO", function() Grow() end)

FE:addDropdown("Accessory(for FE Scripts", Accessorys, nil, function(value) _G.Bloxain1 = value end)

FE:addButton("FE Demon Script(chose a good accessory", function() loadstring(game:HttpGet("https://drive.google.com/uc?export=download&id=1n2LZELzJb7NsGO17eLKCXSu5-cHrIg0u"))() end)

Confic:addTextbox("Platform size", "", function(value) Size = value end)

Confic:addTextbox("Hitbox size", "20", function(value) HeadSize = tonumber(value) end)

Confic:addToggle("Use Display Names", UseDisplayNames, function(value) UseDisplayNames = value end)

Confic:addKeybind("spawn platform key", Enum.KeyCode.Q, function() Spawnplatform()() end)

Confic:addButton("Save", function() SaveData() end)

for theme, color in pairs(Themes) do
	Colors:addColorPicker(theme, color, function(color3) UI:setTheme(theme, color3) end) -- // Adding a color picker for each type of theme customisable
end

Colors:addKeybind("Toggle UI Keybind", Enum.KeyCode.F3, function() UI:toggle() end)

Colors:addButton("Kill GUI", function() game.CoreGui["Natural Disaster Survival"]:Destroy() script:Destroy()end)

--             functions
---------------------------------------''
game.Players.LocalPlayer.PlayerGui.MainGui.SurviversPage.Changed:Connect(function()
	if Vote then
		if game.Players.LocalPlayer.PlayerGui.MainGui.SurviversPage.Visible then
			game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = true
		end
	end
end)

function AntiAll(Toggle)
	if Toggle then
		if FakeCharacter then
			FakeCharacter:Destroy()
		end
		game.Players.LocalPlayer.Character.Archivable = true
		RealCharacter = game.Players.LocalPlayer.Character
		FakeCharacter = game.Players.LocalPlayer.Character:Clone()
		FakeCharacter.Parent = workspace
		game.Players.LocalPlayer.Character = FakeCharacter
		workspace.Camera.CameraSubject = FakeCharacter.Humanoid
		return
	end
	game.Players.LocalPlayer.Character = RealCharacter
	workspace.Camera.CameraSubject = RealCharacter.Humanoid
end
workspace.Structure.DescendantAdded:Connect(function(part)
	if AntiAcid then
		if part.Name == "AcidRain" then
			part:Destroy()
		end
	end
	if AntiVius then
		if part.Name == "Virus" then
			part:Destroy()
		end
	end
	if AntiTsunami then
		if part.Name == "TsunamiWave" then
			part:Destroy()
		end
	end
end)

function Grow()
	local LocalPlayer = game.Players.LocalPlayer
	local Character = LocalPlayer.Character
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	function rm()
		for i,v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") then
				if v.Name == "Handle" or v.Name == "Head" then
					if Character.Head:FindFirstChild("OriginalSize") then
						Character.Head.OriginalSize:Destroy()
					end
				else
					for i,cav in pairs(v:GetDescendants()) do
						if cav:IsA("Attachment") then
							if cav:FindFirstChild("OriginalPosition") then
								cav.OriginalPosition:Destroy()  
							end
						end
					end
					v:FindFirstChild("OriginalSize"):Destroy()
					if v:FindFirstChild("AvatarPartScaleType") then
						v:FindFirstChild("AvatarPartScaleType"):Destroy()
					end
				end
			end
		end
	end

	rm()
	wait(0.5)
	Humanoid:FindFirstChild("BodyProportionScale"):Destroy()
	wait(1)

	rm()
	wait(0.5)
	Humanoid:FindFirstChild("BodyHeightScale"):Destroy()
	wait(1)

	rm()
	wait(0.5)
	Humanoid:FindFirstChild("BodyWidthScale"):Destroy()
	wait(1)

	rm()
	wait(0.5)
	Humanoid:FindFirstChild("BodyDepthScale"):Destroy()
	wait(1)

	rm()
	wait(0.5)
	Humanoid:FindFirstChild("HeadScale"):Destroy()
	wait(1)
end

function clearplatforms()
	for i, v in pairs(workspace:GetChildren()) do
		if v.Name == "falksjdhflkjasdhflkjasdhflkjasdfhj" then
			v:Destroy()
		end
	end
end

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

	if show then
		for i = 1, #hideUIData do
			table.remove(hideUIData, 1)
		end
	end

	for i, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do		
		if v:IsA("ScreenGui") and show then
			if v.Enabled then
				table.insert(hideUIData, 1, v.Name)
			end
		end
	end
	game.CoreGui.ThemeProvider.Enabled = show
end

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

-----------------------------------EVENTS----------------------------------------------------------------------------------------------------

Mouse.Button1Down:connect(function()
	if deleteon == true then
		if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
		if not Mouse.Target then return end
		Mouse.Target:Destroy()
	end 
end)

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

UIS.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
		firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, Mouse.Hit, 1)
		wait(0.1)
		firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, Mouse.Hit, 0)
	end
end)

-----------------------------------Run service----------------------------------------------------------------------------------------------------

game:GetService('RunService').Stepped:connect(function()
	tick()
	if noclip then
		if game:GetService("Players").LocalPlayer.Character ~= nil then
			for _, child in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true then
					child.CanCollide = false
				end
			end
		end
	end
	
	if NoScreen then
		if game.Players.LocalPlayer.PlayerGui:FindFirstChild("BlizzardGui") then
			game.Players.LocalPlayer.PlayerGui.BlizzardGui:Destroy()
		end
		if game.Players.LocalPlayer.PlayerGui:FindFirstChild("SandStormGui") then
			game.Players.LocalPlayer.PlayerGui.SandStormGui:Destroy()
		end
	end
	
	if NoCloud then
		if workspace.Structure:FindFirstChild("Cloud") then
			workspace.Structure.Cloud.Transparency = 1
		end
	end
	
	if AntiAlll then
		RealCharacter:MoveTo(workspace.Tower.Steps.StepPart.Position)
	end
	
	if AwalysWin then
		game.Players.LocalPlayer.Character:MoveTo(workspace.Tower.Steps.StepPart.Position)
	end
	
	if unlockzoom then
		game.Players.LocalPlayer.CameraMaxZoomDistance = 99999
	end

	if jumpPower ~= 50 or jumpPower ~= 7 then
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = jumpPower
	end

	if walkspeed ~= 16 then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkspeed
	end

	if Fall then
		if game.Players.LocalPlayer.Character:FindFirstChild("FallDamageScript") then
			game.Players.LocalPlayer.Character.FallDamageScript:Destroy()
		end
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
	local CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	local Target = Selectedplayer
	for i,x in pairs(game.Players:GetPlayers()) do
		if x.Name == Target then
			game:GetService("Players").LocalPlayer.Character.Humanoid:UnequipTools()
			local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid:Clone()
			Humanoid.BreakJointsOnDeath = false
			game.Players.LocalPlayer.Character.Animate.Disabled = true
			game:GetService("Players").LocalPlayer.Character.Humanoid:Destroy()
			Humanoid.Parent = game:GetService("Players").LocalPlayer.Character
			for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
				if v:IsA("Tool") then
					game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool"))
					firetouchinterest(v.Handle,x.Character.HumanoidRootPart,0)
				end
			end
		end
	end
	game.Players.LocalPlayer.CharacterAdded:Wait():WaitForChild("Humanoid")
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame
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
