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
	task.wait(.1)
end

if not writefile then
	local Files = {}
	getgenv().writefile = function(path, data) Files[path] = data end
	getgenv().makefolder = function()  end
	getgenv().isfolder = function() return false  end
	getgenv().readfile = function(Path) return Files[Path]  end
	getgenv().delfolder = function()  end
end
local Github = _G.versoin[2]..'Games/'

Show(14)
if isfolder("BloxainHub") then
	if isfolder("BloxainHub/Saves") then
		moredata = {}
		for i, v in pairs(listfiles("BloxainHub/Saves")) do
			local add = {
				["Path"] = v,
				["Data"] = readfile(v)
			}

			table.insert(moredata, 1, add)
		end
	end
	delfolder("BloxainHub")
end
makefolder("BloxainHub")
Update()
makefolder("BloxainHub/Modules")
Update()
makefolder("BloxainHub/Saves")
Update()


writefile("BloxainHub/Tower_Of_Hell.Lua", game:HttpGet(Github.."T/Tower_Of_Hell.Lua"))
Update()
writefile("BloxainHub/Destruction_Simulator.Lua", game:HttpGet(Github.."D/Destruction_Simulator.Lua"))
Update()
writefile("BloxainHub/Tower_Simulator.Lua", game:HttpGet(Github.."T/Tower_Simulator.Lua"))
Update()
writefile("BloxainHub/Egg_Farm_Simulator.Lua", game:HttpGet(Github.."E/Egg_Farm_Simulator.Lua"))
Update()
writefile("BloxainHub/Universal_Gui.Lua", game:HttpGet(Github.."Universal_Gui.Lua"))
Update()
writefile("BloxainHub/cart_ride_around_used_car_battery.Lua", game:HttpGet(Github.."Games/C/cart_ride_around_used_car_battery.Lua"))
Update()
writefile("BloxainHub/Natural_Disaster_Survival.Lua", game:HttpGet(Github.."Games/N/Natural%20Disaster%20Survival.Lua"))
Update()
writefile("BloxainHub/Modules/UI.Lua", game:HttpGet(Github.."modules/UI.Lua"))
Update()
writefile("BloxainHub/Modules/GameFinder.Lua", game:HttpGet(Github.."modules/Game_Finder.Lua"))
Update()
writefile("BloxainHub/Modules/progressBar.lua", game:HttpGet(Github.."modules/progressBar.lua"))
Update()
writefile("BloxainHub/Modules/Main.Lua", game:HttpGet(Github.."modules/Main.Lua"))
Update()

if moredata then
	for i = 1, #moredata do
		writefile(moredata[i].Path, moredata[i].Data)
		print(moredata[i].Data)
	end
end

Updater:Destroy()
