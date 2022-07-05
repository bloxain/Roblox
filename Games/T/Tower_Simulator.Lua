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
local shiftlock = false
local unlockzoom = false
local walkspeed = 16
local jumpPower = 50
local autobuild = false
local autoTouch = false
local HideUItoggle = false
local hideUIData = {}

-----------------------------------IMPORTENT FUNCS------------------------------------------------------------------------------------------

function LoadData()
	if not isfile("Bloxhub#7364/Saves/Tower.lua") then
		return
	else
		local data = game:GetService("HttpService"):JSONDecode(readfile("Bloxhub#7364/Saves/Tower.lua"))
		Size = data.PSize
		UseDisplayNames = data.usedisplayNames
		AntiAFK = data.anti_afk
		deleteon = data.deleteon
		platform = data.platform
		autobuild = data.autobuild
		unlockzoom = data.unlockzoom
		clickon = data.clickon
		Infjump = data.Infjump
		autoTouch = data.autoTouch
	end
end

LoadData()


function SaveData()
	local datatosave = {
		["PSize"] = Size;
		["usedisplayNames"] = UseDisplayNames;
		["anti_afk"] = AntiAFK;
		["clickon"] = clickon;
		["deleteon"] = deleteon;
		["autobuild"] = autobuild;
		["unlockzoom"] = unlockzoom;
		["Infjump"] = Infjump;
		["autoTouch"] = autoTouch
	}
	writefile("Bloxhub#7364/Saves/Tower.lua", game:GetService("HttpService"):JSONEncode(datatosave))
end

-----------------------------------EXTRA----------------------------------------------------------------------------------------------------

if game.Players.LocalPlayer.Character.Humanoid.UseJumpPower == false then
	jumpPower = 7
end

function DissableAntiCheat()
	local thingtodestory = "Ill"
	for i,v in pairs(game.Players.LocalPlayer.PlayerScripts:GetChildren()) do 
		if v.Name:lower():sub(1,#thingtodestory) == thingtodestory:lower() then
			Selectedplayer = v
		end
	end
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

	if shiftlock then
		game.Players.LocalPlayer.DevEnableMouseLock = true
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

	if autobuild then
		fireclickdetector(game.Players.LocalPlayer.MyTower.Value.ClickDetector)
	end

	if autoTouch then
		firetouchinterest(game.Players.LocalPlayer.MyTower.Value.PurchaseUpgradeButtonRight.Head, game.Players.LocalPlayer.Character.LeftFoot, 1)
		firetouchinterest(game.Players.LocalPlayer.MyTower.Value.PurchaseUpgradeButtonLeft.Head, game.Players.LocalPlayer.Character.LeftFoot, 1)
		firetouchinterest(game.Players.LocalPlayer.MyTower.Value.PurchaseUpgradeButtonRight.Head, game.Players.LocalPlayer.Character.LeftFoot, 0)
		firetouchinterest(game.Players.LocalPlayer.MyTower.Value.PurchaseUpgradeButtonLeft.Head, game.Players.LocalPlayer.Character.LeftFoot, 0)
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
local Venyx = loadstring(readfile("Bloxhub#7364/Venyx_UI.Lua"))()
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
local server = UI:addPage("Server")
local Splayer = server:addSection("Players")
local TS = UI:addPage("Tower Simulator")
local TSM = TS:addSection("Main")
local theme = UI:addPage("Settings")
local MainGame = main:addSection("Game")
local localplayer = main:addSection("localplayer")
local Confic = theme:addSection("Config")
local Colors = theme:addSection("Colors")
local CreditPage = UI:addPage("FeedBack")
local CreditAD = CreditPage:addSection("Credits: Bloxain -- Code, GreenDyno -- UI Synapse Reqired to Send")




localplayer:addSlider("Player Speed", 16, 16, 300, function(value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value walkspeed = value end)

localplayer:addSlider("Player jumpPower", jumpPower, jumpPower, 300, function(value) game.Players.LocalPlayer.Character.Humanoid.JumpPower = value jumpPower = value end)

AD:addButton("save location", function() col = workspace[game.Players.LocalPlayer.Name].HumanoidRootPart.Position end)

AD:addButton("Load location", function() workspace[game.Players.LocalPlayer.Name]:MoveTo(col) end)

AD:addButton("Clear Platforms", function() clearplatforms() end)

AD:addToggle("noclip", false, function(value) noclip = value end)

AD:addToggle("Inf jump", Infjump ,function(value) Infjump = value end)

AD:addToggle("cntrl click teleport", clickon, function(value) clickon = value end)

AD:addToggle("alt click delete", deleteon, function(value) deleteon = value end)

AD:addToggle("spawn platform", platform, function(value) platform = value end)

AD:addToggle("awalys enable shiftlock", false, function(value) shiftlock = value end)

AD:addToggle("Anti AFK", AntiAFK, function(value) AntiAFK = value end)

AD:addKeybind("Hide UI", nil, function() toggleUI(HideUItoggle) HideUItoggle = not HideUItoggle end)

AD:addToggle("Unlock Zomm Distance", unlockzoom, function(value) if value == false then game.Players.LocalPlayer.CameraMaxZoomDistance = 128 end unlockzoom = value end)

Splayer:addTextbox("Player", Size, function(text) FindPlayer(text) end)

Splayer:addButton("teleport to player", function() game.Players.LocalPlayer.character:MoveTo(workspace[Selectedplayer.Name].HumanoidRootPart.Position) end)

TSM:addToggle("Auto Build", autobuild, function(value) autobuild = value end)

TSM:addToggle("Auto Touch", autoTouch, function(value) autoTouch = value end)

TSM:addButton("Teleport to rebirth place", function() game.Players.LocalPlayer.Character:MoveTo(workspace.System.RebirthPlatform.TowerLogo.Logo.Position) end)

TSM:addButton("Teleport to Tower", function() game.Players.LocalPlayer.Character:MoveTo(game.Players.LocalPlayer.MyTower.Value.Base.Base.Position) end)

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

Colors:addButton("Kill GUI", function() game.CoreGui["Tower Simulator GUI"]:Destroy() script:Destroy()end)

CreditAD:addTextbox("FeedBack/suggestions and why to change it", "", function(value) FeedBack = value end)

CreditAD:addButton("Send FeedBack", function() SendDiscord("GUI: Tower Simulator".."\n GameId: "..game.GameId.."\n PlaceId: "..game.PlaceId.."\n JobId: "..game.JobId.."\n link: https://www.roblox.com/games/"..game.PlaceId.."\n FeedBack: \n\n"..FeedBack, syn.crypt.base64.decode("aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvOTkzMDA5MzE0MzA0MzY4NzEwL3FzcHJxUlJDQ3QwX3k1UGNBQjFsbFpDc2hUMUY3UFg5NUxJNTN2U2EwUkgydy1uVWtZOTB2QndKY2pHQmdyUnBaNnBW")) UI:Notify("Sent!", "I will hopefully look and consider this later") end)

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
