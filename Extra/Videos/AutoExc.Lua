game.Loaded:Wait()
local AutoOn = false
function ReadWrite(value, Value2)
	if value then
		if isfile("Bloxhub#7364/Saves/AutoLaunch.Lua") == false then
			return "No Data" 
		end
		local Tablee = game:GetService("HttpService"):JSONDecode(readfile("Bloxhub#7364/Saves/AutoLaunch.Lua"))
		for	i, v in pairs(Tablee) do
			if v.Game == game.GameId and v.User == game.Players.LocalPlayer.UserId then
				loadstring(game:HttpGet("https://github.com/bloxain/Roblox/raw/main/Bloxhub.Lua"))()
				AutoOn = true
				return true
			end
		end
	end

	if Value2 then
		local tablee = {}
		if isfile("Bloxhub#7364/Saves/AutoLaunch.Lua") == true then
			tablee = game:GetService("HttpService"):JSONDecode(readfile("Bloxhub#7364/Saves/AutoLaunch.Lua"))
		end
		local insert = {
			["Game"] = game.GameId,
			["User"] = game.Players.LocalPlayer.UserId
		}
		table.insert(tablee, 1, insert)
		writefile("Bloxhub#7364/Saves/AutoLaunch.Lua", game:GetService("HttpService"):JSONEncode(tablee))
		return
	end

	if isfile("Bloxhub#7364/Saves/AutoLaunch.Lua") == false then
		return "No Data" 
	end
	local Tablee = game:GetService("HttpService"):JSONDecode(readfile("Bloxhub#7364/Saves/AutoLaunch.Lua"))
	for	i, v in pairs(Tablee) do
		if v.Game == game.GameId and v.User == game.Players.LocalPlayer.UserId then
			table.remove(Tablee, i)
		end
	end
	writefile("Bloxhub#7364/Saves/AutoLaunch.Lua", game:GetService("HttpService"):JSONEncode(Tablee))
	return
end

ReadWrite(true)

game:WaitForChild("CoreGui")
game.CoreGui:WaitForChild("RobloxGui")
game.CoreGui.RobloxGui:WaitForChild("SettingsShield")
game.CoreGui.RobloxGui.SettingsShield:WaitForChild("SettingsShield")
game.CoreGui.RobloxGui.SettingsShield.SettingsShield:WaitForChild("MenuContainer")
game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer:WaitForChild("PageViewClipper")
game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper:WaitForChild("PageView")
game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView:WaitForChild("PageViewInnerFrame")
game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView.PageViewInnerFrame:WaitForChild("Page")
-------
local BloxainFrame = Instance.new("ImageButton")
local BloxainLable = Instance.new("TextLabel")
local BloxianButton = Instance.new("ImageButton")
local BloxainButtonTextLabel = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

if syn then
	syn.protect_gui(BloxainFrame)
end

for i,v in pairs(game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView.PageViewInnerFrame.Page:GetChildren()) do
	if v:IsA("ImageButton") then
		v.MouseEnter:Connect(function()
			v.BackgroundTransparency = 0.5
		end)
		v.MouseLeave:Connect(function()
			v.BackgroundTransparency = 1
		end)
	end
end

BloxainFrame.Name = "Load Bloxain"
BloxainFrame.Parent = game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView.PageViewInnerFrame:WaitForChild("Page")
BloxainFrame.Active = false
BloxainFrame.BackgroundTransparency = 1.000
BloxainFrame.BorderSizePixel = 0
BloxainFrame.LayoutOrder = 15
BloxainFrame.Position = UDim2.new(0, 0, 0, 550)
BloxainFrame.Selectable = false
BloxainFrame.SelectionImageObject = ImageLabel
BloxainFrame.Size = UDim2.new(1, 0, 0, 50)
BloxainFrame.ZIndex = 2
BloxainFrame.AutoButtonColor = false
BloxainFrame.Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png"
BloxainFrame.ImageColor3 = Color3.fromRGB(163, 162, 165)
BloxainFrame.ImageTransparency = 1.000
BloxainFrame.ScaleType = Enum.ScaleType.Slice
BloxainFrame.SliceCenter = Rect.new(10, 10, 10, 10)

BloxainLable.Name = "Developer ConsoleLabel"
BloxainLable.Parent = BloxainFrame
BloxainLable.BackgroundTransparency = 1.000
BloxainLable.Position = UDim2.new(0, 10, 0, 0)
BloxainLable.Size = UDim2.new(0, 200, 1, 0)
BloxainLable.ZIndex = 2
BloxainLable.Font = Enum.Font.SourceSansBold
BloxainLable.Text = "Bloxain Hub"
BloxainLable.TextColor3 = Color3.fromRGB(255, 255, 255)
BloxainLable.TextSize = 24.000
BloxainLable.TextXAlignment = Enum.TextXAlignment.Left

BloxianButton.Name = "DevConsoleButtonButton"
BloxianButton.Parent = BloxainFrame
BloxianButton.BackgroundTransparency = 1.000
BloxianButton.Position = UDim2.new(1, -400, 0, 12)
BloxianButton.SelectionImageObject = ImageLabel
BloxianButton.Size = UDim2.new(0, 300, 1, -20)
BloxianButton.ZIndex = 2
BloxianButton.AutoButtonColor = false
BloxianButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
BloxianButton.ScaleType = Enum.ScaleType.Slice
BloxianButton.SliceCenter = Rect.new(8, 6, 46, 44)

BloxainButtonTextLabel.Name = "DevConsoleButtonTextLabel"
BloxainButtonTextLabel.Parent = BloxianButton
BloxainButtonTextLabel.BackgroundTransparency = 1.000
BloxainButtonTextLabel.BorderSizePixel = 0
BloxainButtonTextLabel.Size = UDim2.new(1, 0, 1, -8)
BloxainButtonTextLabel.ZIndex = 2
BloxainButtonTextLabel.Font = Enum.Font.SourceSans
BloxainButtonTextLabel.Text = "Load Bloxain Hub"
BloxainButtonTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BloxainButtonTextLabel.TextScaled = true
BloxainButtonTextLabel.TextSize = 24.000
BloxainButtonTextLabel.TextWrapped = true

UITextSizeConstraint.Parent = BloxainButtonTextLabel
UITextSizeConstraint.MaxTextSize = 24

BloxianButton.MouseEnter:Connect(function()
	BloxianButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
end)

BloxianButton.MouseLeave:Connect(function()
	BloxianButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
end)

BloxianButton.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://github.com/bloxain/Roblox/raw/main/Bloxhub.Lua"))()
end)



local GameIdFrame = Instance.new("ImageButton")
local GameIdLable = Instance.new("TextLabel")
local GameIdButton = Instance.new("ImageButton")
local GameIDButtonTextLabel = Instance.new("TextLabel")
local UITextSizeConstraintV2 = Instance.new("UITextSizeConstraint")

if syn then
	syn.protect_gui(GameIdFrame)
end
--Properties:
workspace:IsA("ImageButton")
function Fix()
	local value = 0
	for i,v in pairs(game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView.PageViewInnerFrame.Page:GetChildren()) do
		if v:IsA("ImageButton") then
			value += v.Size.Y.Offset
		end
	end
	game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView.CanvasSize = UDim2.new(0, 0, 0, value)
	game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView.Changed:Connect(function()
		if game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView.PageViewInnerFrame.Page.Visible == true then
			game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView.CanvasSize = UDim2.new(0, 0, 0, value)
		end
	end)
end

GameIdFrame.Name = "Copy GameId"
GameIdFrame.Parent = game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView.PageViewInnerFrame:WaitForChild("Page")
GameIdFrame.Active = false
GameIdFrame.BackgroundTransparency = 1.000
GameIdFrame.BorderSizePixel = 0
GameIdFrame.LayoutOrder = 15
GameIdFrame.Position = UDim2.new(0, 0, 0, 550)
GameIdFrame.Selectable = false
GameIdFrame.SelectionImageObject = ImageLabel
GameIdFrame.Size = UDim2.new(1, 0, 0, 50)
GameIdFrame.ZIndex = 2
GameIdFrame.AutoButtonColor = false
GameIdFrame.Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png"
GameIdFrame.ImageColor3 = Color3.fromRGB(163, 162, 165)
GameIdFrame.ImageTransparency = 1.000
GameIdFrame.ScaleType = Enum.ScaleType.Slice
GameIdFrame.SliceCenter = Rect.new(10, 10, 10, 10)

GameIdLable.Name = "Developer ConsoleLabel"
GameIdLable.Parent = GameIdFrame
GameIdLable.BackgroundTransparency = 1.000
GameIdLable.Position = UDim2.new(0, 10, 0, 0)
GameIdLable.Size = UDim2.new(0, 200, 1, 0)
GameIdLable.ZIndex = 2
GameIdLable.Font = Enum.Font.SourceSansBold
GameIdLable.Text = "Copy GameId"
GameIdLable.TextColor3 = Color3.fromRGB(255, 255, 255)
GameIdLable.TextSize = 24.000
GameIdLable.TextXAlignment = Enum.TextXAlignment.Left

GameIdButton.Name = "DevConsoleButtonButton"
GameIdButton.Parent = GameIdFrame
GameIdButton.BackgroundTransparency = 1.000
GameIdButton.Position = UDim2.new(1, -400, 0, 12)
GameIdButton.SelectionImageObject = ImageLabel
GameIdButton.Size = UDim2.new(0, 300, 1, -20)
GameIdButton.ZIndex = 2
GameIdButton.AutoButtonColor = false
GameIdButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
GameIdButton.ScaleType = Enum.ScaleType.Slice
GameIdButton.SliceCenter = Rect.new(8, 6, 46, 44)

GameIDButtonTextLabel.Name = "DevConsoleButtonTextLabel"
GameIDButtonTextLabel.Parent = GameIdButton
GameIDButtonTextLabel.BackgroundTransparency = 1.000
GameIDButtonTextLabel.BorderSizePixel = 0
GameIDButtonTextLabel.Size = UDim2.new(1, 0, 1, -8)
GameIDButtonTextLabel.ZIndex = 2
GameIDButtonTextLabel.Font = Enum.Font.SourceSans
GameIDButtonTextLabel.Text = "Copy"
GameIDButtonTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
GameIDButtonTextLabel.TextScaled = true
GameIDButtonTextLabel.TextSize = 24.000
GameIDButtonTextLabel.TextWrapped = true

UITextSizeConstraintV2.Parent = GameIDButtonTextLabel
UITextSizeConstraintV2.MaxTextSize = 24


local AutoLunchFrame = Instance.new("ImageButton")
local AutoLunchscreenLabel = Instance.new("TextLabel")
local Selector = Instance.new("ImageButton")
local AutoSelectButton = Instance.new("ImageButton")
local AutoLaunchInfo = Instance.new("TextLabel")

if syn then
	syn.protect_gui(AutoLunchFrame)
end

AutoLunchFrame.Name = "AutoLunchFrame"
AutoLunchFrame.Parent = game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView.PageViewInnerFrame.Page
AutoLunchFrame.Active = false
AutoLunchFrame.BackgroundTransparency = 1.000
AutoLunchFrame.BorderSizePixel = 0
AutoLunchFrame.LayoutOrder = 8
AutoLunchFrame.Position = UDim2.new(0, 0, 0, 300)
AutoLunchFrame.Selectable = false
AutoLunchFrame.SelectionImageObject = ImageLabel
AutoLunchFrame.Size = UDim2.new(1, 0, 0, 50)
AutoLunchFrame.ZIndex = 2
AutoLunchFrame.AutoButtonColor = false
AutoLunchFrame.Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png"
AutoLunchFrame.ImageColor3 = Color3.fromRGB(163, 162, 165)
AutoLunchFrame.ImageTransparency = 1.000
AutoLunchFrame.ScaleType = Enum.ScaleType.Slice
AutoLunchFrame.SliceCenter = Rect.new(2, 2, 18, 18)

AutoLunchscreenLabel.Name = "AutoLunchscreenLabel"
AutoLunchscreenLabel.Parent = AutoLunchFrame
AutoLunchscreenLabel.BackgroundTransparency = 1.000
AutoLunchscreenLabel.Position = UDim2.new(0, 10, 0, 0)
AutoLunchscreenLabel.Size = UDim2.new(0, 200, 1, 0)
AutoLunchscreenLabel.ZIndex = 2
AutoLunchscreenLabel.Font = Enum.Font.SourceSansBold
AutoLunchscreenLabel.Text = "AutoLunch"
AutoLunchscreenLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoLunchscreenLabel.TextSize = 24.000
AutoLunchscreenLabel.TextXAlignment = Enum.TextXAlignment.Left

Selector.Name = "Selector"
Selector.Parent = AutoLunchFrame
Selector.AnchorPoint = Vector2.new(1, 0.5)
Selector.BackgroundTransparency = 1.000
Selector.Position = UDim2.new(1, 0, 0.5, 0)
Selector.SelectionImageObject = ImageLabel
Selector.Size = UDim2.new(0.600000024, 0, 0, 50)
Selector.ZIndex = 2
Selector.AutoButtonColor = false

AutoSelectButton.Name = "AutoSelectButton"
AutoSelectButton.Parent = Selector
AutoSelectButton.BackgroundTransparency = 1.000
AutoSelectButton.Position = UDim2.new(0, 50, 0, 0)
AutoSelectButton.Selectable = false
AutoSelectButton.SelectionImageObject = ImageLabel
AutoSelectButton.Size = UDim2.new(1, -100, 1, 0)
AutoSelectButton.ZIndex = 2

AutoLaunchInfo.Name = "AutoLaunchInfo"
AutoLaunchInfo.Parent = Selector
AutoLaunchInfo.BackgroundTransparency = 1.000
AutoLaunchInfo.BorderSizePixel = 0
AutoLaunchInfo.Position = UDim2.new(0, 50, 0, 0)
AutoLaunchInfo.Size = UDim2.new(1, -100, 1, 0)
AutoLaunchInfo.ZIndex = 2
AutoLaunchInfo.Font = Enum.Font.SourceSans
AutoLaunchInfo.Text = "Off"
AutoLaunchInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoLaunchInfo.TextSize = 24.000
AutoLaunchInfo.TextTransparency = 0.500


if AutoOn then
	AutoLaunchInfo.Text = "On"
end

function animate(text, amount, speed)
	local Basex = AutoLaunchInfo.Position.X.Offset
	local Appre = Basex + amount
	local tranamout = 1 / amount * speed
	AutoLaunchInfo.Text = text
	for i = 1, amount / speed do
		AutoLaunchInfo.Position = UDim2.new(0, Basex - i * speed, 0, 0)
		AutoLaunchInfo.TextTransparency += tranamout
		wait()
	end
	wait(0.2)
	for i = 1, amount/ speed do
		AutoLaunchInfo.Position = UDim2.new(0, Appre - i * speed, 0, 0)
		AutoLaunchInfo.TextTransparency -= tranamout
		wait()
	end
end


Fix()


GameIdButton.MouseEnter:Connect(function()
	GameIdButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
end)

GameIdButton.MouseLeave:Connect(function()
	GameIdButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
end)

GameIdButton.MouseButton1Click:Connect(function()
	setclipboard(game.GameId)
end)

AutoLunchFrame.MouseButton1Click:Connect(function()
	if AutoOn then
		animate("Off", 25, 8)
		ReadWrite(false, false)
		AutoOn = false
	else
		animate("On", 25, 8)
		ReadWrite(false, true)
		AutoOn = true
	end
end)

AutoSelectButton.MouseButton1Click:Connect(function()
	if AutoOn then
		animate("Off", 25, 8)
		ReadWrite(false, false)
		AutoOn = false
	else
		animate("On", 25, 8)
		ReadWrite(false, true)
		AutoOn = true
	end
end)

for i,v in pairs(game.CoreGui.RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView.PageViewInnerFrame.Page:GetChildren()) do
	if v:IsA("ImageButton") then
		v.MouseEnter:Connect(function()
			v.BackgroundTransparency = 0.5
		end)
		v.MouseLeave:Connect(function()
			v.BackgroundTransparency = 1
		end)
	end
end
