Updater = Instance.new("Frame")
Progress = Instance.new("TextLabel")
Info = Instance.new("TextLabel")
local Round1 = Instance.new("UICorner")
local Round2 = Instance.new("UICorner")

if syn then
	syn.protect_gui(Updater)
end

Updater.Name = "Updater"
Updater.Parent = game.CoreGui.ThemeProvider.TopBarFrame.RightFrame
Updater.BackgroundColor3 = Color3.new(0.258824, 0.258824, 0.258824)
Updater.Position = UDim2.new(0.380385727, 0, 0.427475065, 0)
Updater.Size = UDim2.new(0, 300, 0, 36)
Updater.Visible = false
Round1.Parent = Updater

Progress.Name = "Progress"
Progress.Parent = Updater
Progress.BackgroundColor3 = Color3.fromRGB(170, 170, 0)
Progress.Size = UDim2.new(0, 0, 0, 36)
Progress.Font = Enum.Font.SourceSans
Progress.Text = ""
Progress.TextColor3 = Color3.new(0, 0, 0)
Progress.TextSize = 14
Round2.Parent = Progress

Info.Name = "Info"
Info.Parent = Updater
Info.BackgroundColor3 = Color3.new(1, 1, 1)
Info.BackgroundTransparency = 1
Info.Size = UDim2.new(0, 308, 0, 36)
Info.Font = Enum.Font.SourceSans
Info.Text = "Updateing... | 0%"
Info.TextColor3 = Color3.new(1, 1, 1)
Info.TextScaled = true
Info.TextSize = 14
Info.TextWrapped = true

AddAmount = 0
AddAmount1 = 0
NewSize = 0
precent = 0
title = ""

function Show(Amount)
	AddAmount1 = 100 / Amount
	AddAmount = 300 / Amount
	Updater.Visible = true
end

function Update()
	NewSize += AddAmount
	precent += AddAmount1
	Progress.Size = UDim2.new(0, NewSize, 0, 36)
	Info.Text = title.." | %"..math.floor(precent * 20 + 0.5)/20
end

local Github = "https://github.com/bloxain/Roblox/raw/main/Games/"

Show(14)
if isfolder("Bloxhub#7364") then
	if isfolder("Bloxhub#7364/Saves") then
		moredata = {}
		for i, v in pairs(listfiles("Bloxhub#7364/Saves")) do
			local add = {
				["Path"] = v,
				["Data"] = readfile(v)
			}

			table.insert(moredata, 1, add)
		end
	end
	delfolder("Bloxhub#7364")
end
makefolder("Bloxhub#7364")
Update()
makefolder("Bloxhub#7364/Modules")
Update()
makefolder("Bloxhub#7364/Saves")
Update()


writefile("Bloxhub#7364/Tower_Of_Hell.Lua", game:HttpGet(Github.."T/Tower_Of_Hell.Lua"))
Update()
writefile("Bloxhub#7364/Destruction_Simulator.Lua", game:HttpGet(Github.."D/Destruction_Simulator.Lua"))
Update()
writefile("Bloxhub#7364/Tower_Simulator.Lua", game:HttpGet(Github.."T/Tower_Simulator.Lua"))
Update()
writefile("Bloxhub#7364/Egg_Farm_Simulator.Lua", game:HttpGet(Github.."E/Egg_Farm_Simulator.Lua"))
Update()
writefile("Bloxhub#7364/Universal_Gui.Lua", game:HttpGet("https://github.com/bloxain/Roblox/raw/main/Universal_Gui.Lua"))
Update()
writefile("Bloxhub#7364/cart_ride_around_used_car_battery.Lua", game:HttpGet("https://github.com/bloxain/Roblox/raw/main/Games/C/cart_ride_around_used_car_battery.Lua"))
Update()
writefile("Bloxhub#7364/Natural_Disaster_Survival.Lua", game:HttpGet("https://github.com/bloxain/Roblox/raw/main/Games/N/Natural%20Disaster%20Survival.Lua"))
Update()
writefile("Bloxhub#7364/Venyx_UI.Lua", game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Venyx_UI.Lua"))
Update()
writefile("Bloxhub#7364/Modules/GameFinder.Lua", game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Game_Finder.Lua"))
Update()
writefile("Bloxhub#7364/Modules/progressBar.lua", game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/progressBar.lua"))
Update()
writefile("Bloxhub#7364/Modules/Main.Lua", game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Main.Lua"))
Update()

if moredata then
	for i = 1, #moredata do
		writefile(moredata[i].Path, moredata[i].Data)
		print(moredata[i].Data)
	end
end

Updater:Destroy()
