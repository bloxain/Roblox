local scripttoRun = nil
-- GUI to Lua
-----
-- Version: 2.0.
-- Made by chrisopdemobiel.

-- Instances:

local PickScript = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Ad = Instance.new("TextLabel")
local Discord = Instance.new("TextButton")
local Scripts = Instance.new("ScrollingFrame")
local Desc = Instance.new("TextLabel")
local TextLabel = Instance.new("TextLabel")
local Youtube = Instance.new("TextButton")
local TextButton = Instance.new("TextButton")
local Close = Instance.new("TextButton")
local ListLayout = Instance.new("UIListLayout")

if syn then
	syn.protect_gui(PickScript)
end

Instance.new("UICorner", MainFrame)
Instance.new("UICorner", Close)

--Properties:

PickScript.Name = "PickScript"
PickScript.Parent = game.CoreGui
PickScript.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = PickScript
MainFrame.BackgroundColor3 = Color3.fromRGB(99, 99, 99)
MainFrame.Position = UDim2.new(0.3656542, 0, 0.313317955, 0)
MainFrame.Size = UDim2.new(0, 689, 0, 485)

Ad.Name = "Ad"
Ad.Parent = MainFrame
Ad.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Ad.BackgroundTransparency = 1.000
Ad.Size = UDim2.new(0, 201, 0, 54)
Ad.Font = Enum.Font.Ubuntu
Ad.Text = "Bloxain"
Ad.TextColor3 = Color3.fromRGB(255, 255, 255)
Ad.TextScaled = true
Ad.TextSize = 14.000
Ad.TextWrapped = true

Discord.Name = "Discord"
Discord.Parent = MainFrame
Discord.BackgroundColor3 = Color3.fromRGB(170, 85, 255)
Discord.BackgroundTransparency = 1.000
Discord.Position = UDim2.new(0.0420899838, 0, 0.89690721, 0)
Discord.Size = UDim2.new(0, 115, 0, 43)
Discord.Font = Enum.Font.SourceSansSemibold
Discord.Text = "Discord"
Discord.TextColor3 = Color3.fromRGB(170, 0, 255)
Discord.TextScaled = true
Discord.TextSize = 14.000
Discord.TextWrapped = true

Scripts.Name = "Scripts"
Scripts.Parent = MainFrame
Scripts.Active = true
Scripts.BackgroundColor3 = Color3.fromRGB(111, 111, 111)
Scripts.Position = UDim2.new(0.0319303349, 0, 0.177319586, 0)
Scripts.Size = UDim2.new(0, 241, 0, 326)

Desc.Name = "Desc"
Desc.Parent = MainFrame
Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Desc.BackgroundTransparency = 1.000
Desc.Position = UDim2.new(0.454281569, 0, 0.265979379, 0)
Desc.Size = UDim2.new(0, 350, 0, 283)
Desc.Font = Enum.Font.SourceSans
Desc.Text = "Welcome to bloxain please choose a script to execute."
Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
Desc.TextSize = 25.000
Desc.TextWrapped = true
Desc.TextXAlignment = Enum.TextXAlignment.Left
Desc.TextYAlignment = Enum.TextYAlignment.Top

TextLabel.Parent = MainFrame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.563134968, 0, 0.164948449, 0)
TextLabel.Size = UDim2.new(0, 200, 0, 49)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

Youtube.Name = "Youtube"
Youtube.Parent = MainFrame
Youtube.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
Youtube.BackgroundTransparency = 1.000
Youtube.Position = UDim2.new(0.243831635, 0, 0.89690721, 0)
Youtube.Size = UDim2.new(0, 133, 0, 43)
Youtube.Font = Enum.Font.SourceSansSemibold
Youtube.Text = "Youtube"
Youtube.TextColor3 = Color3.fromRGB(255, 0, 4)
Youtube.TextScaled = true
Youtube.TextSize = 14.000
Youtube.TextWrapped = true

TextButton.Parent = MainFrame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 1.000
TextButton.Position = UDim2.new(0.563134968, 0, 0.793814421, 0)
TextButton.Size = UDim2.new(0, 200, 0, 50)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "Run Script"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextScaled = true
TextButton.TextSize = 14.000
TextButton.TextWrapped = true

Close.Name = "Close"
Close.Parent = MainFrame
Close.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
Close.Position = UDim2.new(0.92071259, 0, 0.0215463787, 0)
Close.Size = UDim2.new(0, 43, 0, 43)
Close.Font = Enum.Font.SourceSans
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextScaled = true
Close.TextSize = 14.000
Close.TextWrapped = true

ListLayout.Name = "ListLayout"
ListLayout.Parent = Scripts
ListLayout.Padding = UDim.new(0, 5)


function CreateScript(scripttt, Name, Descc)
	local Scriptt = Instance.new("TextButton")
	Instance.new("UICorner", Scriptt)
	Scriptt.Name = Name
	Scriptt.Parent = Scripts
	Scriptt.BackgroundColor3 = Color3.fromRGB(136, 136, 136)
	Scriptt.Size = UDim2.new(0, 225, 0, 43)
	Scriptt.Font = Enum.Font.SourceSans
	Scriptt.Text = Name
	Scriptt.TextColor3 = Color3.fromRGB(255, 255, 255)
	Scriptt.TextScaled = true
	Scriptt.TextSize = 14.000
	Scriptt.TextWrapped = true

	Scriptt.MouseButton1Click:Connect(function()
		TextLabel.Text = Name
		Desc.Text = Descc
		scripttoRun = scripttt
	end)
end

local Games = {
	["911750776"] = {false, false, "Broken Bonesl", "A script for Broken Bones with inf money(thats all i use it for) once pressed end the round", "https://pastebin.com/raw/bFu2yg8n"},
	["210851291"] = {false, false, "BABFT", "This Script has autofarm teamchanging godmode and more its better than anything i could do so i put it here", "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Build%20A%20Boat%20For%20Treasure/BABFT"},
	["110181652"] = {false, false, "Epic MiniGames", "this script can cheat almost all the minigames and it very usefull becuse it is not a cheaply Gui and had some fetures(works with universal Gui For Extra Fetures", "https://raw.githubusercontent.com/SlamminPig/rblxgames/main/Epic%20Minigames/EpicMinigamesGUI"},
	["279565647"] = {false, false, "Lucky Blocks", "Very good script has many combat fetures amd the ablity to crash the server you Can also open many blocks very fast to find a spicfic iteml", "https://pastebin.com/raw/JbWJ7R7i"},
	["601130232"] = {false, false, "Bee Swarm Simulator", "Sent by someone idk what it dose", "https://raw.githubusercontent.com/Boxking776/kocmoc/main/kocmoc-remastered.lua"},
	["1659645941"] = {false, false, "Ilands", "PACKED with feture teleports autofarm crop farming building bow aimbot selling buying clearing junk and is overall packed with fetures", "http://void-scripts.com/Scripts/islands_new.lua"},
	["540856839"] = {false, false, "Trueser Hunt", "idk sent by someone", "https://drive.google.com/uc?export=download&id=1xeauG47nspgBlMKxXP304-NZHYwhIa53"},
	["73885730"] = {false, false, "Prison Life Gui", "Gun modding, anti arrest, anti tase, anti(everything basicly), kill all and more", "https://pastebin.com/raw/mHfK0Xk4"},
	["2035583477"] = {true, true, "Tower Simulator", "MADE BY ME (bad update speed) auto build, inf jump and more", "Tower_Simulator.Lua"},
	["781563604"] = {true, true, "Destruction Simulator", "MADE BY ME inf coins, instant rocket, spam bombs and rockets, get levels, noclip, inf jump, more", "Destruction_Simulator.Lua"},
	["703124385"] = {true, true, "Tower Of Hell", "MADE BY ME autofarm, Tp to top, Tp player, infjump, give all gears, no clip, stop time, anti all bad mutators and more", "Tower_Of_Hell.Lua"},
	["668582985"] = {true, true, "Egg Farm Simulator", "MADE BY ME", "everything my script have plus autofarm get daimonds faster kill and more", "Egg_Farm_Simulator.Lua"},
	["65241"] = {true, true, "Natural Disaster Survival", "autofarm anti anoyying screens no cloud FE script", "Natural_Disaster_Survival.Lua"},
	["-1"] = {true, false, "Universal Gui", "i make all script with this as a base so it has many bloxain funcs", "Universal_Gui.Lua"}
}

local GamesArrary = {
	{911750776, false, false, "Broken Bonesl", "A script for Broken Bones with inf money(thats all i use it for) once pressed end the round", "https://pastebin.com/raw/bFu2yg8n"},
	{210851291, false, false, "BABFT", "This Script has autofarm teamchanging godmode and more its better than anything i could do so i put it here", "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Build%20A%20Boat%20For%20Treasure/BABFT"},
	{110181652, false, false, "Epic MiniGames", "this script can cheat almost all the minigames and it very usefull becuse it is not a cheaply Gui and had some fetures(works with universal Gui For Extra Fetures", "https://raw.githubusercontent.com/SlamminPig/rblxgames/main/Epic%20Minigames/EpicMinigamesGUI"},
	{279565647, false, false, "Lucky Blocks", "Very good script has many combat fetures amd the ablity to crash the server you Can also open many blocks very fast to find a spicfic iteml", "https://pastebin.com/raw/JbWJ7R7i"},
	{601130232, false, false, "Bee Swarm Simulator", "Sent by someone idk what it dose", "https://raw.githubusercontent.com/Boxking776/kocmoc/main/kocmoc-remastered.lua"},
	{1659645941, false, false, "Ilands", "PACKED with feture teleports autofarm crop farming building bow aimbot selling buying clearing junk and is overall packed with fetures", "http://void-scripts.com/Scripts/islands_new.lua"},
	{540856839, false, false, "Trueser Hunt", "idk sent by someone", "https://drive.google.com/uc?export=download&id=1xeauG47nspgBlMKxXP304-NZHYwhIa53"},
	{73885730, false, false, "Prison Life Gui", "Gun modding, anti arrest, anti tase, anti(everything basicly), kill all and more", "https://pastebin.com/raw/mHfK0Xk4"},
	{2035583477, true, true, "Tower Simulator", "MADE BY ME (bad update speed) auto build, inf jump and more", "Tower_Simulator.Lua"},
	{781563604, true, true, "Destruction Simulator", "MADE BY ME inf coins, instant rocket, spam bombs and rockets, get levels, noclip, inf jump, more", "Destruction_Simulator.Lua"},
	{703124385, true, true, "Tower Of Hell", "MADE BY ME autofarm, Tp to top, Tp player, infjump, give all gears, no clip, stop time, anti all bad mutators and more", "Tower_Of_Hell.Lua"},
	{668582985, true, true, "Egg Farm Simulator", "MADE BY ME", "everything my script have plus autofarm get daimonds faster kill and more", "Egg_Farm_Simulator.Lua"},
	{65241, true, true, "Natural Disaster Survival", "autofarm anti anoyying screens no cloud FE script", "Natural_Disaster_Survival.Lua"},
	{-1, true, false, "Universal Gui", "i make all script with this as a base so it has many bloxain funcs", "Universal_Gui.Lua"}
}


function Run()
	for i= 1, #GamesArrary do
		local temp = GamesArrary[i]
		if temp[1] == game.GameId then
		
			if temp[2] and temp[3] then
				PickScript:Destroy()
				loadstring(readfile("Bloxhub#7364/"..temp[7]))()
				return
			end
			if temp[3] == false then
				CreateScript(GamesArrary[i], temp[4], temp[5])
				CreateScript(-1, "Universal Gui", "i made all my script with this as a base so it has many bloxain funcs")
				return
			end
		end
	end
	PickScript:Destroy()
	loadstring(readfile("Bloxhub#7364/Universal_Gui.Lua"))()
end

Run()    

Close.MouseButton1Click:Connect(function()
	MainFrame:TweenPosition(UDim2.new(0.3656542, 0, 1, 0))
	wait(1)
	PickScript:Destroy()
end)


TextButton.MouseButton1Click:Connect(function()
	local temp = scripttoRun
	if temp[2] then
		loadstring(readfile("Bloxhub#7364/"..temp[6]))()
	else
		loadstring(game:HttpGet(temp[6]))()
	end
end)

Discord.MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/HDAEMyB7")
	Ad.Text = "Copyed!"
	wait(1)
	Ad.Text = "Bloxain"
end)

Youtube.MouseButton1Click:Connect(function()
	setclipboard("https://www.youtube.com/channel/UC8gfw9LhBjGurH7RL5e46RQ")
	Ad.Text = "Copyed!"
	wait(1)
	Ad.Text = "Bloxain"
end) 
