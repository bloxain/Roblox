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
local AntiBunny = false
local AntiKill = false
local AntiFog = false
local Antiinv = false
local AntiNeg = false
local AntiINVall = true
local Hideplayers = false
local speedtower = false
local hideUIData = {}

local autofarm = {
	["Enabeld"] = false,
	["Speed"] = false,
	["First Time"] = true
}

-----------------------------------IMPORTENT FUNCS------------------------------------------------------------------------------------------
-----------------------------------EXTRA----------------------------------------------------------------------------------------------------
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

function LoadData()
	if not isfile("Bloxhub#7364/Saves/Tower_of_hell.lua") then
		return
	else
		local data = game:GetService("HttpService"):JSONDecode(readfile("Bloxhub#7364/Saves/Tower_of_hell.lua"))
		Size = data.PSize
		UseDisplayNames = data.usedisplayNames
		Hideplayers = data.Hideplayers
		AntiINVall = data.showAPlayers
		AntiKill = data.AntiKill
		AntiBunny = data.AntiBunny
		AntiAFK = data.AntiAFK
		AntiFog = data.AntiFog
		AntiNeg = data.AntiNeg
		Antiinv = data.Antiinv
		Infjump = data.Infjump
		clickon = data.clickon
		deleteon = data.deleteon
		platform = data.platform
		speedtower = data.speedtower
	end
end

LoadData()

function DissableINV(char, amount)
	if char == nil then
		return nil
	end

	for i, v in pairs(char:GetChildren()) do
		if v.Name ~= "HumanoidRootPart" then
			if v:IsA("Part") then
				if v.Name ~= "hitbox" and v.Name ~= "hitboxInvincible" then
					v.Transparency = amount
				end
			end

			if v:IsA("Accessory") then
				v.Handle.Transparency = amount
			end
		end
	end
	char.Head.face.Transparency = 0
end

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

function clearplatforms(name)
	for i, v in pairs(workspace:GetChildren()) do
		if v.Name == name then
			v:Destroy()
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

function Spawnplatform(Transparency, name, delete)
	if platform == true and UserInput:GetFocusedTextBox() == nil then
		if game.Players.LocalPlayer.Character:FindFirstChild("Left Leg") then
			local Clone = Instance.new("Part")
			Clone.Parent = workspace
			Clone.Anchored = true
			Clone.Position = game.Players.LocalPlayer.Character["Left Leg"].Position
			Clone.Size = Vector3.new(Size, 1, Size)
			Clone.Name = name
			Clone.Transparency = Transparency
			if delete then
				wait()
				Clone:Destroy()
			end
		else
			local Clone = Instance.new("Part")
			Clone.Parent = workspace
			Clone.Anchored = true
			Clone.Position = game.Players.LocalPlayer.Character["LeftFoot"].Position
			Clone.Size = Vector3.new(Size, 1, Size)
			Clone.Name = name
			Clone.Transparency = Transparency
			if delete then
				wait()
				Clone:Destroy()
			end
		end
	end
end
--Hold CLTR and click to delete parts (you need to rejoin if you delete something wrong)
local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()

function SaveData()
	local datatosave = {
		["PSize"] = Size;
		["usedisplayNames"] = UseDisplayNames;
		["Hideplayers"] = Hideplayers;
		["showAPlayers"] = AntiINVall;
		["AntiKill"] = AntiKill;
		["AntiBunny"] = AntiBunny;
		["AntiAFK"] = AntiAFK;
		["AntiFog"] = AntiFog;
		["AntiNeg"] = AntiNeg;
		["Antiinv"] = Antiinv;
		["Infjump"] = Infjump;
		["platform"] = platform;
		["clickon"] = clickon;
		["deleteon"] = deleteon;
		["speedtower"] = speedtower

	}
	writefile("Bloxhub#7364/Saves/Tower_of_hell.lua", game:GetService("HttpService"):JSONEncode(datatosave))
end

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

	if workspace:FindFirstChild(game.Players.LocalPlayer.Name) and game.Players.LocalPlayer.Character.Humanoid.Health ~= 0 then
		game.Players.LocalPlayer.Character.KillScript.Disabled = AntiKill
	end

	if PlayerSpeed ~= 16 then
		game:GetService("ReplicatedStorage").globalSpeed.Value = PlayerSpeed
	end

	if PlayerJump ~= 50 then
		workspace[game.Players.LocalPlayer.Name].Humanoid.JumpPower = PlayerJump
	end

	if AntiNeg then
		game:GetService("Lighting").Negative.Enabled = false
	end

	if workspace:FindFirstChild(game.Players.LocalPlayer.Name) then
		if Antiinv then
			if AntiINVall then
				for i, v in  pairs(game.Players:GetChildren()) do
					DissableINV(v.Character, 0)
					--	v.Character.invisible = false
				end
			else
				DissableINV(game.Players.LocalPlayer.Character, 0)				
			end
		end
	end

	if AntiFog then
		game.Lighting.FogEnd = 1200
	end

	if AntiBunny then
		game.Players.LocalPlayer.Character.bunnyJump.Disabled = true
	end

	if Hideplayers then
		for i, v in  pairs(game.Players:GetChildren()) do
			if v ~= game.Players.LocalPlayer then
				DissableINV(v.Character, 1)
				--v.Character.invisible = true
			end
		end
	end

	if autofarm.Enabeld then
		if game.Players.LocalPlayer.PlayerGui.timer.timeLeft.Text == "5:00" then
			if autofarm["First Time"] == false then
				if autofarm.Speed == true then
					local endzone = workspace.tower.sections.finish.FinishGlow.CFrame local player = game.Players.LocalPlayer.Character player.HumanoidRootPart.CFrame = endzone
					autofarm["First Time"] = true
				else
					local endzone = workspace.tower.sections.finish.exit.ParticleBrick.CFrame local player = game.Players.LocalPlayer.Character player.HumanoidRootPart.CFrame = endzone
					autofarm["First Time"] = true
				end
			end
		end

		if game.Players.LocalPlayer.PlayerGui.timer.timeLeft.Text == "0:01" or game.Players.LocalPlayer.PlayerGui.timer.timeLeft.Text == "0:02" or game.Players.LocalPlayer.PlayerGui.timer.timeLeft.Text == "0:03" or game.Players.LocalPlayer.PlayerGui.timer.timeLeft.Text == "0:04" or game.Players.LocalPlayer.PlayerGui.timer.timeLeft.Text == "0:05" then
			autofarm["First Time"] = false
		end
	end

	if UserInput:IsKeyDown(Enum.KeyCode.Space) and UserInput:GetFocusedTextBox() == nil then
		if Infjump == true then
			Spawnplatform(1, "ajheliuhdlfkjahgeiul", true)
		end
	end
end)

-- https://raw.githubusercontent.com/Stefanuk12/Venyx-UI-Library/main/source.lua
-- https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Reuploaded
-- // Initialising the UI
local Venyx = loadstring(readfile("Bloxhub#7364/Venyx_UI.Lua"))()
local UI = Venyx.new("Tower Of Hell GUI")
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

local TOHP = UI:addPage("TOH")
local TOHS = TOHP:addSection("TOH settings")

local AutoP = UI:addPage("atuo Farm")
local AutoS = AutoP:addSection("Settings(beta you will most likey get banned USE ALT)")

local theme = UI:addPage("Settings")
local TowerSettings = theme:addSection("Config")
local Confic = theme:addSection("Config")
local Colors = theme:addSection("Colors")

local CreditPage = UI:addPage("FeedBack")
local CreditAD = CreditPage:addSection("Credits: Bloxain -- Code, GreenDyno -- UI Synapse Reqired to Send")


localplayer:addSlider("Player Speed", 16, 16, 300, function(value) PlayerSpeed = value game:GetService("ReplicatedStorage").globalSpeed.Value = value end)

localplayer:addSlider("Player jumpPower", 50, 50, 300, function(value) PlayerJump = value workspace[game.Players.LocalPlayer.Name].Humanoid.JumpPower = value end)

MainGame:addSlider("Gravity", 196.2, 0, 196.2, function(value) workspace.Gravity = value end)

AD:addButton("save location", function() col = workspace[game.Players.LocalPlayer.Name].HumanoidRootPart.Position end)

AD:addButton("Load location", function() workspace[game.Players.LocalPlayer.Name]:MoveTo(col) end)

AD:addButton("Clear Platforms", function() clearplatforms("falksjdhflkjasdhflkjasdhflkjasdfhj") end)

AD:addButton("Load Dark Dex", function() game:HttpGet('https://raw.githubusercontent.com/SpeedSterKawaii/Dark-Dex/main/dex.lua', true) end)

AD:addToggle("noclip", false, function(value) noclip = value end)

AD:addToggle("Inf jump", Infjump,function(value) Infjump = value end)

AD:addToggle("cntrl click teleport", clickon, function(value) clickon = value end)

AD:addToggle("alt click delete", deleteon, function(value) deleteon = value end)

AD:addToggle("spawn platform", platform, function(value) platform = value end)

AD:addToggle("Anti AFK", AntiAFK, function(value) AntiAFK = value end)

AD:addToggle("Unlock Zoom Distance", false, function(value) if value == true then game.Players.LocalPlayer.CameraMaxZoomDistance = 99999 else game.Players.LocalPlayer.CameraMaxZoomDistance = 128 end end)

AD:addKeybind("Hide UI", nil, function() toggleUI(HideUItoggle) HideUItoggle = not HideUItoggle end)

Splayer:addTextbox("Player", "", function(text) FindPlayer(text) end)

Splayer:addButton("teleport to player", function() game.Players.LocalPlayer.character:MoveTo(workspace[Selectedplayer.Name].HumanoidRootPart.Position) end)

Splayer:addButton("Kill Player", function() KillPlayer() end)

Splayer:addButton("Bring Player", function() BringPlayer() end)

TOHS:addToggle("Anti bunny jump", AntiBunny, function(value) AntiBunny = value if value == false then if game.Players.LocalPlayer.PlayerGui.timer.mutators:FindFirstChild("bunny") then game.Players.LocalPlayer.Character.bunnyJump.Disabled = false end end end)

TOHS:addToggle("Anti Kill", AntiKill, function(value) AntiKill = value end)

TOHS:addToggle("Anti Fog", AntiFog, function(value) AntiFog = value if value == false then if game.Players.LocalPlayer.PlayerGui.timer.mutators:FindFirstChild("fog") then game.Lighting.FogEnd = 50 end end end)

TOHS:addToggle("Anti invisible", Antiinv, function(value) Antiinv = value if value == false then if game.Players.LocalPlayer.PlayerGui.timer.mutators:FindFirstChild("invisibility") then for i, v in  pairs(game.Players:GetChildren()) do DissableINV(v.Character, 1) end end end end)

TOHS:addToggle("Anti Negitive", AntiNeg, function(value) AntiNeg = value  if value == false then if game.Players.LocalPlayer.PlayerGui.timer.mutators:FindFirstChild("negative") then game.Lighting.Negative.Saturation = -2 end end  end)

TOHS:addButton("Insant win(WARNING may ban do later in round)", function() if speedtower == false then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.tower.sections.finish.exit.ParticleBrick.CFrame else game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.tower.sections.finish.FinishGlow.CFrame end end)

TOHS:addButton("Give All Tools(local and some dont work)", function() for i, v in pairs(game.ReplicatedStorage.Gear:GetChildren()) do local clone = v:Clone() clone.Parent = game.Players.LocalPlayer.Backpack end end)

TOHS:addKeybind("Time Freeze Key", Enum.KeyCode.E, function() game.Players.LocalPlayer.PlayerScripts.timefreeze.Value = not game.Players.LocalPlayer.PlayerScripts.timefreeze.Value end)

TowerSettings:addToggle("ShowPlayers(for anti inv)", AntiINVall, function(value) AntiINVall = value if value == false then 	for i, v in  pairs(game.Players:GetChildren()) do if v ~= game.Players.LocalPlayer then DissableINV(v.Character, 0) end end end end)

TowerSettings:addToggle("Hide Players", Hideplayers, function(value) Hideplayers = value if value == false then for i, v in  pairs(game.Players:GetChildren()) do if v ~= game.Players.LocalPlayer then DissableINV(v.Character, 0) end end end end)

AutoS:addToggle("Speed tower", false, function(value) autofarm.Speed = value end)

AutoS:addToggle("Enabled", false, function(value) autofarm.Enabeld = value autofarm["First Time"] = true if value == true then UI:Notify("Enabeld!", "Autofarm will start next round.") end end)

Confic:addTextbox("Platform size", Size, function(value) Size = value end)

Confic:addToggle("Use Display Names", UseDisplayNames, function(value) UseDisplayNames = value end)

Confic:addToggle("Speed Tower(for instant win)", speedtower, function(value) speedtower = value end)

Confic:addKeybind("Noclip key", nil, function() noclip = not noclip end)

Confic:addKeybind("spawn platform key", Enum.KeyCode.Q, function() Spawnplatform(0, "falksjdhflkjasdhflkjasdhflkjasdfhj") end)

Confic:addButton("Save", function() SaveData() end)

for theme, color in pairs(Themes) do
	Colors:addColorPicker(theme, color, function(color3) UI:setTheme(theme, color3) end) -- // Adding a color picker for each type of theme customisable
end

Colors:addKeybind("Toggle UI Keybind", Enum.KeyCode.F3, function() UI:toggle() end)

Colors:addButton("Kill GUI", function() game.CoreGui["Tower Of Hell GUI"]:Destroy() script:Destroy()end)

CreditAD:addTextbox("FeedBack/suggestions and why to change it", "", function(value) FeedBack = value end)

CreditAD:addButton("Send FeedBack", function() SendDiscord("GUI: Tower of Hell".."\n GameId: "..game.GameId.."\n PlaceId: "..game.PlaceId.."\n JobId: "..game.JobId.."\n link: https://www.roblox.com/games/"..game.PlaceId.."\n FeedBack: \n\n"..FeedBack, syn.crypt.base64.decode("aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvOTkzMDA5MzE0MzA0MzY4NzEwL3FzcHJxUlJDQ3QwX3k1UGNBQjFsbFpDc2hUMUY3UFg5NUxJNTN2U2EwUkgydy1uVWtZOTB2QndKY2pHQmdyUnBaNnBW")) UI:Notify("Sent!", "I will hopefully look and consider this later") end)

CreditAD:addTextbox("Add Script: Paste script to add to bloxain", "", function(value) AddGame = value end)

CreditAD:addButton("Send Script", function() SendDiscord("GameId: "..game.GameId.."\n link: https://www.roblox.com/games/"..game.PlaceId.."\n Script: "..AddGame, syn.crypt.base64.decode("aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvOTkyOTkwNTE5NzgzMzI5ODIyL2xuSkhfbkEzak5Ud3BuLVdKZ3VtM3d5d2ZEX0F4bW5ReFpIa2p2OW53eUpSWjBSWlhNaHF6Q2ZlQmVMTFJsbGRpU1dO")) UI:Notify("Sent!", "This is checked then(Hopefully) added to bloxain in the next update") end)

CreditAD:addButton("Copy Discord", function() setclipboard("https://discord.gg/Vr2jNFpK") UI:Notify("Copyed!", "you can paste the link in your browser") end)

CreditAD:addButton("Copy YouTube", function() setclipboard("https://www.youtube.com/channel/UC8gfw9LhBjGurH7RL5e46RQ") UI:Notify("Copyed!", "you can paste the link in your browser") end)

UI:SelectPage(main, true)

--             functions
---------------------------------------

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
