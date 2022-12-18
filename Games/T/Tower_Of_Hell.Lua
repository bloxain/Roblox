local col = nil
local Selectedplayer = nil
local HideUItoggle = false
local useJumpPower = true
local hitboxenabled = false
local ScriptRunning  = true
local UseDisplayNames = false
local Size = 6
local HeadSize = 20
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

repeat task.wait() until Libary.GetChar()

--------------- Lazy
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

function Changehight(pos)
	if not Firsttime then
		Firsttime = true
		return
	end
	local thing = Libary.GetChar().HumanoidRootPart.Position Libary.GetChar().HumanoidRootPart.Position = Vector3.new(thing.X, pos, thing.Z) 
end
---------------

for i, v in pairs(Libary.GetChar():GetChildren()) do
	if v:IsA("Accessory") then
		table.insert(Accessorys, 1, v.Name)
	end
end

if Libary.GetChar().Humanoid.UseJumpPower == false then
	jumpPower = 7
	useJumpPower = false
end

local Window = UI:MakeWindow({Name = "Tower of Hell", HidePremium = false, SaveConfig = true, ConfigFolder = "BloxainHub\Saves", IntroEnabled = Libary.PlayInto, IntroText = Libary.IntroName})

local Main = Window:MakeTab({Name = "Main", Icon = "", PremiumOnly = false})

local GameAd = Window:MakeTab({Name = "Game", Icon = "", PremiumOnly = false})

local FE = Window:MakeTab({Name = "FE Scripts", Icon = "", PremiumOnly = false})

local Tower = Window:MakeTab({Name = "Tower", Icon = "", PremiumOnly = false})

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

Main:AddToggle({Name = "Anti AFK", Flag = "antiafk", Default = false, Save = true})

Main:AddToggle({Name = "Unlock Zomm Distance", Flag = "unlockzoom", Default = false, Save = true, Callback = function(Value) if Value == false then game.Players.LocalPlayer.CameraMaxZoomDistance = 128 end unlockzoom = Value end})

Main:AddBind({Name = "Hide UI", Flag = "Hide UI Key", Default = Enum.KeyCode.F4, Hold = false, Save = true, Callback = function() toggleUI(HideUItoggle) HideUItoggle = not HideUItoggle end})

Main:AddSlider({Name = "Player Speed", Flag = "PlayerSpeed", Min = 16, Max = 300, Default = 16, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "Player Speed", Callback = function(Value) Libary.GetChar().Humanoid.WalkSpeed = Value end})

Main:AddSlider({Name = "Player jumpPower", Flag = "PlayerJump", Min = 50, Max = 300, Default = jumpPower, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "Player jumpPower", Callback = function(Value) Libary.GetChar().Humanoid.JumpPower = Value end})


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


Tower:AddToggle({Name = "Anti bunny jump", Flag = "AntiB", Default = false, Save = true, Callback = function(Value) if Value == false then if game.Players.LocalPlayer.PlayerGui.timer.mutators:FindFirstChild("bunny") then Libary.GetChar().bunnyJump.Disabled = false end end end})

Tower:AddToggle({Name = "Anti Kill", Flag = "AntiK", Default = false, Save = true})

Tower:AddToggle({Name = "Anti Low Gravity", Flag = "AntiLow", Default = false, Save = true})

Tower:AddToggle({Name = "Anti Walk Speed", Flag = "AntiSpeed", Default = false, Save = true})

Tower:AddToggle({Name = "Anti Fog", Flag = "AntiF", Default = false, Save = true, Callback = function(Value) if Value == false then if game.Players.LocalPlayer.PlayerGui.timer.mutators:FindFirstChild("fog") then game.Lighting.FogEnd = 50 end end end})

Tower:AddToggle({Name = "Anti invisible", Flag = "AntiI", Default = false, Save = true, Callback = function(Value) if Value == false then if game.Players.LocalPlayer.PlayerGui.timer.mutators:FindFirstChild("invisibility") then for i, v in  pairs(game.Players:GetChildren()) do DissableINV(v.Character, 1) end end end end})

Tower:AddToggle({Name = "Anti Negitive", Flag = "AntiN", Default = false, Save = true, Callback = function(Value) if Value == false then if game.Players.LocalPlayer.PlayerGui.timer.mutators:FindFirstChild("negative") then game.Lighting.Negative.Saturation = -2 end end end})

Tower:AddButton({Name = "Insant win(WARNING may ban do later in round)", Callback = function() if UI.Flags["SpeedTower"].Value == false then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.tower.sections.finish.exit.ParticleBrick.CFrame else game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.tower.sections.finish.FinishGlow.CFrame end end})

Tower:AddSlider({Name = "Change Hight(meter)", Flag = "", Min = 0, Max = 1000, Default = 0, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "", Callback = function(Value) Changehight(Value) end})

Tower:AddButton({Name = "Give All Tools(local and some dont work)", Callback = function() for i, v in pairs(game.ReplicatedStorage.Gear:GetChildren()) do local clone = v:Clone() clone.Parent = game.Players.LocalPlayer.Backpack end end})

Tower:AddBind({Name = "Time Freeze Key", Flag = "Time Freeze Key", Default = Enum.KeyCode.E, Hold = false, Save = true, Callback = function() game.Players.LocalPlayer.PlayerScripts.timefreeze.Value = not game.Players.LocalPlayer.PlayerScripts.timefreeze.Value end})

Tower:AddToggle({Name = "ShowPlayers(for anti inv)", Flag = "AntiII", Default = false, Save = true, Callback = function(Value) if Value == false then 	for i, v in  pairs(game.Players:GetChildren()) do if v ~= game.Players.LocalPlayer then DissableINV(v.Character, 0) end end end end})

Tower:AddToggle({Name = "Hide Players", Flag = "Hide Players", Default = false, Save = true, Callback = function(Value) if value == false then for i, v in  pairs(game.Players:GetChildren()) do if v ~= game.Players.LocalPlayer then DissableINV(v.Character, 0) end end end end})



Tower:AddToggle({Name = "Speed tower", Flag = "SpeedTower", Default = false, Save = true})

Tower:AddToggle({Name = "Enabled", Flag = "AutoFarm", Default = false, Save = true})


Settings:AddSlider({Name = "Platform Size", Flag = "Platformsize", Save = true, Min = 1, Max = 100, Default = 6, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "Platform Size"})

Settings:AddSlider({Name = "Hitbox size", Flag = "HitboxSize", Save = true, Min = 1, Max = 100, Default = 6, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "Hitbox size"})

Settings:AddToggle({Name = "Use Display Names", Flag = "UseDispayNames", Default = false, Save = true, Callback = function(Value) UseDisplayNames = Value end})

Settings:AddBind({Name = "spawn platform", Flag = "SpawnPlatform Key",  Default = Enum.KeyCode.Q, Hold = false, Save = true, Callback = function() if UI.Flags["spawnplatform"].Value then Spawnplatform() end end})

Settings:AddBind({Name = "click teleport", Flag = "ClickTp Key", Default = Enum.KeyCode.LeftControl, Hold = false, Save = true})

Settings:AddButton({Name = "Kill GUI", Callback = function() UI:Destroy() end})

local UISettings = Settings:AddSection({Name = 'UI Settings'})
UISettings:AddBind({Name = 'Toggle UI', Flag = 'ToggleUi', Save = true, Default = Enum.KeyCode.F3, Callback = function() Window:Toggle() end, Save = true})
UISettings:AddToggle({Name = 'Fast Dragging', Flag = 'FastDrag', Save = true, Callback = function(value) UI.Settings.Movement.Lerp = not value UI.Settings.Control().Write(UI.Settings) end})
UISettings:AddToggle({Name = 'Diffrent Dragging', Flag = 'DIffrentDragging', Save = true, Callback = function(value) UI.Settings.Movement.SmallScreen = value UI.Settings.Control().Write(UI.Settings) end, Default = UI.Settings.Movement.SmallScreen})
UISettings:AddSlider({Name = 'Drag Speed', Flag = 'DragSpeed',Min = 1, Max = 100, Save = true, Default = 10, Callback = function(value) UI.Settings.Movement.LerpSpeed = value / 20 end})


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
	if UI.Flags["AutoFarm"].Value then
		if game.Players.LocalPlayer.PlayerGui.timer.timeLeft.Text == "5:00" then
			if UI.Flags["SpeedTower"].Value == true then
				local endzone = workspace.tower.sections.finish.FinishGlow.CFrame local player = game.Players.LocalPlayer.Character player.HumanoidRootPart.CFrame = endzone
			else
				local endzone = workspace.tower.sections.finish.exit.ParticleBrick.CFrame local player = game.Players.LocalPlayer.Character player.HumanoidRootPart.CFrame = endzone
			end
		end
	end

	if UI.Flags["AntiF"].Value then
		game.Lighting.FogEnd = 1200
	end
	
	if UI.Flags["AntiSpeed"].Value then
		Libary.GetChar().Humanoid.WalkSpeed = 16
	end

	if UI.Flags["AntiB"].Value then
		game.Players.LocalPlayer.Character.bunnyJump.Disabled = true
	end

	if UI.Flags["AntiN"].Value then
		game:GetService("Lighting").Negative.Enabled = false
	end
	if UI.Flags["AntiLow"].Value then
		workspace.Gravity = 196.2
	end

	Libary.GetChar().KillScript.Disabled = UI.Flags["AntiK"].Value

	if UI.Flags["Hide Players"].Value then
		for i, v in  pairs(game.Players:GetChildren()) do
			if v ~= game.Players.LocalPlayer then
				DissableINV(v.Character, 1)
				--v.Character.invisible = true
			end
		end
	end

	if workspace:FindFirstChild(game.Players.LocalPlayer.Name) then
		if UI.Flags["AntiI"].Value then
			if UI.Flags["AntiII"].Value then
				for i, v in  pairs(game.Players:GetChildren()) do
					DissableINV(v.Character, 0)
				end
			else
				DissableINV(Libary.GetChar(), 0)				
			end
		end
	end


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
