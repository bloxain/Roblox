local Updater = {}
function Updater.Create ()
	Updater = Instance.new("Frame")
	Progress = Instance.new("TextLabel")
	Info = Instance.new("TextLabel")

	if syn then
		syn.protect_gui(Updater)
	end

	Updater.Name = "Updater"
	Updater.Parent = game.CoreGui.ThemeProvider.TopBarFrame.RightFrame
	Updater.BackgroundColor3 = Color3.new(0.258824, 0.258824, 0.258824)
	Updater.Position = UDim2.new(0.380385727, 0, 0.427475065, 0)
	Updater.Size = UDim2.new(0, 300, 0, 36)
	Updater.Visible = false

	Progress.Name = "Progress"
	Progress.Parent = Updater
	Progress.BackgroundColor3 = Color3.new(1, 1, 1)
	Progress.Size = UDim2.new(0, 0, 0, 36)
	Progress.Font = Enum.Font.SourceSans
	Progress.Text = ""
	Progress.TextColor3 = Color3.new(0, 0, 0)
	Progress.TextSize = 14

	Info.Name = "Info"
	Info.Parent = Updater
	Info.BackgroundColor3 = Color3.new(1, 1, 1)
	Info.BackgroundTransparency = 1
	Info.Size = UDim2.new(0, 308, 0, 36)
	Info.Font = Enum.Font.SourceSans
	Info.Text = "Updateing | 0%"
	Info.TextColor3 = Color3.new(1, 1, 1)
	Info.TextScaled = true
	Info.TextSize = 14
	Info.TextWrapped = true

	AddAmount = 0
	addAmount1 = 0
	NewSize = 0
	precent = 0
	title = ""
end

function Updater.Show (Text, Amount)
	addAmount1 = 100 / Amount
	AddAmount = 300 / Amount
	title = Text
	
	Info.Text = Text.." | 0%"
	Updater.Visible = true
end

function Updater.Update ()
	NewSize += addAmount1
	precent += addAmount1
	Progress.Size = UDim2.new(0, NewSize, 0, 36)
	Info.Text = title.." | %"..precent
end

function Updater.Hide ()
	AddAmount = 0
	addAmount1 = 0
	NewSize = 0
	Updater.Visible = false
	title = ""
	precent = 0
end
return Updater
