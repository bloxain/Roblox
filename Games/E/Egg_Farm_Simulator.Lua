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
local shiftlock = false
local unlockzoom = false
local walkspeed = 16
local jumpPower = 50
local HideUItoggle = false
local autofarm = false
local automeat = false
local AutoLevel = false
local AutoTrain = false
local AutoAchive = false
local AutoBuyHeros = false
local AutoDaimonds = false
local Time = os.time()
local wait1 = 0
local hideUIData = {}
local Accessorys = {}
local Libary = loadstring(readfile("Bloxhub#7364/Modules/Main.Lua"))()
local DataHandler = require(game.ReplicatedStorage.Modules.DataHandler);
function LoadData()
	if not isfile("Bloxhub#7364/Saves/EggFarm.Lua") then
		return
	else
		local data = game:GetService("HttpService"):JSONDecode(readfile("Bloxhub#7364/Saves/EggFarm.Lua"))
		Size = data.Size
		UseDisplayNames = data.UseDisplayNames
		AntiAFK = data.AntiAFK
		clickon = clickon
		deleteon = data.deleteon
		platform = data.platform
		noclip = data.noclip
		Infjump = data.Infjump
		shiftlock = data.shiftlock
		unlockzoom = unlockzoom
	end
end

function SaveData()
	local datatosave = {
		["Size"] = Size,
		["UseDisplayNames"] = UseDisplayNames,
		["AntiAFK"] = AntiAFK,
		["clickon"] = clickon,
		["deleteon"] = deleteon,
		["platform"] = platform,
		["noclip"] = noclip,
		["Infjump"] = Infjump,
		["unlockzoom"] = unlockzoom,
		["shiftlock"] = shiftlock
		
	}
	writefile("Bloxhub#7364/Saves/EggFarm.Lua", game:GetService("HttpService"):JSONEncode(datatosave))
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



local Venyx = loadstring(readfile("Bloxhub#7364/Venyx_UI.Lua"))()
local UI = Venyx.new("Egg Farm Simulator Gui")
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

local EggPage = UI:addPage("Egg Farm")
local EggFarm = EggPage:addSection("AutoFarm + more")

local server = UI:addPage("Server")
local Splayer = server:addSection("Players")

local FePage = UI:addPage("FE Scripts")
local FE = FePage:addSection("Scripts(good Exploit Reqiured) sometimes synapse x")

local theme = UI:addPage("Settings")
local Confic = theme:addSection("Config")
local Colors = theme:addSection("Colors")

local CreditPage = UI:addPage("FeedBack")
local CreditAD = CreditPage:addSection("Credits: Bloxain -- Code, GreenDyno -- UI Synapse Reqired to Send")



localplayer:addSlider("Player Speed", 16, 16, 300, function(value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value walkspeed = value end)

localplayer:addSlider("Player jumpPower", jumpPower, jumpPower, 300, function(value) game.Players.LocalPlayer.Character.Humanoid.JumpPower = value jumpPower = value end)

MainGame:addSlider("Gravity", 196.2, 0, 196.2, function(value) workspace.Gravity = value end)

AD:addButton("save location", function() col = workspace[game.Players.LocalPlayer.Name].HumanoidRootPart.Position end)

AD:addButton("Load location", function() workspace[game.Players.LocalPlayer.Name]:MoveTo(col) end)

AD:addButton("Clear Platforms", function() clearplatforms() end)

AD:addToggle("noclip", noclip, function(value) noclip = value end)

AD:addToggle("Inf jump", Infjump,function(value) Infjump = value end)

AD:addToggle("cntrl click teleport", clickon, function(value) clickon = value end)

AD:addToggle("alt click delete", deleteon, function(value) deleteon = value end)

AD:addToggle("spawn platform", platform, function(value) platform = value end)

AD:addToggle("awalys enable shiftlock", shiftlock, function(value) shiftlock = value end)

AD:addToggle("Anti AFK", AntiAFK, function(value) AntiAFK = value end)

AD:addToggle("Hide UI", HideUIs, function(value) AntiAFK = value end)

AD:addToggle("Unlock Zomm Distance", false, function(value) if value == false then game.Players.LocalPlayer.CameraMaxZoomDistance = 128 end unlockzoom = value end)

AD:addKeybind("Hide UI", nil, function() toggleUI(HideUItoggle) HideUItoggle = not HideUItoggle end)

EggFarm:addButton("Find Empty Farm", function() for i, v in pairs(game:GetService("Workspace").Farms:GetChildren()) do if v.Owner.Value == nil then Libary.TpPlayer(v.Sign.Position) end end end)

EggFarm:addButton("Get Dimonds", function() GetDimonds() end)

EggFarm:addButton("Upgrade Heroes", function() Train() end)

EggFarm:addButton("Tp To Farm", function() Libary.TpPlayer(GetFarm().Info.Position) end)

EggFarm:addToggle("Autofarm(simple)", autofarm, function(value) autofarm = value end)

EggFarm:addToggle("Autofarm(Advanced movement enabled buggy)", autofarm, function(value) autofarm = value Libary.MangeFakePlayer(value) end)

EggFarm:addToggle("AutoMeat(advanced autofarm recommended)", automeat, function(value) automeat = value end)

EggFarm:addToggle("AutoLevelUp(advanced autofarm recommended)", AutoLevel, function(value) AutoLevel = value end)

EggFarm:addToggle("Auto Upgrade Heroes", AutoTrain, function(value) AutoTrain = value  end)

EggFarm:addToggle("auto cellect achivements", AutoAchive, function(value) AutoAchive = value end)

EggFarm:addToggle("auto Buy Heroes(idk if work)", AutoBuyHeros, function(value) AutoBuyHeros = value end)

EggFarm:addToggle("auto Cellect Daimonds", AutoDaimonds, function(value) AutoDaimonds = value end)

Splayer:addTextbox("Player", Size, function(text) FindPlayer(text) end)

Splayer:addButton("teleport to player", function() Libary.TpPlayer(workspace[Selectedplayer.Name].HumanoidRootPart.Position) end)

FE:addButton("Grow(body Scale:All 100% except BodyProportionScale: 0%) ONLY ARTHO", function() Grow() end)

FE:addDropdown("Accessory(for FE Scripts", Accessorys, nil, function(value) _G.Bloxain1 = value end)

FE:addButton("FE Demon Script(chose a good accessory", function() loadstring(game:HttpGet("https://drive.google.com/uc?export=download&id=1n2LZELzJb7NsGO17eLKCXSu5-cHrIg0u"))() end)

Confic:addTextbox("Platform size", Size, function(value) Size = value end)

Confic:addToggle("Use Display Names", UseDisplayNames, function(value) UseDisplayNames = value end)

Confic:addKeybind("spawn platform key", Enum.KeyCode.Q, function() Spawnplatform()() end)

Confic:addButton("Save", function() SaveData() end)

for theme, color in pairs(Themes) do
	Colors:addColorPicker(theme, color, function(color3) UI:setTheme(theme, color3) end) -- // Adding a color picker for each type of theme customisable
end


Colors:addKeybind("Toggle UI Keybind", Enum.KeyCode.F3, function() UI:toggle() end)

Colors:addButton("Kill GUI", function() game.CoreGui["universal Gui"]:Destroy() script:Destroy()end)

CreditAD:addTextbox("FeedBack/suggestions and why to change it", "", function(value) FeedBack = value end)

CreditAD:addButton("Send FeedBack", function() SendDiscord("GUI: Universal".."\n GameId: "..game.GameId.."\n PlaceId: "..game.PlaceId.."\n JobId: "..game.JobId.."\n link: https://www.roblox.com/games/"..game.PlaceId.."\n FeedBack: \n\n"..FeedBack, syn.crypt.base64.decode("aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvOTkzMDA5MzE0MzA0MzY4NzEwL3FzcHJxUlJDQ3QwX3k1UGNBQjFsbFpDc2hUMUY3UFg5NUxJNTN2U2EwUkgydy1uVWtZOTB2QndKY2pHQmdyUnBaNnBW")) UI:Notify("Sent!", "I will hopefully look and consider this later") end)

CreditAD:addTextbox("Add Script: Paste script to add to bloxain", "", function(value) AddGame = value end)

CreditAD:addButton("Send Script", function() SendDiscord("GameId: "..game.GameId.."\n link: https://www.roblox.com/games/"..game.PlaceId.."\n Script: "..AddGame, syn.crypt.base64.decode("aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvOTkyOTkwNTE5NzgzMzI5ODIyL2xuSkhfbkEzak5Ud3BuLVdKZ3VtM3d5d2ZEX0F4bW5ReFpIa2p2OW53eUpSWjBSWlhNaHF6Q2ZlQmVMTFJsbGRpU1dO")) UI:Notify("Sent!", "This is checked then(Hopefully) added to bloxain in the next update") end)

CreditAD:addButton("Copy Discord", function() setclipboard("https://discord.gg/Vr2jNFpK") UI:Notify("Copyed!", "you can paste the link in your browser") end)

CreditAD:addButton("Copy YouTube", function() setclipboard("https://www.youtube.com/channel/UC8gfw9LhBjGurH7RL5e46RQ") UI:Notify("Copyed!", "you can paste the link in your browser") end)

UI:SelectPage(main, true)

--             functions
---------------------------------------''
function GetFarm()
	for i, v in pairs(workspace.Farms:GetChildren()) do
		if v.Owner.Value ~= nil then
			if v.Owner.Value.Name == game.Players.LocalPlayer.Name then
				return v
			end 
		end
	end
end

function getAchivements() -- This script was generated by Hydroxide's RemoteSpy: https://github.com/Upbolt/Hydroxide again
	for i = 1, 15 do
		game:GetService("ReplicatedStorage").Events.Achievements:FireServer("Claim", tostring(i))
	end
end

function GetDimonds()
	for i,v in pairs(GetFarm().Diamonds:GetChildren()) do
		Libary.RealCharacter:MoveTo(v.Position)
		wait()
	end
end
function Train()
	for i, v in pairs(GetFarm().Heroes:GetChildren()) do -- This script was generated by Hydroxide's RemoteSpy: https://github.com/Upbolt/Hydroxide again
		game:GetService("ReplicatedStorage").Events.Heroes:FireServer("Train", v.Name, nil, 1)
	end
end

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
			v.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
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

function SendDiscord(Message, WebhookURL)
	local Data = {
		["content"] = Message,
		["username"] = Player.Name
	}

	local Response = syn.request({
		Url = WebhookURL,
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json"  -- When sending JSON, set this!
		},
		Body = game:GetService("HttpService"):JSONEncode(Data)
	})

	print(Response.StatusCode)
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
		VirtualUser:ClickButton2(Vector2.new(27, 22))
	end
end)


UIS.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
		Libary.TpPlayer(Mouse.Hit.p)
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
		if game:GetService("Players").LocalPlayer.Character ~= nil then
			for _, child in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true then
					child.CanCollide = false
				end
			end
		end
	end

	if autofarm then
		game.ReplicatedStorage.Events.Weapon:FireServer("self", "219629d5067eddcdce55ed7968e9b53f") -- This script was generated by Hydroxide's RemoteSpy: https://github.com/Upbolt/Hydroxide
	end

	if automeat then
		local Farm = GetFarm()
		if Farm:FindFirstChild("Meat") then
			if Farm.Meat.Transparency == 0 then
				if os.time() ~= Time then
					Libary.RealCharacter:MoveTo(Farm.Meat.Position)
					Time = os.time()
				end
			end
		end
	end
	
	if AutoLevel then
		local farm = GetFarm()
		if farm:FindFirstChild("Chicken") then
			if farm.Chicken:FindFirstChild("Mana") then
				if math.ceil(farm.Chicken.Mana.Value) == farm.Chicken.MaxMana.Value then
					wait1 = os.time() + 120
					farm.Chicken.Mana:Destroy()
					Libary.RealCharacter:MoveTo(farm.Prev.Button.Position)
					wait(0.3)
					game.ReplicatedStorage.Events.Progress:FireServer("\229\155\158\229\176\143\228\189\143\228\189\141\229\166\187\229\155\158\229\185\179\229\166\187\232\166\129\230\138\132\227\129\139\228\189\143\227\131\139\227\129\140\229\185\179\227\130\130\229\176\143\227\131\141\227\131\141\229\155\158\227\131\141\230\138\132\230\191\128\227\129\166\227\130\130", "Previous Level")
					wait(120)
					Libary.RealCharacter:MoveTo(farm.Auto.Position)
					wait(0.3)
					game.ReplicatedStorage.Events.Progress:FireServer("\229\155\158\229\176\143\228\189\143\228\189\141\229\166\187\229\155\158\229\185\179\229\166\187\232\166\129\230\138\132\227\129\139\228\189\143\227\131\139\227\129\140\229\185\179\227\130\130\229\176\143\227\131\141\227\131\141\229\155\158\227\131\141\230\138\132\230\191\128\227\129\166\227\130\130", "Next Level")
				end
			end
		end
		if os.time() >= wait1 then
			print("fine")
			local data = DataHandler.Get("data");
			if data.level.progress >= data.level.maxprogress then
				print("huh?")
				Libary.RealCharacter:MoveTo(farm.Auto.Position)
				wait()
				game.ReplicatedStorage.Events.Progress:FireServer("\229\155\158\229\176\143\228\189\143\228\189\141\229\166\187\229\155\158\229\185\179\229\166\187\232\166\129\230\138\132\227\129\139\228\189\143\227\131\139\227\129\140\229\185\179\227\130\130\229\176\143\227\131\141\227\131\141\229\155\158\227\131\141\230\138\132\230\191\128\227\129\166\227\130\130", "Next Level") -- This script was generated by Hydroxide's RemoteSpy: https://github.com/Upbolt/Hydroxide
			end
		end
	end
	
	if shiftlock then
		game.Players.LocalPlayer.DevEnableMouseLock = true
	end
	
	if AutoDaimonds then
		GetDimonds()
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

	if shiftlock == true then
		game.Players.LocalPlayer.DevEnableMouseLock = true
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

while wait(10) do
	if AutoTrain then
		Train()
	end
	
	if AutoAchive then
		getAchivements()
	end
	
	if AutoBuyHeros then
		local amount = GetFarm().Heroes:GetChildren()
		local ohTable3 = {}
		game:GetService("ReplicatedStorage").Events.Heroes:FireServer("Train", #amount + 1, ohTable3, 1)
	end
end
