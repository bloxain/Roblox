local col = nil
local Selectedplayer = nil
local HideUItoggle = false
local useJumpPower = true
local hitboxenabled = false
local ScriptRunning  = true
local UseDisplayNames = false
local Size = 6
local HeadSize = 20
local walkspeed = 16
local jumpPower = 50
local SavedFog = 100000
local AddGame = ""
local FeedBack = ""
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local VirtualUser = game:service'VirtualUser'
local runservice = game:GetService'RunService'
local Inputservice = game:GetService'UserInputService'
local UI = loadstring(readfile("BloxainHub/Modules/UI.Lua"))()
local Libary = loadstring(readfile("BloxainHub/Modules/Main.Lua"))()
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
local Erails = {}
local NErails = {}


repeat task.wait() until Libary.GetChar()

for i, v in pairs(Libary.GetChar():GetChildren()) do
	if v:IsA("Accessory") then
		table.insert(Accessorys, 1, v.Name)
	end
end

if Libary.GetChar().Humanoid.UseJumpPower == false then
	jumpPower = 7
	useJumpPower = false
end

-------------------------------------
function Gates(typee, onoff)
	for i, v in pairs(workspace:GetChildren()) do
		if v.Name == "crossing" then
			if typee == "Remove" then
				v.Pole.CanCollide = not onoff
			elseif typee == "Gate" then
				firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Button, 1)
				task.wait(.1)
				firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Button, 0)
			end
		end
	end
end

function DeacivateWire(value)
	for i, v in pairs(workspace:GetChildren()) do
		if v.Name == "garrote wire" then
			if value then
				v.Position = Vector3.new(v.Position.X, v.Position.Y + 1000, v.Position.Z)
			else
				v.Position = Vector3.new(v.Position.X, v.Position.Y - 1000, v.Position.Z)
			end
		end
	end
end

function DeacivatePendulum(value)
	for i, v in pairs(workspace:GetChildren()) do
		if v.Name == "Pendulum" then
			for o, p in pairs(v:GetDescendants()) do
				if p:IsA("HingeConstraint") then
					if value then
						repeat wait() until p.Parent.Orientation.Z == 180
						p.Parent.Anchored = true
					else
						p.Parent.Anchored = false
					end
				end
			end
		end
	end
end

function DeacivateRail(value)
	for i, v in pairs(workspace:GetChildren()) do
		if v.Name == "ElectrifiedRail" then
			table.insert(Erails, 1, v)
			if value then
				local NewRail = Instance.new("Part")
				NewRail.Name = "NonElectrifiedRail"
				NewRail.Size = v.Size
				NewRail.CFrame = v.CFrame
				NewRail.Material = Enum.Material.Metal
				NewRail.Color = Color3.fromRGB(202, 203, 209)
				NewRail.Parent = v.Parent
				NewRail.Anchored = v.Anchored
				v.Size = Vector3.new(0, 0, 0)
			end
		elseif v.Name == "NonElectrifiedRail" then
			table.insert(NErails, 1, v)
		end
	end

	if value == false then
		for i = 1, #NErails do
			local Rail = Erails[i]
			local Otherrail = NErails[i]
			Rail.Size = Otherrail.Size
			Rail.Position = Otherrail.Position
			Rail.Orientation = Otherrail.Orientation

			Otherrail:Destroy()
		end
	end
	Erails = {}
	NErails = {}
end
-------------------------------------
local Window = UI:MakeWindow({Name = "universal Gui", HidePremium = false, SaveConfig = true, ConfigFolder = "BloxainHub\Saves", IntroEnabled = Libary.PlayInto, IntroText = Libary.IntroName})

local Main = Window:MakeTab({Name = "Main", Icon = "", PremiumOnly = false})

local GameAd = Window:MakeTab({Name = "Game", Icon = "", PremiumOnly = false})

local FE = Window:MakeTab({Name = "FE Scripts", Icon = "", PremiumOnly = false})

local Carts = Window:MakeTab({Name = "Cart Page", Icon = "", PremiumOnly = false})

local Settings = Window:MakeTab({Name = "Settings", Icon = "", PremiumOnly = false})

local Credits = Window:MakeTab({Name = "FeedBack", Icon = "", PremiumOnly = false})


Main:AddButton({Name = "save location", Callback = function() col = Libary.GetChar().HumanoidRootPart.Position end})

Main:AddButton({Name = "Load location", Callback = function() Libary.TpPlayer(col) end})

Main:AddButton({Name = "Clear Platforms", Callback = function() clearplatforms() end})

Main:AddButton({Name = "Reset Camera", Callback = function() Fixcamera() end})

Main:AddToggle({Name = "noclip", Flag = "Noclip", Default = false, Save = true})

Main:AddToggle({Name = "Inf jump", Flag = "inf jump", Default = false, Save = true})

Main:AddToggle({Name = "click teleport", Flag = "ClickOn", Default = false, Save = true})

Main:AddToggle({Name = "alt click delete", Flag = "clickdelete", Default = false, Save = true})

Main:AddToggle({Name = "spawn platform", Flag = "spawnplatform", Default = false, Save = true})

Main:AddToggle({Name = "awalys enable shiftlock", Flag = "enableshiftlock", Default = false, Save = true,})

Main:AddToggle({Name = "Anti AFK", Flag = "antiafk", Default = false, Save = true, Callback = function(Value) AntiAFK = Value end})

Main:AddToggle({Name = "Unlock Zomm Distance", Flag = "unlockzoom", Default = false, Save = true, Callback = function(Value) if Value == false then game.Players.LocalPlayer.CameraMaxZoomDistance = 128 end unlockzoom = Value end})

Main:AddBind({Name = "Hide UI", Flag = "Hide UI Key", Default = Enum.KeyCode.F4, Hold = false, Callback = function() toggleUI(HideUItoggle) HideUItoggle = not HideUItoggle end})

Main:AddSlider({Name = "Player Speed", Flag = "PlayerSpeed", Min = 16, Max = 300, Default = 16, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "Player Speed", Callback = function(Value) Libary.GetChar().Humanoid.WalkSpeed = Value walkspeed = Value end})

Main:AddSlider({Name = "Player jumpPower", Flag = "PlayerJump", Min = jumpPower, Max = 300, Default = jumpPower, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "Player jumpPower", Callback = function(Value) Libary.GetChar().Humanoid.JumpPower = Value jumpPower = Value end})


GameAd:AddTextbox({Name = "Player", Default = "", TextDisappear = true, Callback = function(Value) Selectedplayer = FindPlayer(Value) end})

GameAd:AddButton({Name = "teleport to player", Callback = function() Libary.TpPlayer(workspace[Selectedplayer.Name].HumanoidRootPart.Position) end})

GameAd:AddToggle({Name = "Hitbox expander", Flag = "Hitbox", Default = false, Save = false, Callback = function(Value) hitboxenabled = Value if Value == false then for i,v in next, game:GetService('Players'):GetPlayers() do if v ~= Player then if not v.Character:FindFirstChild("HumanoidRootPart") then return end v.Character.HumanoidRootPart.Size = Vector3.new(2,1,2) v.Character.HumanoidRootPart.Transparency = 1	v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really white")	v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end end end end})


GameAd:AddSlider({Name = "Fps Cap", Min = 60, Max = 1000, Default = 60, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "Fps Cap", Callback = function(Value) setfpscap(Value) end})

GameAd:AddSlider({Name = "Gravity", Min = 0, Max = 196.2, Default = 196.2, Color = Color3.fromRGB(255,255,255), Increment = .1, ValueName = "Gravity", Callback = function(Value) workspace.Gravity = Value end})

GameAd:AddToggle({Name = "Remove Fog", Default = false, Save = false, Callback = function(Value) if Value == true then game.Lighting.FogEnd = math.huge SavedFog = game.Lighting.FogEnd return end game.Lighting.FogEnd = SavedFog end})

GameAd:AddButton({Name = "PERMATE remove texutres", Callback = function() RemoveTexures() end})



FE:AddButton({Name = "Grow(body Scale:All 100% except BodyProportionScale: 0%) ONLY ARTHO", Callback = function() Grow() end})

FE:AddDropdown({Name = "Accessory(for FE Scripts)", Default = "", Options = Accessorys, Callback = function(Value) _G.Bloxain1 = Value end})

FE:AddButton({Name = "FE Demon Script(cose a good accessory", Callback = function() loadstring(game:HttpGet("https://drive.google.com/uc?export=download&id=1n2LZELzJb7NsGO17eLKCXSu5-cHrIg0u"))() end})


Carts:AddLabel("Cart cmds")

Carts:AddToggle({Name = "Speed Carts", Flag = "Speed Carts", Default = false, Save = false})

Carts:AddButton({Name = "set Speed", Callback = function() LockCarts() end})

Carts:AddSlider({Name = "Cart Speed", Flag = "Cart Speed", Min = -300, Max = 300, Default = 0, Color = Color3.fromRGB(255,255,255), Increment = 5, ValueName = "Player Speed"})

Carts:AddButton({Name = "Spawn all carts", Callback = function() SpawnAllCarts() end})

Carts:AddToggle({Name = "Spawn all Carts", Flag = "Spawn Carts", Default = false, Save = false})

Carts:AddLabel("Bombs cmds")

Carts:AddDropdown({Name = "Bomb Cmds", Flag = "Bomb Cmds", Default = "Spawn", Options = {"Delete", "Spawn", "Explode", "backward", "forward", "paused"}})

Carts:AddButton({Name = "Run Cmd", Callback = function() Bombcmds(UI.Flags["Bomb Cmds"].Value) end})

Carts:AddToggle({Name = "Spawn Bombs", Flag = "Spawn Bombs", Default = false, Save = false})

Carts:AddToggle({Name = "Delete Bombs", Flag = "Delete Bombs", Default = false, Save = false})

Carts:AddToggle({Name = "Explode Bombs", Flag = "Explode Bombs", Default = false, Save = false})

Carts:AddToggle({Name = "Move Bombs forward", Flag = "Move Bombs forward", Default = false, Save = false})

Carts:AddToggle({Name = "Move Bombs backward", Flag = "Move Bombs backward", Default = false, Save = false})

Carts:AddToggle({Name = "Stop Bombs", Flag = "Stop Bombs", Default = false, Save = false})

Carts:AddLabel("Game cmds")

DeacivateWire(true) DeacivateRail(true)

Carts:AddToggle({Name = "Deacivate Elecric Rails", Default = false, Callback = function(Value) DeacivateRail(Value) end})

Carts:AddToggle({Name = "Deacivate Pendulums", Default = false, Callback = function(Value) DeacivatePendulum(Value) end})

Carts:AddToggle({Name = "Cut garrote wires", Default = false, Callback = function(Value) DeacivateWire(Value) end})

Carts:AddToggle({Name = "Dissable Gates", Default = false, Callback = function(Value) Gates("Remove", Value) end})

Carts:AddButton({Name = "Toggle Gates", Callback = function() Gates("Gate") end})

Carts:AddDropdown({Name = "Teleports", Flag = "TPs", Default = "Spawn", Options = {"admissions", "Spawn", "Pit Stop", "Winner", "End Block", "Car Battery"}})

Carts:AddButton({Name = "Go to Selected Teleport", Callback = function() TpTOarea(UI.Flags["TPs"].Value) end})

Carts:AddButton({Name = "Collect Coins", Callback = function() GetCoins() end})


Settings:AddSlider({Name = "Platform Size", Flag = "Platformsize", Save = true, Min = 1, Max = 100, Default = 6, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "Platform Size"})

Settings:AddSlider({Name = "Hitbox size", Flag = "HitboxSize", Save = true, Min = 1, Max = 100, Default = 6, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "Hitbox size"})

Settings:AddToggle({Name = "Use Display Names", Flag = "UseDispayNames", Default = false, Save = true, Callback = function(Value) UseDisplayNames = Value end})

Settings:AddBind({Name = "spawn platform", Flag = "SpawnPlatform Key",  Default = Enum.KeyCode.Q, Hold = false, Save = true, Callback = function() if UI.Flags["spawnplatform"].Value then Spawnplatform() end end})

Settings:AddBind({Name = "click teleport", Flag = "ClickTp Key", Default = Enum.KeyCode.LeftControl, Hold = false, Save = true})

Settings:AddButton({Name = "Kill GUI", Callback = function() UI:Destroy() end})



Credits:AddTextbox({Name = "FeedBack/suggestions and why to change it", Default = "", Flag = "Feedback", TextDisappear = true, Callback = function(Value) FeedBack = Value end})

Credits:AddButton({Name = "Send FeedBack", Callback = function() Libary.SendDiscord("GUI: Universal".."\n GameId: "..game.GameId.."\n PlaceId: "..game.PlaceId.."\n JobId: "..game.JobId.."\n link: https://www.roblox.com/games/"..game.PlaceId.."\n FeedBack: \n\n"..FeedBack) UI:MakeNotification({Name = "Sent!", Content = "I will hopefully look and consider this later", Time = 5}) end})

Credits:AddTextbox({Name = "Add Script: Paste script to add to bloxain", Flag = "SendScript", Default = "", TextDisappear = true, Callback = function(Value) AddGame = Value end})

Credits:AddButton({Name = "Send Script", Callback = function() Libary.SendDiscord("GameId: "..game.GameId.."\n link: https://www.roblox.com/games/"..game.PlaceId.."\n Script: "..AddGame) UI:MakeNotification({Name = "Sent!", Content = "This is checked then(Hopefully) added to bloxain in the next update", Time = 5}) end})

Credits:AddButton({Name = "Copy Discord", Callback = function() setclipboard(Libary.Discord) UI:Notify("Copyed!", "you can paste the link in your browser") end})

Credits:AddButton({Name = "Copy YouTube", Callback = function() setclipboard(Libary.Youtube) UI:Notify("Copyed!", "you can paste the link in your browser") end})

Credits:AddParagraph("Credits & Info",[["Team - Me(not even the docs)
LIBARYS OrionLib / Veny x
INFO - this code is open source for script creators and Game Devs(yes i hope game devs patch this script to better there game and my ablitys to script) my spelling sucks"]])

--             functions
---------------------------------------''
function LockCarts()
	for i, v in pairs(workspace:GetChildren()) do
		if string.find(v.Name, "Cart") then
			if v:FindFirstChild("forward") then
				if v:FindFirstChild("speed") then
					if v:FindFirstChild("backward") then
						local Temp = math.floor(v.speed.Value / 15)*15
						if Temp < UI.Flags["Cart Speed"].Value then
							repeat fireclickdetector(v.forward.ClickDetector) Temp += 5 until Temp == UI.Flags["Cart Speed"].Value
						elseif Temp > UI.Flags["Cart Speed"].Value then
							repeat fireclickdetector(v.backward.ClickDetector) Temp -= 5 until Temp == UI.Flags["Cart Speed"].Value
						end
					end
				end
			end
		end
	end
end

function SpawnAllCarts()
	if not Libary.GetChar() then
		return
	end
	for i,v in pairs(workspace:GetChildren()) do
		if v.Name == "rustyrespawner" or v.Name == "respawner" then
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.respawn, 1)
			wait(.1)
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.respawn, 0)
		end
	end
end

function TpTOarea(value)
	if value == "admissions" then
		Libary.TpPlayer(workspace['pride flag'].Part.Position)
	elseif value == "Spawn" then
		Libary.TpPlayer(workspace.Baseplate.Position)
	elseif value == "Pit Stop" then
		Libary.TpPlayer(workspace.haus.Part.Position)
	elseif value == "Winner" then
		Libary.TpPlayer(Vector3.new(-610.458, 158.138, 674.412))
	elseif value == "End Block" then
		Libary.TpPlayer(Vector3.new(-495.131, 182.381, 597.852))
	elseif value == "Car Battery" then
		Libary.TpPlayer(Vector3.new(-325.126, 216.547, 656.283))
	end
end

function GetCoins()
	for i, v in pairs(workspace.coinspawner:GetDescendants()) do
		if v.Name == "Handle" then
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
			task.wait(.1)
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
		end
	end
end

function Bombcmds(typee)
	for i, v in pairs(workspace:GetChildren()) do
		if not Libary.GetChar() then
			return
		end
		if v.Name == "BombCart" then
			if v:FindFirstChild("move") and v:FindFirstChild("explode") then
				if typee == "Delete" then
					v:Destroy()
				elseif typee == "Spawn" then
					firetouchinterest(Libary.GetChar().HumanoidRootPart, workspace.bombrespawnerply.respawn, 1)
					task.wait(.1)
					firetouchinterest(Libary.GetChar().HumanoidRootPart, workspace.bombrespawnerply.respawn, 0)
				elseif typee == "Explode" then
					fireclickdetector(v.explode.ClickDetector)
				elseif typee == "backward" then
					if v:FindFirstChild("move").direction.Value == "forward" then
						fireclickdetector(v:FindFirstChild("move").ClickDetector)
						fireclickdetector(v:FindFirstChild("move").ClickDetector)
					elseif v:FindFirstChild("move").direction.Value == "paused" then
						fireclickdetector(v:FindFirstChild("move").ClickDetector)
					end
				elseif typee == "forward" then
					if v:FindFirstChild("move").direction.Value == "paused" then
						fireclickdetector(v:FindFirstChild("move").ClickDetector)
						fireclickdetector(v:FindFirstChild("move").ClickDetector)
					elseif v:FindFirstChild("move").direction.Value == "backward" then
						fireclickdetector(v:FindFirstChild("move").ClickDetector)
					end
				elseif typee == "paused" then
					if v:FindFirstChild("move").direction.Value == "backward" then
						fireclickdetector(v:FindFirstChild("move").ClickDetector)
						fireclickdetector(v:FindFirstChild("move").ClickDetector)
					elseif v:FindFirstChild("move").direction.Value == "forward" then
						fireclickdetector(v:FindFirstChild("move").ClickDetector)
					end
				end
			end
		end
	end
end

local temp = Instance.new("BindableEvent")
temp.Event:Connect(function()
	if not ScriptRunning then return end
	while wait(1) do
		if UI.Flags["Delete Bombs"].Value then
			Bombcmds("Delete")
		elseif UI.Flags["Stop Bombs"].Value then
			Bombcmds("paused")
		elseif UI.Flags["Explode Bombs"].Value then
			Bombcmds("Explode")
		elseif UI.Flags["Move Bombs forward"].Value then
			Bombcmds("forward")
		elseif UI.Flags["Move Bombs backward"].Value then
			Bombcmds("backward")
		elseif UI.Flags["Spawn Bombs"].Value then
			Bombcmds("Spawn")
		end

		if UI.Flags["Spawn Carts"].Value then
			LockCarts()
		end

		if UI.Flags["Spawn Carts"].Value then
			SpawnAllCarts()
		end
	end
end)
temp:Fire()

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

function Spawnplatform(Transparency)
	local Clone = Instance.new("Part")
	Clone.Parent = workspace
	Clone.Anchored = true
	Clone.Size = Vector3.new(UI.Flags["Platformsize"].Value, 1, UI.Flags["Platformsize"].Value)
	Clone.Name = "falksjdhflkjasdhflkjasdhflkjasdfhj"
	Clone.Transparency = Transparency

	if game.Players.LocalPlayer.Character:FindFirstChild("Left Leg") then
		Clone.Position = Player.Character["Left Leg"].Position
	else
		Clone.Position = Player.Character["LeftFoot"].Position
	end
	return Clone
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
	if UI.Flags["clickdelete"].Value == true then
		if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
		if not Mouse.Target then return end
		Mouse.Target:Destroy()
	end 
end)

game.Players.LocalPlayer.Idled:connect(function()
	if UI.Flags["antiafk"].Value == true then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)


Mouse.Button1Down:Connect(function()
	if not game:GetService("UserInputService"):IsKeyDown(UI.Flags["ClickTp Key"].Value) then return end
	local temp = game.Players.LocalPlayer:GetMouse().Hit.p
	repeat wait() until workspace:FindFirstChild(game.Players.LocalPlayer.Name)
	if UI.Flags["ClickOn"].Value then
		game.Players.LocalPlayer.Character:MoveTo(temp)
	end
end)

-----------------------------------Run service----------------------------------------------------------------------------------------------------
runservice.Stepped:connect(function()
	if not ScriptRunning then return end
	if UI.Flags["Noclip"].Value then
		for _, child in pairs(Libary.GetChar():GetDescendants()) do
			if child:IsA("BasePart") and child.CanCollide == true then
				child.CanCollide = false
			end
		end
	end

	if UI.Flags["enableshiftlock"].Value then
		game.Players.LocalPlayer.DevEnableMouseLock = true
	end

	if UI.Flags["unlockzoom"].Value then
		game.Players.LocalPlayer.CameraMaxZoomDistance = 99999
	end

	if UI.Flags["inf jump"].Value then
		if Inputservice:IsKeyDown(Enum.KeyCode.Space) then
			local temp = Spawnplatform(1)
			task.wait(.03)
			temp:Destroy()
		end
	end

	if UI.Flags["Hitbox"].Value then
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
end) runservice.RenderStepped:Connect(function()
	if UI.Flags["Hitbox"].Value then
		for i,v in next, game:GetService('Players'):GetPlayers() do
			if v.Name ~= game:GetService('Players').LocalPlayer.Name then
				pcall(function()
					v.Character.HumanoidRootPart.Size = Vector3.new(UI.Flags["HitboxSize"].Value,UI.Flags["HitboxSize"].Value,UI.Flags["HitboxSize"].Value)
					v.Character.HumanoidRootPart.Transparency = 0.8
					v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really white")
					v.Character.HumanoidRootPart.Material = "Neon"
					v.Character.HumanoidRootPart.CanCollide = false
				end)
			end
		end
	end
end)

function CharLoaded(Char)
	Char.Humanoid.Changed:Connect(function()
		if UI.Flags["PlayerJump"].Value ~= 50 and UI.Flags["PlayerJump"].Value ~= 7 then
			if useJumpPower then
				Char.Humanoid.JumpPower = UI.Flags["PlayerJump"].Value
			else
				Char.Humanoid.JumpHeight = UI.Flags["PlayerJump"].Value
			end
		end
		if UI.Flags["PlayerSpeed"].Value ~= 16 then
			Char.Humanoid.WalkSpeed = UI.Flags["PlayerSpeed"].Value
		end
	end)
	Char.Humanoid.Died:Connect(function()
		ScriptRunning = false
	end)
end
CharLoaded(Libary.GetChar())
game.Players.LocalPlayer.CharacterAdded:Connect(function(Char)
	Char:WaitForChild("Humanoid")
	CharLoaded(Char)
	ScriptRunning = true
end)

UI:Init() 	 
