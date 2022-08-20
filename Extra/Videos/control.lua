_G.STOPALTCONTROL = true
local Settings = {
	Pass = 'YourPassword';
	Port = '7963'
}

-- GUI to Lua
-----
-- Version: 2.0.
-- Made by chrisopdemobiel.

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local UI = Instance.new("Frame")
local accounts = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local Join = Instance.new("TextButton")
local MiniMize = Instance.new("TextButton")
local Cmds = Instance.new("TextLabel")
local Run = Instance.new("TextButton")
local TextBox = Instance.new("TextBox")

--Properties:

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

UI.Name = "UI"
UI.Parent = ScreenGui
UI.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
UI.Position = UDim2.new(0.41366908, 0, 0.362227321, 0)
UI.Size = UDim2.new(0.172362104, 0, 0.274971306, 0)

accounts.Name = "accounts"
accounts.Parent = UI
accounts.Active = true
accounts.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
accounts.Position = UDim2.new(0, 0, 0.03125, 0)
accounts.Size = UDim2.new(0.465181053, 0, 0.830000005, 0)
accounts.CanvasSize = UDim2.new(0, 0, 20, 0)

UIListLayout.Parent = accounts
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 7)

Join.Name = "Join"
Join.Parent = UI
Join.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Join.BackgroundTransparency = 0.900
Join.Position = UDim2.new(-0.004, 0, 0.88, 0)
Join.Size = UDim2.new(0.225, 0, 0.061, 0)
Join.Font = Enum.Font.SourceSans
Join.Text = "Join"
Join.TextColor3 = Color3.fromRGB(255, 255, 255)
Join.TextScaled = true
Join.TextSize = 14.000
Join.TextWrapped = true

MiniMize.Name = "-"
MiniMize.Parent = UI
MiniMize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MiniMize.BackgroundTransparency = 0.900
MiniMize.Position = UDim2.new(-0.004, 0, 0.941, 0)
MiniMize.Size = UDim2.new(0.225, 0, 0.061, 0)
MiniMize.Font = Enum.Font.SourceSans
MiniMize.Text = "-"
MiniMize.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniMize.TextScaled = true
MiniMize.TextSize = 14.000
MiniMize.TextWrapped = true

Cmds.Name = "Cmds"
Cmds.Parent = UI
Cmds.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Cmds.BackgroundTransparency = 0.900
Cmds.Position = UDim2.new(0.465787411, 0, 0, 0)
Cmds.Size = UDim2.new(0.536211669, 0, 0.882499993, 0)
Cmds.Font = Enum.Font.SourceSans
Cmds.Text = [["Cmds
- Chat[text] | makes all accounts chat a message at once
- Kill[account / All] | Kills a connected all acount
- walk[] | makes all accounts walk to you Will not avoid walls
- SWalk[] | makes all accounts walk to you Will avoid walls
- TP[] | makes all accounts Teleport to you 
- Fps[number] | set max fps and dissables rendering(uses Nexus)
- Jump[] | Makes all accounts Jump
- Stop[] | Makes all accounts leave the game
- vol[number] | sets volume of all accounts
- follow[] | makes all accounts follow you
"]]
Cmds.TextColor3 = Color3.fromRGB(255, 255, 255)
Cmds.TextSize = 14
Cmds.TextXAlignment = Enum.TextXAlignment.Left
Cmds.TextYAlignment = Enum.TextYAlignment.Top

Run.Name = "Run"
Run.Parent = UI
Run.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Run.BackgroundTransparency = 0.900
Run.Position = UDim2.new(0.782128453, 0, 0.882499993, 0)
Run.Size = UDim2.new(0.216591984, 0, 0.1175, 0)
Run.Font = Enum.Font.SourceSans
Run.Text = "Run Cmd"
Run.TextColor3 = Color3.fromRGB(255, 255, 255)
Run.TextScaled = true
Run.TextSize = 14.000
Run.TextWrapped = true

TextBox.Parent = UI
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 0.900
TextBox.Position = UDim2.new(0.233, 0, 0.887, 0)
TextBox.Size = UDim2.new(0.532, 0, 0.118, 0)
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderText = "Kill all"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.TextScaled = true
TextBox.TextSize = 14.000
TextBox.TextWrapped = true

------------

local smallScreen = Instance.new("ScreenGui")
local SmallFrame = Instance.new("Frame")
local CMDSS = Instance.new("TextBox")
local RunCMDSS = Instance.new("TextButton")
local Maximize = Instance.new("TextButton")


Maximize.Name = "Maximize"
Maximize.Parent = SmallFrame
Maximize.BackgroundColor3 = Color3.fromRGB(83, 83, 83)
Maximize.Position = UDim2.new(1, 0, 0, 0)
Maximize.Size = UDim2.new(0.220858902, 0, 1, 0)
Maximize.Font = Enum.Font.SourceSans
Maximize.Text = "+"
Maximize.TextColor3 = Color3.fromRGB(255, 255, 255)
Maximize.TextScaled = true
Maximize.TextSize = 14.000
Maximize.TextWrapped = true

smallScreen.Name = "smallScreen"
smallScreen.Parent = game.CoreGui
smallScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
smallScreen.Enabled = false

SmallFrame.Name = "SmallFrame"
SmallFrame.Parent = smallScreen
SmallFrame.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
SmallFrame.Position = UDim2.new(0.0344724208, 0, 0.218149036, 0)
SmallFrame.Size = UDim2.new(0.0977218226, 0, 0.0300480761, 0)

CMDSS.Name = "CMDSS"
CMDSS.Parent = SmallFrame
CMDSS.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CMDSS.BackgroundTransparency = 0.900
CMDSS.Position = UDim2.new(0.144876331, 0, 0, 0)
CMDSS.Size = UDim2.new(0.613496959, 0, 1, 0)
CMDSS.Font = Enum.Font.SourceSans
CMDSS.PlaceholderText = "Kill All"
CMDSS.Text = ""
CMDSS.TextColor3 = Color3.fromRGB(255, 255, 255)
CMDSS.TextScaled = true
CMDSS.TextSize = 14.000
CMDSS.TextWrapped = true

RunCMDSS.Name = "RunCMDSS"
RunCMDSS.Parent = SmallFrame
RunCMDSS.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RunCMDSS.BackgroundTransparency = 0.900
RunCMDSS.Position = UDim2.new(0.75837326, 0, 0, 0)
RunCMDSS.Size = UDim2.new(0.239263803, 0, 1, 0)
RunCMDSS.Font = Enum.Font.SourceSans
RunCMDSS.Text = "Run"
RunCMDSS.TextColor3 = Color3.fromRGB(255, 255, 255)
RunCMDSS.TextScaled = true
RunCMDSS.TextSize = 14.000
RunCMDSS.TextWrapped = true

local accountss = {}

function CreateAccount(Name)
	local accountholder = Instance.new("Frame")
	local Toggle = Instance.new("TextButton")
	local TextLabel = Instance.new("TextLabel")
	
	accountholder.Name = "account holder"
	accountholder.Parent = accounts
	accountholder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	accountholder.BackgroundTransparency = 1.000
	accountholder.Position = UDim2.new(0, 0, 7.32310497e-08, 0)
	accountholder.Size = UDim2.new(0, 256, 0, 48)
	
	Toggle.Name = "Toggle"
	Toggle.Parent = accountholder
	Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.BackgroundTransparency = 0.900
	Toggle.Position = UDim2.new(0.0280373823, 0, 0.166666672, 0)
	Toggle.Size = UDim2.new(0.124610595, 0, 0.666666687, 0)
	Toggle.Font = Enum.Font.SourceSans
	Toggle.Text = ""
	Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.TextScaled = true
	Toggle.TextSize = 14.000
	Toggle.TextWrapped = true
	
	TextLabel.Parent = accountholder
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.Position = UDim2.new(0.186915889, 0, 0, 0)
	TextLabel.Size = UDim2.new(0.813084126, 0, 1, 0)
	TextLabel.Font = Enum.Font.ArialBold
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14.000
	TextLabel.TextWrapped = true
	TextLabel.Text = Name
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	accountss[Name] = false
	Toggle.MouseButton1Click:Connect(function()
		if Toggle.Text == 'X' then
			Toggle.Text = ''
			accountss[Name] = false
		else
			Toggle.Text = 'X'
			accountss[Name] = true
		end
	end)
end

local temp = syn.request{Method = 'GET', Url = 'http://localhost:'..Settings.Port..'/GetAccounts?Password='..Settings.Pass} -- Get accounts
local newStr, replaced = string.gsub(temp.Body, ',', '","')
temp = '{"'..newStr..'"}'
loadstring("AllAccounts = "..temp)()
Nexus:Log(Cmds.Text)

function LaunchAccount(Name)
	local Code = 'http://localhost:'..Settings.Port..'/LaunchAccount?Password='..Settings.Pass..'&Account='..Name..'&PlaceId='..game.PlaceId..'&JobId='..game.JobId.."&FollowUser=false&JoinVip=false"
	local temp = syn.request{Method = 'GET', Url = Code}
	return temp.Body
end

function ProssessCmd(message)
	local newStr, replaced = string.gsub(message, ' ', '", "')
	newStr = '{"'..newStr..'", "'..game.Players.LocalPlayer.Name..'"}'
	newStr = string.lower(newStr)
	Nexus:Echo(newStr) -- I made Echo (fun fact)
end

for i, v in pairs(AllAccounts) do
	CreateAccount(v)
end

Join.MouseButton1Click:Connect(function()
	Join.Text = "Joining accounts..."
	for i, v in pairs(accountss) do
		if v == true then
			LaunchAccount(i)
			task.wait(15)
		end
	end
	Join.Text = 'Success!'
	task.wait(1)
	Join.Text = 'Join'
end)

Run.MouseButton1Click:Connect(function()
	ProssessCmd(TextBox.Text)
end)

MiniMize.MouseButton1Click:Connect(function()
	smallScreen.Enabled = true
	ScreenGui.Enabled = false
end)

RunCMDSS.MouseButton1Click:Connect(function()
	ProssessCmd(CMDSS.Text)
end)

Maximize.MouseButton1Click:Connect(function()
		smallScreen.Enabled = false
	ScreenGui.Enabled = true
end)






local UserInputService = game:GetService("UserInputService")
local runService = (game:GetService("RunService"));

local gui = SmallFrame

local dragging
local dragInput
local dragStart
local startPos

function Lerp(a, b, m)
	return a + (b - a) * m
end;

local lastMousePos
local lastGoalPos
local DRAG_SPEED = (8); -- // The speed of the UI darg.
function Update(dt)
	if not (startPos) then return end;
	if not (dragging) and (lastGoalPos) then
		gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED))
		return 
	end;

	local delta = (lastMousePos - UserInputService:GetMouseLocation())
	local xGoal = (startPos.X.Offset - delta.X);
	local yGoal = (startPos.Y.Offset - delta.Y);
	lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
	gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, xGoal, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, yGoal, dt * DRAG_SPEED))
end;

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position
		lastMousePos = UserInputService:GetMouseLocation()

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

runService.Heartbeat:Connect(Update)
