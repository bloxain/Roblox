function UI(Scripttxt, Name)
	local Choice = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local Bloxain = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local Script = Instance.new("TextLabel")
	local Run = Instance.new("TextButton")
	local Both = Instance.new("TextButton")
	local Other = Instance.new("Frame")
	local Title3rd = Instance.new("TextLabel")
	local Script3rd = Instance.new("TextLabel")
	local Run3rd = Instance.new("TextButton")
	local UiCorner = Instance.new("UICorner", Other)
	local UiCorner1 = Instance.new("UICorner", Bloxain)
	local UiCorner2 = Instance.new("UICorner", Run)
	local UiCorner3 = Instance.new("UICorner", Run3rd)
	local UiCorner4 = Instance.new("UICorner", Both)

	Choice.Name = "Choice"
	Choice.Parent = game.CoreGui
	Choice.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Main.Name = "Main"
	Main.Parent = Choice
	Main.BackgroundColor3 = Color3.new(1, 1, 1)
	Main.Position = UDim2.new(0.396800637, 0, 0.421862334, 0)
	Main.Size = UDim2.new(0.206398755, 0, 0.156275302, 0)
	Main.Transparency = 1

	Bloxain.Name = "Bloxain"
	Bloxain.Parent = Main
	Bloxain.BackgroundColor3 = Color3.new(0.258824, 0.258824, 0.258824)
	Bloxain.BorderColor3 = Color3.new(0.258824, 0.258824, 0.258824)
	Bloxain.Size = UDim2.new(0.378071845, 0, 1.03626943, 0)

	Title.Name = "Title"
	Title.Parent = Bloxain
	Title.BackgroundColor3 = Color3.new(1, 1, 1)
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(1, 0, 0.25, 0)
	Title.Font = Enum.Font.SourceSans
	Title.Text = "Bloxain"
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.TextScaled = true
	Title.TextSize = 14
	Title.TextWrapped = true

	Script.Name = "Script"
	Script.Parent = Bloxain
	Script.BackgroundColor3 = Color3.new(1, 1, 1)
	Script.BackgroundTransparency = 1
	Script.Position = UDim2.new(0, 0, 0.324999988, 0)
	Script.Size = UDim2.new(1, 0, 0.25, 0)
	Script.Font = Enum.Font.SourceSans
	Script.Text = "Universal Gui"
	Script.TextColor3 = Color3.new(1, 1, 1)
	Script.TextScaled = true
	Script.TextSize = 14
	Script.TextWrapped = true

	Run.Name = "Run"
	Run.Parent = Bloxain
	Run.BackgroundColor3 = Color3.new(1, 1, 1)
	Run.BackgroundTransparency = 0.8999999761581421
	Run.Position = UDim2.new(0, 0, 0.699999988, 0)
	Run.Size = UDim2.new(1, 0, 0.25, 0)
	Run.Font = Enum.Font.SourceSans
	Run.Text = "Run"
	Run.TextColor3 = Color3.new(1, 1, 1)
	Run.TextScaled = true
	Run.TextSize = 14
	Run.TextWrapped = true

	Both.Name = "Both"
	Both.Parent = Main
	Both.BackgroundColor3 = Color3.new(0.258824, 0.258824, 0.258824)
	Both.BorderSizePixel = 0
	Both.Position = UDim2.new(0.377638906, 0, 0.339097857, 0)
	Both.Size = UDim2.new(0.236294895, 0, 0.259067357, 0)
	Both.Font = Enum.Font.SourceSans
	Both.Text = "Both"
	Both.TextColor3 = Color3.new(1, 1, 1)
	Both.TextScaled = true
	Both.TextSize = 14
	Both.TextWrapped = true

	Other.Name = "Other"
	Other.Parent = Main
	Other.BackgroundColor3 = Color3.new(0.258824, 0.258824, 0.258824)
	Other.BorderColor3 = Color3.new(0.258824, 0.258824, 0.258824)
	Other.Position = UDim2.new(0.614451647, 0, -0.0207253881, 0)
	Other.Size = UDim2.new(0.378071845, 0, 1.03626943, 0)

	Title3rd.Name = "Title"
	Title3rd.Parent = Other
	Title3rd.BackgroundColor3 = Color3.new(1, 1, 1)
	Title3rd.BackgroundTransparency = 1
	Title3rd.Size = UDim2.new(1, 0, 0.25, 0)
	Title3rd.Font = Enum.Font.SourceSans
	Title3rd.Text = Name
	Title3rd.TextColor3 = Color3.new(1, 1, 1)
	Title3rd.TextScaled = true
	Title3rd.TextSize = 14
	Title3rd.TextWrapped = true

	Script3rd.Name = "Script"
	Script3rd.Parent = Other
	Script3rd.BackgroundColor3 = Color3.new(1, 1, 1)
	Script3rd.BackgroundTransparency = 1
	Script3rd.Position = UDim2.new(0, 0, 0.25, 0)
	Script3rd.Size = UDim2.new(1, 0, 0.449999988, 0)
	Script3rd.Font = Enum.Font.SourceSans
	Script3rd.Text = Scripttxt
	Script3rd.TextColor3 = Color3.new(1, 1, 1)
	Script3rd.TextScaled = true
	Script3rd.TextSize = 14
	Script3rd.TextWrapped = true

	Run3rd.Name = "Run"
	Run3rd.Parent = Other
	Run3rd.BackgroundColor3 = Color3.new(1, 1, 1)
	Run3rd.BackgroundTransparency = 0.8999999761581421
	Run3rd.Position = UDim2.new(0, 0, 0.699999988, 0)
	Run3rd.Size = UDim2.new(1, 0, 0.25, 0)
	Run3rd.Font = Enum.Font.SourceSans
	Run3rd.Text = "Run"
	Run3rd.TextColor3 = Color3.new(1, 1, 1)
	Run3rd.TextScaled = true
	Run3rd.TextSize = 14
	Run3rd.TextWrapped = true
	
	Both.MouseButton1Click:Connect(function()
		Choice:Destroy()
		loadstring(readfile("Bloxhub#7364/Universal_Gui.Lua"))()
		loadstring(game:HttpGet(Scripttxt))()
	end)
	Run.MouseButton1Click:Connect(function()
		Choice:Destroy()
		loadstring(readfile("Bloxhub#7364/Universal_Gui.Lua"))()
	end)
	Run3rd.MouseButton1Click:Connect(function()
		Choice:Destroy()
		loadstring(game:HttpGet(Scripttxt))()
	end)
end

function Run()
	local Games = {
		["911750776"] = "https://pastebin.com/raw/bFu2yg8n",
		["210851291"] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Build%20A%20Boat%20For%20Treasure/BABFT",
		["110181652"] = "https://raw.githubusercontent.com/SlamminPig/rblxgames/main/Epic%20Minigames/EpicMinigamesGUI",
		["279565647"] = "https://pastebin.com/raw/JbWJ7R7i",
		["601130232"] = "https://raw.githubusercontent.com/Boxking776/kocmoc/main/kocmoc-remastered.lua",
		["1659645941"] = "http://void-scripts.com/Scripts/islands_new.lua",
		["540856839"] = "https://drive.google.com/uc?export=download&id=1xeauG47nspgBlMKxXP304-NZHYwhIa53",
		["73885730"] = "https://pastebin.com/raw/mHfK0Xk4"
	}
	
	local GameNames = {
		["911750776"] = "Broken Bones",
		["210851291"] = "BABFT",
		["110181652"] = "Epic MiniGames",
		["279565647"] = "Lucky Blocks",
		["601130232"] = "Bee Swarm Simulator",
		["1659645941"] = "Ilands",
		["540856839"] = "Trueser Hunt",
		["73885730"] = "Prison Life Gui"
	}	

	local bloxain = {
		["2035583477"] = "Tower_Simulator.Lua",
		["781563604"] = "Destruction_Simulator.Lua",
		["703124385"] = "Tower_Of_Hell.Lua",
		["65241"] = "Natural_Disaster_Survival.Lua"
	}

	if bloxain[tostring(game.GameId)] then
		loadstring(readfile("Bloxhub#7364/"..bloxain[tostring(game.GameId)]))()
		return
	end

	if Games[tostring(game.GameId)] then
		UI(Games[tostring(game.GameId)], GameNames[tostring(game.GameId)])
		return
	end
	
	loadstring(readfile("Bloxhub#7364/Universal_Gui.Lua"))()
end

Run()
