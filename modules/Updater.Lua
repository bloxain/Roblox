-- GUI to Lua
-----
-- Version: 2.0.
-- Made by chrisopdemobiel.
-- Instances:
local LoaderV2 = Instance.new("ScreenGui")
local Basic_Loader = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Sliders = Instance.new("Frame")
local Fill = Instance.new("Frame")
local Versoin = Instance.new("TextLabel")
local Value = Instance.new("TextLabel")
local Settings = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title_2 = Instance.new("TextLabel")
local Footer = Instance.new("Frame")
local Install = Instance.new("TextLabel")
local Run = Instance.new("TextLabel")
local Info = Instance.new("Frame")
local Header = Instance.new("TextLabel")
local Content = Instance.new("TextLabel")
local Settings_Panel = Instance.new("Frame")
local Header_2 = Instance.new("TextLabel")
local Setting = Instance.new("Frame")
local Title_3 = Instance.new("TextLabel")
local Toggle_Dall = Instance.new("Frame")
local Outer = Instance.new("Frame")
local Details = Instance.new("TextLabel")
local Toggle_Dcurrent = Instance.new("Frame")
local Outer_2 = Instance.new("Frame")
local Details_2 = Instance.new("TextLabel")

--Properties:

LoaderV2.Name = "Loader V2"
LoaderV2.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
LoaderV2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Basic_Loader.Name = "Basic_Loader"
Basic_Loader.Parent = LoaderV2
Basic_Loader.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Basic_Loader.Position = UDim2.new(0.424, 0, -.1, 0)
Basic_Loader.Size = UDim2.new(0, 500, 0, 148)
Basic_Loader.Visible = false

Title.Name = "Title"
Title.Parent = Basic_Loader
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0.300000012, 0, 0, 0)
Title.Size = UDim2.new(0, 200, 0, 50)
Title.Font = Enum.Font.Unknown
Title.Text = "Installing..."
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 30.000
Title.TextWrapped = true

Sliders.Name = "Sliders"
Sliders.Parent = Basic_Loader
Sliders.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Sliders.BackgroundTransparency = 0.800
Sliders.Position = UDim2.new(0.0120000001, 0, 0.573648691, 0)
Sliders.Size = UDim2.new(0, 488, 0, 30)

Fill.Name = "Fill"
Fill.Parent = Sliders
Fill.BackgroundColor3 = Color3.fromRGB(0, 125, 0)
Fill.Size = UDim2.new(0, 0, 0, 30)

Versoin.Name = "Versoin"
Versoin.Parent = Basic_Loader
Versoin.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Versoin.BackgroundTransparency = 1.000
Versoin.Position = UDim2.new(0.300000012, 0, 0.337837845, 0)
Versoin.Size = UDim2.new(0, 200, 0, 25)
Versoin.Font = Enum.Font.Roboto
Versoin.Text = _G.versoin[1]
Versoin.TextColor3 = Color3.fromRGB(255, 255, 255)
Versoin.TextScaled = true
Versoin.TextSize = 14.000
Versoin.TextWrapped = true

Value.Name = "Value"
Value.Parent = Basic_Loader
Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Value.BackgroundTransparency = 1.000
Value.Position = UDim2.new(0.300000012, 0, 0.837000012, 0)
Value.Size = UDim2.new(0, 200, 0, 21)
Value.Font = Enum.Font.Roboto
Value.Text = "1/10 (10%)"
Value.TextColor3 = Color3.fromRGB(255, 255, 255)
Value.TextScaled = true
Value.TextSize = 14.000
Value.TextWrapped = true

Settings.Name = "Settings"
Settings.Parent = LoaderV2
Settings.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Settings.Position = UDim2.new(0.430, 0, -.1, 0)
Settings.Size = UDim2.new(0, 450, 0, 484)
Settings.Visible = false

TopBar.Name = "TopBar"
TopBar.Parent = Settings
TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TopBar.BackgroundTransparency = 1.000
TopBar.Size = UDim2.new(0, 450, 0, 50)

Title_2.Name = "Title"
Title_2.Parent = TopBar
Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_2.BackgroundTransparency = 1.000
Title_2.Position = UDim2.new(0.228222236, 0, 0, 0)
Title_2.Size = UDim2.new(0, 243, 0, 40)
Title_2.Font = Enum.Font.Unknown
Title_2.Text = "Install Settings"
Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_2.TextSize = 30.000
Title_2.TextWrapped = true

Footer.Name = "Footer"
Footer.Parent = Settings
Footer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Footer.BackgroundTransparency = 1.000
Footer.Position = UDim2.new(0, 0, 0, 425)
Footer.Size = UDim2.new(0, 450, 0, 50)

Install.Name = "Install"
Install.Parent = Footer
Install.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Install.BackgroundTransparency = 0.800
Install.ClipsDescendants = true
Install.Position = UDim2.new(0, 12, 0, 5)
Install.Size = UDim2.new(0, 188, 0, 40)
Install.Font = Enum.Font.Arial
Install.Text = "Install"
Install.TextColor3 = Color3.fromRGB(255, 255, 255)
Install.TextSize = 28.000
Install.TextWrapped = true

Run.Name = "Run"
Run.Parent = Footer
Run.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Run.BackgroundTransparency = 0.800
Run.Position = UDim2.new(0, 247, 0, 5)
Run.Size = UDim2.new(0, 188, 0, 40)
Run.Font = Enum.Font.Arial
Run.Text = "Run(Coming Soon)"
Run.TextColor3 = Color3.fromRGB(255, 255, 255)
Run.TextSize = 28.000
Run.TextWrapped = true

Info.Name = "Info"
Info.Parent = Settings
Info.BackgroundColor3 = Color3.fromRGB(0, 165, 0)
Info.BackgroundTransparency = 0.800
Info.Position = UDim2.new(0, 13, 0, 56)
Info.Size = UDim2.new(0, 424, 0, 122)

Header.Name = "Header"
Header.Parent = Info
Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Header.BackgroundTransparency = 1.000
Header.Position = UDim2.new(0.264150947, 0, 0, 0)
Header.Size = UDim2.new(0, 200, 0, 27)
Header.Font = Enum.Font.SourceSansBold
Header.Text = "Why Install?"
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.TextSize = 20.000

Content.Name = "Content"
Content.Parent = Header
Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Content.BackgroundTransparency = 1.000
Content.Position = UDim2.new(-0.560000002, 0, 1, 0)
Content.Size = UDim2.new(0, 424, 0, 95)
Content.Font = Enum.Font.SourceSans
Content.Text = [['It is recommend to install these files into your
workspace folder for the following reasons:
• near instant loading as the files dont have to read from the web
• easy to modify files to your likeing']]
Content.TextColor3 = Color3.fromRGB(255, 255, 255)
Content.TextSize = 19.000
Content.TextXAlignment = Enum.TextXAlignment.Left
Content.TextYAlignment = Enum.TextYAlignment.Top

Settings_Panel.Name = "Settings_Panel"
Settings_Panel.Parent = Settings
Settings_Panel.BackgroundColor3 = Color3.fromRGB(0, 165, 0)
Settings_Panel.BackgroundTransparency = 0.800
Settings_Panel.Position = UDim2.new(0, 12, 0, 192)
Settings_Panel.Size = UDim2.new(0, 424, 0, 216)

Header_2.Name = "Header"
Header_2.Parent = Settings_Panel
Header_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Header_2.BackgroundTransparency = 1.000
Header_2.Position = UDim2.new(0.264150947, 0, 0, 0)
Header_2.Size = UDim2.new(0, 200, 0, 27)
Header_2.Font = Enum.Font.SourceSansBold
Header_2.Text = "Settings"
Header_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Header_2.TextSize = 20.000

Setting.Name = "Setting"
Setting.Parent = Settings_Panel
Setting.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Setting.BackgroundTransparency = 0.800
Setting.Position = UDim2.new(0, 8, 0, 42)
Setting.Size = UDim2.new(0, 408, 0, 35)

Title_3.Name = "Title"
Title_3.Parent = Setting
Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_3.BackgroundTransparency = 1.000
Title_3.Position = UDim2.new(0.0147058824, 0, -0.0285714287, 0)
Title_3.Size = UDim2.new(0, 138, 0, 35)
Title_3.Font = Enum.Font.Ubuntu
Title_3.Text = "Install all scripts"
Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_3.TextSize = 20.000
Title_3.TextXAlignment = Enum.TextXAlignment.Left

Toggle_Dall.Name = "Toggle_Dall"
Toggle_Dall.Parent = Setting
Toggle_Dall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Dall.BackgroundTransparency = 1.000
Toggle_Dall.Position = UDim2.new(0.379901975, 0, 0, 0)
Toggle_Dall.Size = UDim2.new(0, 73, 0, 35)

Outer.Name = "Outer"
Outer.Parent = Toggle_Dall
Outer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Outer.BorderSizePixel = 0
Outer.Position = UDim2.new(0.0349650346, 0, 0.200000003, 0)
Outer.Size = UDim2.new(0, 20, 0, 20)

Details.Name = "Details"
Details.Parent = Toggle_Dall
Details.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Details.BackgroundTransparency = 1.000
Details.Position = UDim2.new(0.512309074, 0, 0.200000003, 0)
Details.Size = UDim2.new(0, 23, 0, 21)
Details.Font = Enum.Font.Ubuntu
Details.Text = "All"
Details.TextColor3 = Color3.fromRGB(255, 255, 255)
Details.TextSize = 14.000
Details.TextXAlignment = Enum.TextXAlignment.Left

Toggle_Dcurrent.Name = "Toggle_Dcurrent"
Toggle_Dcurrent.Parent = Setting
Toggle_Dcurrent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Dcurrent.BackgroundTransparency = 1.000
Toggle_Dcurrent.Position = UDim2.new(0.664215684, 0, 0, 0)
Toggle_Dcurrent.Size = UDim2.new(0, 73, 0, 35)

Outer_2.Name = "Outer"
Outer_2.Parent = Toggle_Dcurrent
Outer_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Outer_2.BorderSizePixel = 0
Outer_2.Position = UDim2.new(0.0349650346, 0, 0.200000003, 0)
Outer_2.Size = UDim2.new(0, 20, 0, 20)

Details_2.Name = "Details"
Details_2.Parent = Toggle_Dcurrent
Details_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Details_2.BackgroundTransparency = 1.000
Details_2.Position = UDim2.new(0.512309074, 0, 0.200000003, 0)
Details_2.Size = UDim2.new(0, 23, 0, 21)
Details_2.Font = Enum.Font.Ubuntu
Details_2.Text = "Current"
Details_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Details_2.TextSize = 14.000
Details_2.TextXAlignment = Enum.TextXAlignment.Left

Instance.new('UICorner', Basic_Loader)
Instance.new('UICorner', Sliders)
Instance.new('UICorner', File)
Instance.new('UICorner', Settings)
Instance.new('UICorner', Info)
Instance.new('UICorner', Run)
Instance.new('UICorner', Info).CornerRadius = UDim.new(0, 10)
Instance.new('UICorner', Settings_Panel).CornerRadius = UDim.new(0, 10)
Instance.new('UICorner', Setting)
Instance.new('UICorner', Outer).CornerRadius = UDim.new(0, 5)
Instance.new('UICorner', Outer_2)

local TweenSevice = game.TweenService

if isfolder and isfolder("BloxainHub") then
	Title.Text = 'Updating...'
	if isfolder("BloxainHub/Saves") then
		Used = true
	else
		makefolder("BloxainHub/Saves")
		makefolder("BloxainHub/Modules")
	end
elseif isfolder then
	makefolder("BloxainHub")
	makefolder("BloxainHub/Saves")
	makefolder("BloxainHub/Modules")
else
	return
		-- When Run works we will add this
end

local Games = {
	["2035583477"] = {'T/Tower_Simulator.Lua', 'BloxainHub/Tower_Simulator.Lua'},
	["781563604"] = {'D/Destruction_Simulator.Lua', 'BloxainHub/Destruction_Simulator.Lua'},
	["703124385"] = {'T/Tower_Of_Hell.Lua', 'BloxainHub/Tower_Of_Hell.Lua'},
	["668582985"] = {'E/Egg_Farm_Simulator.Lua', 'BloxainHub/Egg_Farm_Simulator.Lua'},
	["65241"] = {'N/Natural%20Disaster%20Survival.Lua', 'BloxainHub/Natural_Disaster_Survival.Lua'},
	["2891148074"] = {'C/cart_ride_around_used_car_battery.Lua', 'BloxainHub/cart_ride_around_used_car_battery.Lua'},
	["3321455016"] = {'T/Tapping_Legends_X.Lua', 'BloxainHub/Tapping_Legends_X.Lua'},
	["2327642508"] = {'L/Laundry_Simulator.Lua', 'BloxainHub/Laundry_Simulator.Lua'}
}

local Modules = {
	['UI'] = {'modules/UI.Lua', 'BloxainHub/Modules/UI.Lua'},
	['Loader'] = {'modules/Game_Finder.Lua', 'BloxainHub/Modules/GameFinder.Lua'},
	['Main_Module'] = {'modules/Main.Lua', 'BloxainHub/Modules/Main.Lua'},
	["Universal"] = {'Universal_Gui.Lua', 'BloxainHub/Universal_Gui.Lua'}
}

local function Round(number, idk)
	if not idk then
		idk	= 1
	end
	number = number / idk
	local decimal = number - math.floor(number)
	if decimal >= .5 then
		return math.ceil(number) * idk
	else
		return math.floor(number) * idk
	end
end

local function Show(Number)
	local Progress_settings = {Total = Number, Move_Amount = Sliders.Size.X.Offset / Number, Done = 0, Done_Fill = 0}
	Value.Text = Progress_settings.Done..'/'..Number..' {0%)'
	Basic_Loader.Visible = true
	TweenSevice:Create(Basic_Loader, TweenInfo.new(.2, Enum.EasingStyle.Back), {Position = UDim2.fromScale(0.424, 0.458)}):Play()
	local Funcs = {}
	function Funcs:Update()
		Progress_settings.Done_Fill += Progress_settings.Move_Amount
		Progress_settings.Done += 1
		Value.Text = Progress_settings.Done..'/'..Number..' ('..Round((100 / Number) * Progress_settings.Done)..'%)'
		TweenSevice:Create(Fill, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(Progress_settings.Done_Fill, 30)}):Play()
	end
	return Funcs
end

local function GetTableLen(Table)
	local max = 0
	for i, _ in next, Table do
		max += 1
	end
	return max
end

local function Update()
	local content = game.HttpService:JSONDecode(readfile('BloxainHub/Saves/Gobal.txt'))
	local Github = _G.versoin[2]..'Games/'
	if content['Install_All'] then
		local ProgressUI = Show((GetTableLen(Games) + GetTableLen(Modules)))
		for _, v in next, Games do
			writefile(v[2], game:HttpGet(Github..v[1]))
			ProgressUI:Update()
		end
		for _, v in next, Modules do
			writefile(v[2], game:HttpGet(_G.versoin[2]..v[1]))
			ProgressUI:Update()
		end
		writefile("BloxainHub/Modules/Versoin.lua", _G.versoin[1])
		ProgressUI:Update()
	else
		if isfile('BloxainHub/Modules/Versoin.lua') and readfile('BloxainHub/Modules/Versoin.lua') == _G.versoin[1] then
			local ProgressUI = Show(1)
			local GameToRun = Games[tostring(game.GameId)]
			if GameToRun then
				writefile(GameToRun[2], game:HttpGet(Github..GameToRun[1]))
				ProgressUI:Update()
			end
		else
			local ProgressUI = Show(GetTableLen(Modules) + 1)
			for _, v in next, Modules do
				writefile(v[2], game:HttpGet(_G.versoin[2]..v[1]))
				ProgressUI:Update()
			end
			local GameToRun = Games[tostring(game.GameId)]
			if GameToRun then
				writefile(GameToRun[2], game:HttpGet(Github..GameToRun[1]))
				ProgressUI:Update()
			end
			writefile("BloxainHub/Modules/Versoin.lua", _G.versoin[1])
			ProgressUI:Update()
		end
	end
	TweenSevice:Create(Basic_Loader, TweenInfo.new(.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.424, 1)}):Play()
	task.wait(.2)
	LoaderV2:Destroy()
end

if Used and isfile('BloxainHub/Saves/Gobal.txt') then
	Update()
	return
else
	Settings.Visible = true
	TweenSevice:Create(Settings, TweenInfo.new(.2, Enum.EasingStyle.Back), {Position = UDim2.fromScale(0.43, 0.362)}):Play()
end


local StartLoad = true
local InstallAll = false

Toggle_Dall.InputBegan:Connect(function(key)
	if key.UserInputType == Enum.UserInputType.MouseButton1 then
		InstallAll = true
		Outer.BackgroundColor3 = Color3.new(255, 255, 255)
		Outer_2.BackgroundColor3 = Color3.new(0, 0, 0)
	end
end)

Toggle_Dcurrent.InputBegan:Connect(function(key)
	if key.UserInputType == Enum.UserInputType.MouseButton1 then
		InstallAll = false
		Outer_2.BackgroundColor3 = Color3.new(255, 255, 255)
		Outer.BackgroundColor3 = Color3.new(0, 0, 0)
	end
end)

Install.InputBegan:Connect(function(key)
	if key.UserInputType == Enum.UserInputType.MouseButton1 then
		writefile('BloxainHub/Saves/Gobal.txt', game.HttpService:JSONEncode({Install_All = InstallAll}))
		spawn(function()
			TweenSevice:Create(Settings, TweenInfo.new(.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.43, 1)}):Play()
		end)
		Update()
	end
end)

while StartLoad do -- Stops the script from tring to load when changeing settings
	task.wait(.3)
end
