local col = nil
local Selectedplayer = nil
local noclip = false
local touchon = false
local clickon = false
local AntiAFK = false
local Infjump = false
local touchon = false
local platform = false
local platform = false
local deleteon = false
local shiftlock = false
local unlockzoom = false
local HideUItoggle = false
local HideUItoggle = false
local hitboxenabled = false
local UseDisplayNames = false
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local UIS = game:GetService("UserInputService")
local Size = 6
local HeadSize = 20
local walkspeed = 16
local jumpPower = 50
local SavedFog = 100000
local Libary = loadstring(readfile("Bloxhub#7364/Modules/Main.Lua"))()
local hideUIData = {}
local Accessorys = {}
local keys = {"F4", "Q", "F3"}
local Themes = {
	["Background"] = Color3.fromRGB(24, 24, 24),
	["Glow"] = Color3.fromRGB(0, 0, 0),
	["Accent"] = Color3.fromRGB(10, 10, 10),
	["LightContrast"] = Color3.fromRGB(43, 43, 43),
	["DarkContrast"] = Color3.fromRGB(14, 14, 14),  
	["TextColor"] = Color3.fromRGB(255, 255, 255)
}

function LoadData()
	if not isfile("Bloxhub#7364/Saves/Universal_Gui.lua") then
		return
	else
		local data = game:GetService("HttpService"):JSONDecode(readfile("Bloxhub#7364/Saves/Universal_Gui.lua"))
		if data.Themes == nil then
			return
		end
		Size = data.Size
		UseDisplayNames = data.UseDisplayNames
		AntiAFK = data.AntiAFK
		deleteon = data.deleteon
		clickon = data.clickon
		touchon = data.touchon
		platform = data.platform
		shiftlock = data.shiftlock
		unlockzoom = data.unlockzoom
		noclip = data.noclip
		Infjump = data.Infjump
		keys = data.keys
		
		local temp = {}
		for theme, color in pairs(data.Themes) do
			temp[theme] = Color3.new(color[1], color[2], color[3])
		end
		Themes = temp
	end
end
LoadData()

for i, v in pairs(Libary.GetChar():GetChildren()) do
	if v:IsA("Accessory") then
		table.insert(Accessorys, 1, v.Name)
	end
end

if Libary.GetChar().Humanoid.UseJumpPower == false then
	jumpPower = 7
end

UserInput = game:GetService("UserInputService")


local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()



local Venyx = loadstring(game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Venyx_UI.Lua"))()
local UI = Venyx.new("universal Gui")



local main = UI:addPage("Main")
local AD = main:addSection("additional features")
local MainGame = main:addSection("Game")
local localplayer = main:addSection("localplayer")

local GamePage = UI:addPage("Game")
local Splayer = GamePage:addSection("Players")
local GameAd = GamePage:addSection("Game")

local FePage = UI:addPage("FE Scripts")
local FE = FePage:addSection("Scripts(good Exploit Reqiured) sometimes synapse x")

local theme = UI:addPage("Settings")
local Confic = theme:addSection("Config")
local Colors = theme:addSection("Colors")



AD:addButton("save location", function() col = Libary.GetChar().HumanoidRootPart.Position end)

AD:addButton("Load location", function() Libary.TpPlayer(col) end)

AD:addButton("Clear Platforms", function() clearplatforms() end)

AD:addButton("Reset Camera", function() Fixcamera() end)

AD:addToggle("noclip", noclip, function(value) noclip = value end)

AD:addToggle("Inf jump", Infjump,function(value) Infjump = value end)

AD:addToggle("cntrl click teleport", clickon, function(value) clickon = value end)

AD:addToggle("alt click delete", deleteon, function(value) deleteon = value end)

AD:addToggle("cntrl right click touch(touches a part)", touchon, function(value) touchon = value end)

AD:addToggle("spawn platform", platform, function(value) platform = value end)

AD:addToggle("awalys enable shiftlock", shiftlock, function(value) shiftlock = value end)

AD:addToggle("Anti AFK", AntiAFK, function(value) AntiAFK = value end)

AD:addToggle("Unlock Zomm Distance", unlockzoom, function(value) if value == false then game.Players.LocalPlayer.CameraMaxZoomDistance = 128 end unlockzoom = value end)

AD:addKeybind("Hide UI", Enum.KeyCode[keys[1]], function() toggleUI(HideUItoggle) HideUItoggle = not HideUItoggle end, function(key) keys[1] = key.KeyCode.Name end)

localplayer:addSlider("Player Speed", 16, 16, 300)

localplayer:addSlider("Player jumpPower", jumpPower, jumpPower, 300, function(value) Libary.GetChar().Humanoid.JumpPower = value jumpPower = value end)


Splayer:addTextbox("Player", Size, function(text) FindPlayer(text) end)

Splayer:addButton("teleport to player", function() Libary.TpPlayer(workspace[Selectedplayer.Name].HumanoidRootPart.Position) end)

Splayer:addToggle("Hitbox expander", hitboxenabled, function(value) hitboxenabled = value if value == false then for i,v in next, game:GetService('Players'):GetPlayers() do if v ~= Player then v.Character.HumanoidRootPart.Size = Vector3.new(2,1,2)v.Character.HumanoidRootPart.Transparency = 1	v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really white")	v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end end end end)


GameAd:addSlider("Fps Cap", 60, 30, 1000, function(value) setfpscap(value) end)

GameAd:addSlider("Gravity", 196.2, 0, 196.2, function(value) workspace.Gravity = value end)

GameAd:addToggle("Remove Fog", false, function(value) if value == true then game.Lighting.FogEnd = math.huge SavedFog = game.Lighting.FogEnd return end game.Lighting.FogEnd = SavedFog end)

GameAd:addButton("PERMATE remove texutres", function() RemoveTexures() end)


FE:addButton("Grow(body Scale:All 100% except BodyProportionScale: 0%) ONLY ARTHO", function() Grow() end)

FE:addDropdown("Accessory(for FE Scripts", Accessorys, nil, function(value) _G.Bloxain1 = value end)

FE:addButton("FE Demon Script(chose a good accessory", function() loadstring(game:HttpGet("https://drive.google.com/uc?export=download&id=1n2LZELzJb7NsGO17eLKCXSu5-cHrIg0u"))() end)

Confic:addTextbox("Platform size", "", function(value) Size = value end)


Confic:addTextbox("Hitbox size", "20", function(value) HeadSize = tonumber(value) end)

Confic:addToggle("Use Display Names", UseDisplayNames, function(value) UseDisplayNames = value end)

Confic:addKeybind("spawn platform key", Enum.KeyCode[keys[2]], function() Spawnplatform() end, function(key) keys[2] = key.KeyCode.Name end)

Confic:addButton("Save", function() SaveData() end)

for theme, color in pairs(Themes) do
	Colors:addColorPicker(theme, color, function(colorr3) UI:setTheme(theme, colorr3) Themes[theme] = colorr3 end) -- // Adding a color picker for each type of theme customisable
end

Colors:addKeybind("Toggle UI Keybind", Enum.KeyCode[keys[3]], function() UI:toggle() end, function(key) keys[3] = key.KeyCode.Name end)

Colors:addButton("Kill GUI", function() game.CoreGui["universal Gui"]:Destroy() script:Destroy() end)

for theme, color in pairs(Themes) do
	UI:setTheme(theme, color)
end

UI:SelectPage(main, true)

--             functions
---------------------------------------''

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

function Fixcamera()
	for i, v in pairs(workspace:GetChildren()) do
		if v:IsA("Camera") then
			v.HeadScale = 1
			v.CameraSubject = Libary.GetChar().Humanoid
			v.CameraType = Enum.CameraType.Custom
			v.DiagonalFieldOfView = 143.882
			v.FieldOfView = 70
			v.FieldOfViewMode = Enum.FieldOfViewMode.Vertical
			v.MaxAxisFieldOfView = 116.156
			game.Players.LocalPlayer.CameraMaxZoomDistance = 128
			game.Players.LocalPlayer.CameraMinZoomDistance = 0.5
			game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
			game.Players.LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
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
		if Libary.GetChar():FindFirstChild("Left Leg") then
			local Clone = Instance.new("Part")
			Clone.Parent = workspace
			Clone.Anchored = true
			Clone.Position = Libary.GetChar()["Left Leg"].Position
			Clone.Size = Vector3.new(Size, 1, Size)
			Clone.Name = "falksjdhflkjasdhflkjasdhflkjasdfhj"
		else
			local Clone = Instance.new("Part")
			Clone.Parent = workspace
			Clone.Anchored = true
			Clone.Position = Libary.GetChar()["LeftFoot"].Position
			Clone.Size = Vector3.new(Size, 1, Size)
			Clone.Name = "falksjdhflkjasdhflkjasdhflkjasdfhj"
		end
	end
end

function RemoveTexures()
	for i, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("WedgePart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = Enum.Material.SmoothPlastic
		end
	end
	
	workspace.DescendantAdded:Connect(function(v)
		if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("WedgePart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = Enum.Material.SmoothPlastic
		end
	end)
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
		Libary.TpPlayer(Mouse.Hit.p)
	end
end)

UIS.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
		firetouchinterest(Libary.GetChar().HumanoidRootPart, Mouse.Hit, 1)
		wait(0.1)
		firetouchinterest(Libary.GetChar().HumanoidRootPart, Mouse.Hit, 0)
	end
end)

-----------------------------------Run service----------------------------------------------------------------------------------------------------
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

game:GetService('RunService').Stepped:connect(function()

	if noclip then
		if Libary.GetChar() ~= nil then
			for _, child in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true then
					child.CanCollide = false
				end
			end
		end
	end

	if shiftlock then
		game.Players.LocalPlayer.DevEnableMouseLock = true
	end

	if unlockzoom then
		game.Players.LocalPlayer.CameraMaxZoomDistance = 99999
	end

	if jumpPower ~= 50 or jumpPower ~= 7 then
		Libary.GetChar().Humanoid.JumpPower = jumpPower
	end

	if walkspeed ~= 16 then
		Libary.GetChar().Humanoid.WalkSpeed = walkspeed
	end

	if shiftlock == true then
		game.Players.LocalPlayer.DevEnableMouseLock = true
	end

	if UserInput:IsKeyDown(Enum.KeyCode.Space) then
		if Infjump == true then
			if game.Players.LocalPlayer.Character:FindFirstChild("Left Leg") then
				local Clone = Instance.new("Part")
				Clone.Parent = workspace
				Clone.Anchored = true
				Clone.Position = Libary.GetChar()["Left Leg"].Position
				Clone.Size = Vector3.new(6, 1, 6)
				Clone.Name = "falksjdhflkjasdhflkjasdhflkjasdfhjsfdgsd"
				Clone.Transparency = 1
				wait()
				Clone:Destroy()
			else
				local Clone = Instance.new("Part")
				Clone.Parent = workspace
				Clone.Anchored = true
				Clone.Position = Libary.GetChar()["LeftFoot"].Position
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
				if Libary.GetChar():FindFirstChild("Left Leg") then
					local Clone = Instance.new("Part")
					Clone.Parent = workspace
					Clone.Anchored = true
					Clone.Position = Libary.GetChar()["Left Leg"].Position
					Clone.Size = Vector3.new(6, 1, 6)
					Clone.Name = "falksjdhflkjasdhflkjasdhflkjasdfhjsfdgsd"
					Clone.Transparency = 1
					wait(0.1)
					Clone:Destroy()
				else
					local Clone = Instance.new("Part")
					Clone.Parent = workspace
					Clone.Anchored = true
					Clone.Position = Libary.GetChar()["LeftFoot"].Position
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

function SaveData(profile)
	local temp = {}
	for theme, color in pairs(Themes) do
		temp[theme] = {color.R, color.G, color.B}
		print(color.R)
	end
	local datatosave = {
		["Size"] = Size,
		["UseDisplayNames"] = UseDisplayNames,
		["AntiAFK"] = AntiAFK,
		['Themes'] = temp,
		["deleteon"] = deleteon,
		["clickon"] = clickon,
		["touchon"] = touchon,
		["platform"] = platform,
		["shiftlock"] = shiftlock,
		["unlockzoom"] = unlockzoom,
		["noclip"] = noclip,
		["Infjump"] = Infjump,
		["keys"] = keys,
	}
	writefile("Bloxhub#7364/Saves/Universal_Gui.lua", game:GetService("HttpService"):JSONEncode(datatosave))
end
