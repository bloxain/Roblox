local Updater = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Frame_2 = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local Info = Instance.new("TextLabel")

Updater.Name = "Updater"
Updater.Parent = game.CoreGui
Updater.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = Updater
Frame.BackgroundColor3 = Color3.new(0.266667, 0.266667, 0.266667)
Frame.Position = UDim2.new(0.429574698, 0, 0.431312352, 0)
Frame.Size = UDim2.new(0, 361, 0, 178)

Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0, 361, 0, 59)
Title.Font = Enum.Font.SourceSans
Title.Text = "Bloxain Hub Updater"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextScaled = true
Title.TextSize = 14
Title.TextWrapped = true

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.new(1, 1, 1)
Frame_2.BackgroundTransparency = 1
Frame_2.Position = UDim2.new(0.0193905812, 0, 0.415730357, 0)
Frame_2.Size = UDim2.new(0, 347, 0, 55)

UICorner.Parent = Frame

TextLabel.Parent = Frame_2
TextLabel.BackgroundColor3 = Color3.new(0.666667, 0.666667, 0)
TextLabel.Size = UDim2.new(0, 0, 0, 55)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = ""
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.TextSize = 14

UICorner_2.Parent = Frame_2
UICorner.CornerRadius = UDim.new(0.1, 8)

Info.Name = "Info"
Info.Parent = Frame
Info.BackgroundColor3 = Color3.new(1, 1, 1)
Info.BackgroundTransparency = 1
Info.Position = UDim2.new(0.221606642, 0, 0.724719107, 0)
Info.Size = UDim2.new(0, 200, 0, 28)
Info.Font = Enum.Font.SourceSans
Info.Text = "0/"
Info.TextColor3 = Color3.new(1, 1, 1)
Info.TextScaled = true
Info.TextSize = 14
Info.TextWrapped = true


local modules = 5
local Github = "https://github.com/bloxain/Roblox/raw/main/Games/"
local increment = 347 / modules
local temp = 0
local temp2 = 0
function updateUI()
	temp += 1
	temp2 += increment
	Info.Text = temp.."/"..modules
	TextLabel.Size = UDim2.new(0, temp2, 0, 55)
end

writefile("Bloxhub#7364/Tower_Of_Hell.Lua", game:HttpGet(Github.."T/Tower_Of_Hell.Lua"))
updateUI()
writefile("Bloxhub#7364/Destruction_Simulator.Lua", game:HttpGet(Github.."D/Destruction_Simulator.Lua"))
updateUI()
writefile("Bloxhub#7364/Tower_Simulator.Lua", game:HttpGet(Github.."T/Tower_Simulator.Lua"))
updateUI()
writefile("Bloxhub#7364/Universal_Gui.Lua", game:HttpGet("https://github.com/bloxain/Roblox/raw/main/Universal_Gui.Lua"))
updateUI()
writefile("Bloxhub#7364/Venyx_UI.Lua", game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Venyx_UI.Lua"))
updateUI()

Updater:Destroy()
