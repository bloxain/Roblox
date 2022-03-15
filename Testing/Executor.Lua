-- GUI to Lua
-----
-- EXECUTOR WITHA BETTER UI THAN KRNL OR SYNAPSE X CREDIT TO BLOXAIN ON GITHUB
-- Version: 2.0.
-- Made by chrisopdemobiel.

-- Instances:
local LoadedFile = ""
local selectedfile = ""

local mouse = game.Players.LocalPlayer:GetMouse()


local executor = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Name = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local TextLabel = Instance.new("TextLabel")
local Executor = Instance.new("TextBox")
local Execute = Instance.new("TextButton")
local Clear = Instance.new("TextButton")
local Save = Instance.new("TextButton")
local SaveAs = Instance.new("TextButton")
local SaveFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FileName = Instance.new("TextBox")
local Yes = Instance.new("TextButton")
local No = Instance.new("TextButton")
local RightClickMenu = Instance.new("Frame")
local Executee = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")
local Delete = Instance.new("TextButton")
local List = Instance.new("UIListLayout")

local round = Instance.new("UICorner")
round.Parent = Frame

if syn then
	syn.protect_gui(executor)
	syn.protect_gui(Frame)
	syn.protect_gui(Name)
	syn.protect_gui(ScrollingFrame)
	syn.protect_gui(TextLabel)
	syn.protect_gui(Executor)
	syn.protect_gui(Execute)
	syn.protect_gui(Clear)
	syn.protect_gui(Save)
	syn.protect_gui(SaveAs)
end

--Properties:

executor.Name = "executor"
executor.Parent = game.CoreGui
executor.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = executor
Frame.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
Frame.Position = UDim2.new(0.256460309, 0, 0.203954235, 0)
Frame.Size = UDim2.new(0.300, 0, 0.278, 0)

Name.Name = "Name"
Name.Parent = Frame
Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name.BackgroundTransparency = 1.000
Name.Position = UDim2.new(0.00232829154, 0, 0, 0)
Name.Size = UDim2.new(0.997407317, 0, 0.133501798, 0)
Name.Font = Enum.Font.SourceSans
Name.Text = "Bloxain"
Name.TextColor3 = Color3.fromRGB(255, 255, 255)
Name.TextScaled = true
Name.TextSize = 14.000
Name.TextWrapped = true

ScrollingFrame.Parent = Frame
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.BackgroundTransparency = 1.000
ScrollingFrame.Position = UDim2.new(0.814918637, 0, 0.133501738, 0)
ScrollingFrame.Size = UDim2.new(0.183652714, 0, 0.863108397, 0)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.814918637, 0, 0, 0)
TextLabel.Size = UDim2.new(0.181428567, 0, 0.133501768, 0)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Scripts"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

Executor.Name = "Executor"
Executor.Parent = Frame
Executor.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
Executor.BorderColor3 = Color3.fromRGB(0, 0, 0)
Executor.BorderSizePixel = 5
Executor.Position = UDim2.new(0.0371428393, 0, 0.133501783, 0)
Executor.Size = UDim2.new(0.777142882, 0, 0.758023679, 0)
Executor.Font = Enum.Font.SourceSans
Executor.Text = ""
Executor.TextColor3 = Color3.fromRGB(255, 255, 255)
Executor.TextSize = 14.000
Executor.TextXAlignment = Enum.TextXAlignment.Left
Executor.TextYAlignment = Enum.TextYAlignment.Top
Executor.ClearTextOnFocus = false
Executor.MultiLine = true

Execute.Name = "Execute"
Execute.Parent = Frame
Execute.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Execute.BackgroundTransparency = 1.000
Execute.BorderColor3 = Color3.fromRGB(0, 0, 0)
Execute.BorderSizePixel = 0
Execute.Position = UDim2.new(0.0371428356, 0, 0.912683547, 0)
Execute.Size = UDim2.new(0.0987294242, 0, 0.0847457647, 0)
Execute.Font = Enum.Font.SourceSans
Execute.Text = "Execute"
Execute.TextColor3 = Color3.fromRGB(255, 255, 255)
Execute.TextScaled = true
Execute.TextSize = 14.000
Execute.TextWrapped = true
Execute.TextXAlignment = Enum.TextXAlignment.Right

Clear.Name = "Clear"
Clear.Parent = Frame
Clear.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Clear.BackgroundTransparency = 1.000
Clear.BorderColor3 = Color3.fromRGB(0, 0, 0)
Clear.BorderSizePixel = 0
Clear.Position = UDim2.new(0.155079022, 0, 0.912683547, 0)
Clear.Size = UDim2.new(0.0670364201, 0, 0.0847457647, 0)
Clear.Font = Enum.Font.SourceSans
Clear.Text = "Clear"
Clear.TextColor3 = Color3.fromRGB(255, 255, 255)
Clear.TextScaled = true
Clear.TextSize = 14.000
Clear.TextWrapped = true
Clear.TextXAlignment = Enum.TextXAlignment.Right

Save.Name = "Save"
Save.Parent = Frame
Save.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Save.BackgroundTransparency = 1.000
Save.BorderColor3 = Color3.fromRGB(0, 0, 0)
Save.BorderSizePixel = 0
Save.Position = UDim2.new(0.234495208, 0, 0.913502753, 0)
Save.Size = UDim2.new(0.0612156987, 0, 0.0847457647, 0)
Save.Font = Enum.Font.SourceSans
Save.Text = "Save"
Save.TextColor3 = Color3.fromRGB(255, 255, 255)
Save.TextScaled = true
Save.TextSize = 14.000
Save.TextWrapped = true
Save.TextXAlignment = Enum.TextXAlignment.Right

SaveAs.Name = "Save As"
SaveAs.Parent = Frame
SaveAs.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
SaveAs.BackgroundTransparency = 1.000
SaveAs.BorderColor3 = Color3.fromRGB(0, 0, 0)
SaveAs.BorderSizePixel = 0
SaveAs.Position = UDim2.new(0.314546883, 0, 0.913502753, 0)
SaveAs.Size = UDim2.new(0.0973041728, 0, 0.0847457647, 0)
SaveAs.Font = Enum.Font.SourceSans
SaveAs.Text = "Save As"
SaveAs.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveAs.TextScaled = true
SaveAs.TextSize = 14.000
SaveAs.TextWrapped = true
SaveAs.TextXAlignment = Enum.TextXAlignment.Right

SaveFrame.Parent = executor
SaveFrame.Visible = false
SaveFrame.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
SaveFrame.Position = UDim2.new(0.441735744, 0, 0.286780387, 0)
SaveFrame.Size = UDim2.new(0, 238, 0, 115)

Title.Name = "Title"
Title.Parent = SaveFrame
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Size = UDim2.new(0, 238, 0, 32)
Title.Font = Enum.Font.SourceSans
Title.Text = "Save To File"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true

FileName.Name = "FileName"
FileName.Parent = SaveFrame
FileName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FileName.BackgroundTransparency = 1.000
FileName.Position = UDim2.new(0, 0, 0.278260857, 0)
FileName.Size = UDim2.new(0, 238, 0, 42)
FileName.Font = Enum.Font.SourceSans
FileName.Text = ""
FileName.TextColor3 = Color3.fromRGB(255, 255, 255)
FileName.TextSize = 14.000

Yes.Name = "Yes"
Yes.Parent = SaveFrame
Yes.BackgroundColor3 = Color3.fromRGB(166, 255, 23)
Yes.Position = UDim2.new(0, 0, 0.765217364, 0)
Yes.Size = UDim2.new(0, 105, 0, 27)
Yes.Font = Enum.Font.SourceSans
Yes.Text = "Yes"
Yes.TextColor3 = Color3.fromRGB(0, 0, 0)
Yes.TextScaled = true
Yes.TextSize = 14.000
Yes.TextWrapped = true

No.Name = "No"
No.Parent = SaveFrame
No.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
No.Position = UDim2.new(0.558823526, 0, 0.765217364, 0)
No.Size = UDim2.new(0, 105, 0, 27)
No.Font = Enum.Font.SourceSans
No.Text = "No"
No.TextColor3 = Color3.fromRGB(0, 0, 0)
No.TextScaled = true
No.TextSize = 14.000
No.TextWrapped = true

RightClickMenu.Name = "RightClickMenu"
RightClickMenu.Parent = executor
RightClickMenu.BackgroundColor3 = Color3.new(0.27451, 0.27451, 0.27451)
RightClickMenu.Position = UDim2.new(0.352510959, 0, 0.328358203, 0)
RightClickMenu.Visible = false
RightClickMenu.Size = UDim2.new(0, 128, 0, 181)

Executee.Name = "Execute"
Executee.Parent = RightClickMenu
Executee.BackgroundColor3 = Color3.new(1, 1, 1)
Executee.BackgroundTransparency = 1
Executee.Size = UDim2.new(0, 128, 0, 33)
Executee.Font = Enum.Font.SourceSans
Executee.Text = "Execute"
Executee.TextColor3 = Color3.new(1, 1, 1)
Executee.TextScaled = true
Executee.TextSize = 14
Executee.TextWrapped = true
Executee.TextXAlignment = Enum.TextXAlignment.Left

UIListLayout.Parent = RightClickMenu
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

Delete.Name = "Delete"
Delete.Parent = RightClickMenu
Delete.BackgroundColor3 = Color3.new(1, 1, 1)
Delete.BackgroundTransparency = 1
Delete.Size = UDim2.new(0, 128, 0, 33)
Delete.Font = Enum.Font.SourceSans
Delete.Text = "Delete"
Delete.TextColor3 = Color3.new(1, 1, 1)
Delete.TextScaled = true
Delete.TextSize = 14
Delete.TextWrapped = true
Delete.TextXAlignment = Enum.TextXAlignment.Left


List.Parent = ScrollingFrame

function CreateFile(code, Name)
	local TextButton = Instance.new("TextButton")

	TextButton.Parent = ScrollingFrame
	TextButton.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
	TextButton.Size = UDim2.new(0, 105, 0, 25)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.TextScaled = true
	TextButton.TextSize = 14.000
	TextButton.TextWrapped = true
	local data = Instance.new("StringValue")
	data.Parent = TextButton
	data.Name = "Data"
	data.Value = code
	
	local str = Name
	local newStr, replaced = string.gsub(str, "Executor#1649\\", "")
	newStr, replaced = string.gsub(newStr, ".ScriptdataFile", "")

	TextButton.Text = newStr
	
	TextButton.MouseButton1Click:Connect(function(button)
		Executor.Text = TextButton.Data.Value
		LoadedFile = Name
	end)
	TextButton.Name = Name
	TextButton.MouseButton2Click:Connect(function()
		local X = mouse.X / mouse.ViewSizeX
		local Y = mouse.Y / mouse.ViewSizeY
		RightClickMenu.Position = UDim2.new(X, 0, Y, 0)
		RightClickMenu.Visible = true
		selectedfile = Name
		print(Name)
	end)
end

mouse.Button1Up:Connect(function()
	RightClickMenu.Visible = false
end)

function LoadData()
	if isfolder("Executor#1649") then
		local files = listfiles("Executor#1649")
		for i = 1, #files do
			CreateFile(readfile(files[i]), files[i])
			print(files[i])
		end
	end
end




Execute.MouseButton1Click:Connect(function()
	loadstring(Executor.Text)()
end)

Clear.MouseButton1Click:Connect(function()
	Executor.Text = ""
end)

SaveAs.MouseButton1Click:Connect(function()
	SaveFrame.Visible = true
end)

Save.MouseButton1Click:Connect(function()
	writefile(LoadedFile, Executor.Text)
end)

Executee.MouseButton1Click:Connect(function()
	loadstring(readfile(selectedfile))()
	RightClickMenu.Visible = false
end)

Delete.MouseButton1Click:Connect(function()
	delfile(selectedfile)
	ScrollingFrame[selectedfile]:Destroy()
	RightClickMenu.Visible = false
end)

Yes.MouseButton1Click:Connect(function()
	if isfolder("Executor#1649") then
		writefile("Executor#1649/"..FileName.Text..".ScriptdataFile", Executor.Text)
		CreateFile(Executor.Text, "Executor#1649/"..FileName.Text..".ScriptdataFile")
		LoadedFile = FileName.Text
		SaveFrame.Visible = false
		LoadedFile = "Executor#1649/"..FileName.Text..".ScriptdataFile"
	else
		makefolder("Executor#1649")
	end
end)

No.MouseButton1Click:Connect(function()
	SaveFrame.Visible = false
end)




local UserInputService = game:GetService("UserInputService")
local runService = (game:GetService("RunService"));

local gui = Frame

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

LoadData()
