--[[
 2022 - 2022 Bloxain Team(only mel)
 INTENTES / why we created this?
 
 its like orain(prob misspelled it)  but it has a few probloms
 1. cant save every saveable data type(this can)
 2. it does calls fumcsoins whem loaded(issue since we use to use veny x)
 
 and lastly it did not have a search and if I am every gonna create inf yeaid GUI versoin it would need
 also toggles are checkboxes so we fixed that
 OPEN SOURCE
]]

local pixelwith = 1
local mouse = game.Players.LocalPlayer:GetMouse()
local Tweem = game.TweenService
local UserInputService = game:GetService('UserInputService')
local SaveFolder;
-- global
local NotificationsOffset = -.063
local ANIMSPEED = TweenInfo.new(0.1)
local Selections = {}
local Colors = {
	Enabled = Color3.fromRGB(57, 229, 0),
	Idle = Color3.fromRGB(170, 170, 0),
	Dissabled = Color3.fromRGB(255, 100, 4),
}

local function GetCanvasSize(Frame)
	local YSize = 0
	local padding 
	if Frame.UIListLayout then padding = Frame.UIListLayout.Padding.Offset else padding = 4 end
	for i, v in next, Frame:GetChildren() do
		if v.ClassName == 'Frame' and v.Visible then
			YSize = YSize + v.Size.Y.Offset + padding
		end
	end
	return YSize
end

local function SetCanvasSize(Frame)
	Frame.CanvasSize = UDim2.new(0, Frame.CanvasSize.X, 0, GetCanvasSize(Frame))
end

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
local function SearchElement(Text, Element)
	local epik = false
	if Text ~= '' then
		for i, v in next, Element:GetChildren() do
			if v.ClassName == 'Frame' then
				if string.find(string.lower(v.Name), string.lower(Text)) then
					v.Visible = true
					epik = true
				else
					v.Visible = false
				end
			end
		end
		SetCanvasSize(Element)
	else
		for i, v in next, Element:GetChildren() do
			if v.ClassName == 'Frame' then
				v.Visible = true
			end
		end
		SetCanvasSize(Element)
	end
	return epik
end

local function SaveData(Table)
	if not SaveFolder then
		return
	end
	if not isfolder(SaveFolder) then
		makefolder(SaveFolder)
	end
	writefile(SaveFolder..'/'..tostring(game.GameId)..'.Txt', game.HttpService:JSONEncode(Table))
end

local function GetGlobalData()
	if not SaveFolder then
		return
	end
	if not isfolder(SaveFolder) then
		makefolder(SaveFolder)
	end if not isfile(SaveFolder..'/GobalUI.txt') then
		writefile(SaveFolder..'/GobalUI.txt', '[]')
	end
	return {Data = game.HttpService:JSONDecode(readfile(SaveFolder..'/GobalUI.txt')), Write = function(NewData)
		writefile(SaveFolder..'/GobalUI.txt', game.HttpService:JSONEncode(NewData))
	end}
end

local UI = {Flags = {}, Theme = {Boarder = Color3.fromRGB(255, 255, 255)}}
function UI:MakeNotification(Table)
	local Notification = Instance.new("ScreenGui")
	local Notification_Frame = Instance.new("Frame")
	local Image = Instance.new("ImageLabel")
	local Title = Instance.new("TextLabel")
	local Content = Instance.new("TextLabel")
	if syn and syn.protect_gui then
		syn.protect_gui(Notification)
	end
	if not Table.Image then
		Table.Image = ''
	end

	Notification.Name = "Notification"
	Notification.Parent = game.CoreGui
	Notification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Notification_Frame.Name = "Notification_Frame"
	Notification_Frame.Parent = Notification
	Notification_Frame.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
	Notification_Frame.Position = UDim2.new(1, 0, 0.934, 0)
	Notification_Frame.Size = UDim2.new(0.081, 0, 0.056, 0)

	Image.Name = "Image"
	Image.Parent = Notification_Frame
	Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Image.Position = UDim2.new(0.023, 0, 0.087, 0)
	Image.Size = UDim2.new(0, 25, 0, 25)
	Image.Image = Table.Image
	Image.BackgroundTransparency = 1

	Title.Name = "Title"
	Title.Parent = Notification_Frame
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.158, 0, 0.087, 0)
	Title.Size = UDim2.new(0, 209, 0, 25)
	Title.Font = Enum.Font.SourceSans
	Title.Text = Table.Name
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 25.000
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Content.Name = "Content"
	Content.Parent = Notification_Frame
	Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Content.BackgroundTransparency = 1.000
	Content.Position = UDim2.new(0.023, 0, 0.462, 0)
	Content.Size = UDim2.new(0, 246, 0, 43)
	Content.Font = Enum.Font.SourceSans
	Content.Text = Table.Content
	Content.TextColor3 = Color3.fromRGB(255, 255, 255)
	Content.TextSize = 14.000
	Content.TextWrapped = true
	Content.TextXAlignment = Enum.TextXAlignment.Left
	Content.TextYAlignment = Enum.TextYAlignment.Top

	Instance.new('UICorner', Notification_Frame)
	Instance.new('UICorner', Image)

	task.spawn(function()
		NotificationsOffset += .063
		Tweem:Create(Notification_Frame, ANIMSPEED, {Position = UDim2.new(.914, 0, .934 - NotificationsOffset, 0)}):Play()
		task.wait(Table.Time)
		Tweem:Create(Notification_Frame, ANIMSPEED, {Position = UDim2.new(1, 0, 0, 0)}):Play()
		task.wait(1)
		NotificationsOffset -= .063
		Notification:Destroy()
	end)
end
function UI:Init()

end
function UI:MakeWindow(Table)
	SaveFolder = Table.ConfigFolder 
	if isfile(Table.ConfigFolder..'/'..game.GameId..'.Txt') then
		UI.Flags = game.HttpService:JSONDecode(readfile(Table.ConfigFolder..'/'..game.GameId..'.Txt'))
	end
	local UIScreen = Instance.new("ScreenGui")
	local Window = Instance.new("Frame")
	local TopBar = Instance.new("Frame")
	local Search = Instance.new("TextBox")
	local Title = Instance.new("TextLabel")
	local Pages = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local Divider = Instance.new("Frame")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local Divider_2 = Instance.new("Frame")
	local Storage = Instance.new('Folder')

	local ScreenGui = Instance.new("ScreenGui")
	local RightClick_Menu = Instance.new("Frame")
	local Command1 = Instance.new("Frame")
	local Command1_Button = Instance.new("TextButton")
	local Edit_KeyBind = Instance.new("Frame")
	local Titile = Instance.new("TextLabel")
	local Exit = Instance.new("TextLabel")
	local Text = Instance.new("TextLabel")
	local Key = Instance.new("TextLabel")

	local SelectedPage = nil
	if syn and syn.protect_gui then
		syn.protect_gui(UIScreen)
	end

	UIScreen.Name = Table.Name
	UIScreen.Parent = game.CoreGui
	UIScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Window.Name = "Window"
	Window.Parent = UIScreen
	Window.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Window.ClipsDescendants = true
	Window.Position = UDim2.new(0, 957, 0, 642)
	Window.Size = UDim2.new(0, 551, 0, 300)

	TopBar.Name = "TopBar"
	TopBar.Parent = Window
	TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopBar.BackgroundTransparency = 1.000
	TopBar.Size = UDim2.new(0, 551, 0, 40)

	Search.Name = "Search"
	Search.Parent = TopBar
	Search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Search.BackgroundTransparency = 0.900
	Search.Position = UDim2.new(0.624319434, 0, 0.125, 0)
	Search.Size = UDim2.new(0, 200, 0, 29)
	Search.Font = Enum.Font.SourceSans
	Search.PlaceholderText = "Search"
	Search.Text = ""
	Search.TextColor3 = Color3.fromRGB(255, 255, 255)
	Search.TextSize = 20.000
	Search.TextWrapped = true
	Search.TextXAlignment = Enum.TextXAlignment.Left

	Title.Name = 'Title'
	Title.Parent = TopBar
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.012704174, 0, 0, 0)
	Title.Size = UDim2.new(0, 314, 0, 40)
	Title.Font = Enum.Font.SourceSansBold
	Title.Text = Table.Name
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 35.000
	Title.TextWrapped = true
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Pages.Name = "Pages"
	Pages.Parent = Window
	Pages.Active = true
	Pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Pages.BackgroundTransparency = 1.000
	Pages.Position = UDim2.new(0, 20, 0, 40)
	Pages.Size = UDim2.new(155, 0, 260, 0)
	Pages.CanvasPosition = Vector2.new(0, 2.30769229)
	Pages.ScrollBarThickness = 3
	Pages.CanvasSize = UDim2.new(0, 0, 0, 0)

	UIListLayout.Parent = Pages
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)

	Divider.Name = "Divider"
	Divider.Parent = Window
	Divider.BackgroundColor3 = UI.Theme.Boarder
	Divider.Position = UDim2.new(0, 178, 0, 40)
	Divider.Size = UDim2.new(0, 1, 1, 0)

	Divider_2.Name = "Divider"
	Divider_2.Parent = Window
	Divider_2.BackgroundColor3 = UI.Theme.Boarder
	Divider_2.Position = UDim2.new(0, 0, 0, 40)
	Divider_2.Size = UDim2.new(1, 0, 0, 1)

	--------------------------
	--------------------------
	--------------------------

	RightClick_Menu.Name = "RightClick_Menu"
	RightClick_Menu.Parent = ScreenGui
	RightClick_Menu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RightClick_Menu.Position = UDim2.new(0.315545946, 0, 0.353873253, 0)
	RightClick_Menu.Size = UDim2.new(0, 180, 0, 30)
	RightClick_Menu.Visible = false

	Command1.Name = "Command-1"
	Command1.Parent = RightClick_Menu
	Command1.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Command1.Position = UDim2.new(0, 2, 0, 2)
	Command1.Size = UDim2.new(0, 176, 0, 26)

	Command1_Button.Name = "Command-1_Button"
	Command1_Button.Parent = Command1
	Command1_Button.Active = false
	Command1_Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Command1_Button.BackgroundTransparency = 1.000
	Command1_Button.Position = UDim2.new(0.0397727266, 0, 0, 0)
	Command1_Button.Size = UDim2.new(0, 171, 0, 26)
	Command1_Button.Font = Enum.Font.SourceSans
	Command1_Button.Text = "Set Key bind"
	Command1_Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Command1_Button.TextSize = 20.000
	Command1_Button.TextXAlignment = Enum.TextXAlignment.Left

	Edit_KeyBind.Name = "Exit"
	Edit_KeyBind.Parent = ScreenGui
	Edit_KeyBind.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Edit_KeyBind.Position = UDim2.new(0, 1505, 0, 813)
	Edit_KeyBind.Size = UDim2.new(0, 232, 0, 77)
	Edit_KeyBind.Visible = false

	Titile.Name = "Titile"
	Titile.Parent = Edit_KeyBind
	Titile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Titile.BackgroundTransparency = 1.000
	Titile.Size = UDim2.new(0, 202, 0, 35)
	Titile.Font = Enum.Font.SourceSans
	Titile.Text = "Editing: "
	Titile.TextColor3 = Color3.fromRGB(255, 255, 255)
	Titile.TextSize = 20.000

	Exit.Name = "Edit_KeyBind"
	Exit.Parent = Edit_KeyBind
	Exit.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
	Exit.Position = UDim2.new(0, 200, 0, 2)
	Exit.Size = UDim2.new(0, 30, 0, 30)
	Exit.Text = "x"
	Exit.TextSize = 22.000

	Text.Name = "Text"
	Text.Parent = Edit_KeyBind
	Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Text.BackgroundTransparency = 1.000
	Text.Position = UDim2.new(0, 7, 0, 42)
	Text.Size = UDim2.new(0, 127, 0, 35)
	Text.Font = Enum.Font.SourceSans
	Text.Text = "Current KeyBind:"
	Text.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text.TextSize = 20.000

	Key.Name = "Key"
	Key.Parent = Edit_KeyBind
	Key.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
	Key.Position = UDim2.new(0, 144, 0, 48)
	Key.Size = UDim2.new(0, 45, 0, 22)
	Key.Text = "F3"
	Key.TextColor3 = Color3.fromRGB(255, 255, 255)
	Key.TextSize = 10.000
	Key.TextWrapped = true

	Instance.new('UICorner', RightClick_Menu)
	Instance.new('UICorner', Command1)
	Instance.new('UICorner', Command1_Button)
	Instance.new('UICorner', Edit_KeyBind)
	Instance.new('UICorner', Exit)
	Instance.new('UICorner', Key)

	--------------------------

	local function OpenRightClickMenu(Flag)
		CurrentFlag = Flag
		RightClick_Menu.Position = UDim2.fromOffset(mouse.X, mouse.Y)
		RightClick_Menu.Visible = true
		local Toggle = false
		local Temp = game:GetService('UserInputService').InputBegan:Connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 or key.UserInputType == Enum.UserInputType.MouseButton2 or key.UserInputType == Enum.UserInputType.MouseButton3 then
				RightClick_Menu.Visible = false
				Toggle = true
			end
		end)
		repeat task.wait() until Toggle == true
		Temp:Disconnect()
		Temp = nil;
	end

	local function KeyChangeLogic()
		local function SetSize()
			local temp = game.TextService:GetTextSize(Key.Text, 10, Enum.Font.Legacy, Vector2.new(1000000000, 100000))
			Tweem:Create(Key, ANIMSPEED, {Size = UDim2.fromOffset(temp.X + 15, 22), Position = UDim2.fromOffset(348 - temp.X - 15, 5)}):Play()
		end
		if UI.Flags[CurrentFlag].KeyBind == 'None' then
			Key.Text = '...' SetSize()
			local temp = game:GetService('UserInputService').InputBegan:Connect(function(key)
				if key.UserInputType == Enum.UserInputType.Keyboard then
					UI.Flags[CurrentFlag].KeyBind = key
					Key.Text = key.KeyCode.Name SetSize()
				end
			end)
			repeat task.wait() until UI.Flags[CurrentFlag].KeyBind ~= 'None'
			temp:Disconnect()
			temp = nil;
		else
			Key.Text = 'None' SetSize()
			UI.Flags[CurrentFlag].KeyBind = 'None'
		end
	end

	Exit.InputBegan:Connect(function(key)
		if key.UserInputType == Enum.UserInputType.MouseButton1 then
			Edit_KeyBind.Visible = false
		end
	end)

	Key.InputBegan:Connect(function(key)
		if key.UserInputType == Enum.UserInputType.MouseButton1 then
			KeyChangeLogic()
		end
	end)

	UserInputService.InputBegan:Connect(function(key)
		if key.UserInputType == Enum.UserInputType.Keyboard then
			for _, v in next, UI.Flags do
				if v.KeyBind and v.KeyBind ~= 'None' and v.KeyBind.KeyCode == key.KeyCode then
					v.Funcs.Set({Value = not v.Value})
				end
			end
		end
	end)

	------------------------

	Storage.Name = 'Pages'
	Instance.new('UICorner', Window)
	Instance.new('UICorner', Search)

	Search.Changed:Connect(function(istext)
		if Search[istext] == Search.Text then
			local IsDataOnMain = nil;
			if SelectedPage and SelectedPage.Page then
				IsDataOnMain = SearchElement(Search.Text, SelectedPage.Page)
			end
			for _, v in next, Storage:GetChildren() do
				if SearchElement(Search.Text, v) then
					if not IsDataOnMain then
						if SelectedPage and SelectedPage.Page then
							SelectedPage.Page.Parent = Storage
						end
						v.Parent = Window
						v.Page.Value.TextColor3 = Color3.fromRGB(85, 0, 255)
						IsDataOnMain = 1
					else
						v.Page.Value.TextColor3 = Color3.fromRGB(170, 255, 0)
					end
				else
					v.Page.Value.TextColor3 = Color3.fromRGB(198, 198, 198)
				end
			end
			for _, v in next, Selections do
				if SearchElement(Search.Text, v.Frame) then
					v.Open(true)
					v.Element.Visible = true
					if not IsDataOnMain then
						if SelectedPage and SelectedPage.Page then
							SelectedPage.Page.Parent = Storage
						end
						v.Page.Parent = Window
						if v.Page ~= SelectedPage.Page then
							v.Page.Page.Value.TextColor3 = Color3.fromRGB(85, 0, 255)
						end
						IsDataOnMain = 1
					else
						if v.Page ~= SelectedPage.Page then
							v.Page.Page.Value.TextColor3 = Color3.fromRGB(170, 255, 0)
						end
					end
					SetCanvasSize(v.Page)
				else
					v.Open(false)
					SetCanvasSize(v.Page)
				end
			end
			if Search.Text == '' then
				if Window.Page then
					SearchElement('', Window.Page)
				end
				Window.Page.Parent = Storage
				for _, v in next, Selections do
					v.Open(false)
				end
				for _, v in next, Storage:GetChildren() do
					v.Page.Value.TextColor3 = Color3.fromRGB(198, 198, 198)
				end
				if SelectedPage and SelectedPage.Page then
					SelectedPage.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
					SelectedPage.Page.Parent = Window
				end
			end
		end
	end)
	-- Scaleing by bloxian
	if not GetGlobalData().Data['Movement'] then
		UI['Settings'] = {
			Parent = Window,
			Movement = {
				MoveEnabled = true,
				Lerp = true,
				LerpSpeed = .5,
				SmallScreen = true -- A new type of scrolling that makes a smaller version of your screen and alowws for something cool!(at first users may want to dissable after a while)
			},
			Scaleing = {
				Enabled = true,
				X_Enabled = false,
				Y_Enabled = true,
				XY_Enabled = false,
				ScaleWith = 10
			}
		}
	else
		UI['Settings'] = GetGlobalData().Data
	end UI.Settings['Control'] = GetGlobalData
	local Mouse = game.Players.LocalPlayer:GetMouse()
	local InputService = game:GetService'UserInputService'
	local TweenService = game.TweenService
	local Scaleing = ''
	local Asset = Instance.new('ImageLabel', Window.Parent)
	local Max = workspace.Camera.ViewportSize
	Asset.Size = UDim2.fromOffset(27, 27)
	Asset.BackgroundTransparency = 1
	Asset.Image = 'http://www.roblox.com/asset/?id=10787604883'
	Asset.Visible = true

	local RunService = game["Run Service"].Stepped:Connect(function()
		local X = Mouse.X
		local Y = Mouse.Y
		local With = UI.Settings.Scaleing.ScaleWith
		local WindowEndX = Window.AbsolutePosition.X + Window.AbsoluteSize.X
		local WindowEndY = Window.AbsolutePosition.Y + Window.AbsoluteSize.Y
		local MouseDown = InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
		Asset.Position = UDim2.fromOffset(X - 13.5, Y - 13.5)

		if X > WindowEndX + With - 10 and X < WindowEndX + With + 10 then
			if Y > WindowEndY + With - 10 and Y < WindowEndY + With + 10 and UI.Settings.Scaleing.XY_Enabled then
				Asset.Rotation = 315
				InputService.MouseIconEnabled = false
				Asset.Visible = 1
				Scaleing = 'XY'
				return
			end
			if UI.Settings.Scaleing.X_Enabled then
				Asset.Rotation = 90
				InputService.MouseIconEnabled = false
				Asset.Visible = 1
				Scaleing = 'X'
				return
			end
		end
		if Y > WindowEndY + With - 10 and Y < WindowEndY + With + 10 and X > Window.Position.X.Offset and X < WindowEndX and UI.Settings.Scaleing.Y_Enabled then
			Asset.Rotation = 0 
			InputService.MouseIconEnabled = false
			Asset.Visible = 1
			Scaleing = 'Y'
			return
		end
		InputService.MouseIconEnabled = true
		Asset.Visible = false
		Scaleing = ''
	end)

	InputService.InputBegan:Connect(function(key)
		if key.UserInputType == Enum.UserInputType.MouseButton1 and Scaleing ~= '' then
			local X, Y = Mouse.X, Mouse.Y
			local LockedScaleing = Scaleing
			local ScaleingAct = game["Run Service"].Stepped:Connect(function()
				X, Y = Window.Size.X.Offset + (Mouse.X - X) - Window.Position.X.Offset, Window.Size.Y.Offset + (Mouse.Y - Y) - Window.Position.Y.Offset
				if LockedScaleing == 'XY' then
					Window.Size = UDim2.fromOffset(X, Y)
				elseif LockedScaleing == 'X' then
					Window.Size = UDim2.fromOffset(X, Window.Size.Y.Offset)
				elseif LockedScaleing == 'Y' then
					Window.Size = UDim2.fromOffset(Window.Size.X.Offset, Y)
				end
				Pages.Size = UDim2.fromOffset(155, Window.Size.X.Offset - 40) 
				if SelectedPage then
					SelectedPage.Page.Size = UDim2.fromOffset(367, Window.Size.Y.Offset - 45)
				end
				for i, v in next, Storage:GetChildren() do
					v.Size = UDim2.fromOffset(367, Window.Size.Y.Offset - 45)
				end
			end)
			repeat task.wait() until not InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) -- Wait
			ScaleingAct:Disconnect() ScaleingAct = nil; -- Kill
		end
	end)

	TopBar.InputBegan:Connect(function(key)
		if key.UserInputType == Enum.UserInputType.MouseButton1 and UI.Settings.Movement.MoveEnabled and not UI.Settings.Movement.SmallScreen then
			local function Lerp(udim2)
				TweenService:Create(Window, TweenInfo.new(UI.Settings.Movement.LerpSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = udim2}):Play() -- LOL did you really I know what a lerp is?
			end
			local X, Y = Window.Position.X.Offset - Mouse.X, Window.Position.Y.Offset - Mouse.Y
			local UseLerp = UI.Settings.Movement.Lerp -- but really what is a lerp?
			repeat
				local X2, Y2 =  X + Mouse.X, Y + Mouse.Y
				if X2 + Window.Size.X.Offset > Max.X then
					X2 = Max.X - Window.Size.X.Offset
				end if Y2 + Window.Size.Y.Offset > Max.Y then
					Y2 = Max.Y - Window.Size.Y.Offset
				end if X2 < 0 then
					X2 = 0
				end if Y2 < 0 then
					Y2 = 0
				end
				if UseLerp then
					Lerp(UDim2.fromOffset(X2, Y2))
				else
					Window.Position = UDim2.fromOffset(X2, Y2)
				end
				task.wait()
			until not InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
		elseif key.UserInputType == Enum.UserInputType.MouseButton1 and UI.Settings.Movement.MoveEnabled and UI.Settings.Movement.SmallScreen then
			local Canvas = Instance.new('Frame', Window.Parent)
			local FakeUI = Instance.new('Frame', Window.Parent)
			local SmallUI = Instance.new('Frame', Window.Parent)

			Canvas.BackgroundTransparency = .7
			Canvas.Size = UDim2.fromOffset(workspace.Camera.ViewportSize.X / 8, workspace.Camera.ViewportSize.Y / 8)
			Canvas.Position = UDim2.fromOffset(Mouse.X - Canvas.Size.X.Offset / 2, Mouse.Y - Canvas.Size.Y.Offset / 2)

			SmallUI.Size = UDim2.fromOffset(Window.Size.X.Offset / 8, Window.Size.Y.Offset / 8)
			SmallUI.Position = UDim2.fromOffset((Canvas.Size.X.Offset / 2) - (SmallUI.Size.X.Offset / 2), (Canvas.Size.X.Offset / 2) - (SmallUI.Size.X.Offset / 2))
			SmallUI.Transparency = .7

			FakeUI.Position = UDim2.fromOffset(((Canvas.Size.X.Offset / 2) - (SmallUI.Size.X.Offset / 2))*8, ((Canvas.Size.Y.Offset / 2) - (SmallUI.Size.Y.Offset / 2))*8)
			FakeUI.Size = Window.Size
			FakeUI.Transparency = .7

			if Window:FindFirstChildOfClass('UICorner') then
				Instance.new('UICorner', Canvas)
				Instance.new('UICorner', FakeUI)
				Instance.new('UICorner', SmallUI) -- NOTE to other users you may want to just clone the UICorner
			end

			Window.Visible = false
			repeat
				local X, Y = Mouse.X - SmallUI.Size.X.Offset/2, Mouse.Y - SmallUI.Size.Y.Offset/2
				local WX, WY = (X-Canvas.Position.X.Offset)*8, (Y-Canvas.Position.Y.Offset)*8 -- window X, window Y
				if WX + Window.Size.X.Offset > Max.X then
					X = Canvas.Position.X.Offset + Canvas.Size.X.Offset - SmallUI.Size.X.Offset
					WX = (X-Canvas.Position.X.Offset)*8
				end if WY + Window.Size.Y.Offset > Max.Y then
					Y = Canvas.Position.Y.Offset + Canvas.Size.Y.Offset - SmallUI.Size.Y.Offset
					WY = (Y-Canvas.Position.Y.Offset)*8
				end if X < Canvas.Position.X.Offset then
					X = Canvas.Position.X.Offset
					WX = 0
				end if Y < Canvas.Position.Y.Offset then
					Y = Canvas.Position.Y.Offset
					WY = 0
				end
				if UI.Settings.Movement.Lerp then
					TweenService:Create(Window, TweenInfo.new(UI.Settings.Movement.LerpSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.fromOffset(WX, WY)}):Play()
					TweenService:Create(FakeUI, TweenInfo.new(UI.Settings.Movement.LerpSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.fromOffset(WX, WY)}):Play()
					TweenService:Create(SmallUI, TweenInfo.new(UI.Settings.Movement.LerpSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.fromOffset(X, Y)}):Play()
				else
					SmallUI.Position = UDim2.fromOffset(X, Y)
					FakeUI.Position = UDim2.fromOffset(WX, WY)
					Window.Position = UDim2.fromOffset(WX, WY)
				end
				task.wait()
			until not InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
			Canvas:Destroy()
			FakeUI:Destroy()
			SmallUI:Destroy()
			Window.Visible = true
		end
	end)

	local WindowReturn = {element = Window}
	function WindowReturn:Delete()
		UIScreen:Destroy()
	end
	if not Table.Image then
		Table.Image = ''
	end

	function WindowReturn:Toggle()
		if UI.Open then
			UI.SavedWindowSize = Window.Size.Y.Offset
			Tweem:Create(Window, ANIMSPEED, {Size = UDim2.fromOffset(Window.Size.X.Offset, 0)}):Play()
			task.wait(.1)
			Window.Visible = false
			UI.Open = false
		else
			Window.Visible = true
			Tweem:Create(Window, ANIMSPEED, {Size = UDim2.fromOffset(Window.Size.X.Offset, UI.SavedWindowSize)}):Play()
			UI.Open = true
		end

	end UI.Open = true




	function WindowReturn:MakeTab(Table)
		local Page = Instance.new("ScrollingFrame")
		local UIListLayout_3 = Instance.new("UIListLayout")
		local PageButtonHolder = Instance.new('Frame')
		local PageButton = Instance.new("TextButton")
		local PageValue = Instance.new('ObjectValue')
		local PageButtonValue = Instance.new('ObjectValue')
		local Savecolor = Instance.new('BoolValue')

		Page.Name = "Page"
		Page.Parent = Storage
		Page.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
		Page.BackgroundTransparency = 1.000
		Page.BorderColor3 = Color3.fromRGB(255, 255, 255)
		Page.Position = UDim2.new(0, 186, 0, 42)
		Page.Selectable = false
		Page.Size = UDim2.new(0, 367, 0, 253)
		Page.ScrollBarThickness = 0
		Page.CanvasSize = UDim2.new(0, 0, 0, 0)

		PageButtonHolder.Parent = Pages
		PageButtonHolder.Transparency = 1
		PageButtonHolder.Name = 'PageHolder'
		PageButtonHolder.Size = UDim2.new(0, 147, 0, 30)

		PageButton.Parent = PageButtonHolder
		PageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		PageButton.BackgroundTransparency = 1.000
		PageButton.Position = UDim2.new(0, 0, 0, 0)
		PageButton.Size = UDim2.new(0, 147, 0, 36)
		PageButton.Font = Enum.Font.SourceSans
		PageButton.TextColor3 = Color3.fromRGB(198, 198, 198)
		PageButton.TextSize = 25.000
		PageButton.TextWrapped = true
		PageButton.TextXAlignment = Enum.TextXAlignment.Left
		PageButton.Text = Table.Name

		UIListLayout_3.Parent = Page
		UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_3.Padding = UDim.new(0, 4)

		PageButtonValue.Name = 'Page'
		PageButtonValue.Parent = Page
		PageButtonValue.Value = PageButton

		Savecolor.Name = 'PageColorsave'
		Savecolor.Parent = PageButton
		Savecolor.Value = false

		PageValue.Name = 'Page'
		PageValue.Parent = PageButton
		PageValue.Value = Page

		PageButton.MouseButton1Click:Connect(function()
			Page.Parent = Window
			PageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			Tweem:Create(PageButton, ANIMSPEED, {Position = UDim2.fromOffset(15, 0), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			if SelectedPage and SelectedPage.Page ~= Page then
				SelectedPage['Page'].Parent = Storage
				if SelectedPage.Button.PageColorsave.Value then
					Tweem:Create(SelectedPage.Button, ANIMSPEED, {Position = UDim2.fromOffset(0, 0), TextColor3 = Color3.fromRGB(170, 255, 0)}):Play()
				else
					Tweem:Create(SelectedPage.Button, ANIMSPEED, {Position = UDim2.fromOffset(0, 0), TextColor3 = Color3.fromRGB(198, 198, 198)}):Play()
				end
			end
			SelectedPage = {Page = Page, Button = PageButton}
		end)




		local Tab = {element = SelectedPage}
		function Tab:AddButton(Table)
			local Button = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local Clickable = Instance.new("TextButton")

			Button.Name = Table.Name
			Button.Parent = Table.Parent or Page
			Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Button.Size = UDim2.new(0, 358, 0, 32)

			Color.Name = "ButtonColor"
			Color.Parent = Button
			Color.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Color.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Color.Position = UDim2.new(0, pixelwith, 0, pixelwith)
			Color.Size = UDim2.new(0, 358 - pixelwith * 2, 0, 32 - pixelwith * 2)

			Clickable.Name = "Clickable"
			Clickable.Parent = Color
			Clickable.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Clickable.Position = UDim2.new(0, 7, 0, 1)
			Clickable.Size = UDim2.new(0, 348, 0, 28)
			Clickable.Font = Enum.Font.SourceSans
			Clickable.TextColor3 = Color3.fromRGB(255, 255, 255)
			Clickable.TextSize = 20.000
			Clickable.TextXAlignment = Enum.TextXAlignment.Left
			Clickable.Text = Table.Name
			if Table.Callback then
				Clickable.MouseButton1Click:Connect(Table.Callback)
			end
			if Clickable.TextBounds.X > 358 then
				Clickable.TextScaled = true
			end
			if game.TextService:GetTextSize(Clickable.Text, 15, Enum.Font.Legacy, Vector2.new(1000000000, 100000)).X > 358 then
				Clickable.TextScaled = true
			end

			Instance.new('UICorner', Button)
			Instance.new('UICorner', Color)
			Instance.new('UICorner', Clickable)
			SetCanvasSize(Page)
			local functions = {Element = Button}
			function functions:Set(Text)
				Clickable.Text = Text
				Button.Name = Text
			end
			function functions:Delete()
				Button:Destroy()
				SetCanvasSize(Page)
			end
			return functions
		end

		function Tab:AddToggle(Table)
			local Toggled = false
			if Table.Default then
				Toggled = true
			end
			local FlagTable = {
				Value = Toggled,
				Save = false,
				KeyBind = 'None',
				Funcs = {}
			}
			if Table.Flag and not UI.Flags[Table.Flag] or Table.Flag and UI.Flags[Table.Flag].Save == false then
				if Table.Save then
					FlagTable.Save = true
				end
				UI.Flags[Table.Flag] = FlagTable
			elseif UI.Flags[Table.Flag] and UI.Flags[Table.Flag].Save then
				Toggled = UI.Flags[Table.Flag].Value
			end
			FlagTable = {}
			local TempColor
			if Table.Locked then
				TempColor = Color3.fromRGB(191, 191, 191)
			else 
				TempColor = Color3.fromRGB(255, 255, 255) 
			end local Locked = Table.Locked

			local Toggle = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local Clickable = Instance.new("TextButton")
			local Holder = Instance.new("Frame")
			local Slider = Instance.new("Frame")

			Toggle.Name = Table.Name
			Toggle.Parent = Table.Parent or Page
			Toggle.BackgroundColor3 = UI.Theme.Boarder
			Toggle.Size = UDim2.new(0, 358, 0, 32)

			Color.Name = "ButtonColor"
			Color.Parent = Toggle
			Color.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Color.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Color.Position = UDim2.new(0, pixelwith, 0, pixelwith)
			Color.Size = UDim2.new(0, 358 - pixelwith * 2, 0, 32 - pixelwith * 2)

			Clickable.Name = "Clickable"
			Clickable.Parent = Color
			Clickable.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Clickable.Position = UDim2.new(0, 7, 0, 1)
			Clickable.Size = UDim2.new(0, 348, 0, 28)
			Clickable.Font = Enum.Font.SourceSans
			Clickable.Text =  Table.Name
			Clickable.TextColor3 = TempColor
			Clickable.TextSize = 20.000
			Clickable.TextWrapped = true
			Clickable.Selectable = Locked or false
			Clickable.TextXAlignment = Enum.TextXAlignment.Left

			Holder.Parent = Color
			Holder.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
			Holder.Position = UDim2.new(0, 292, 0, 4)
			Holder.Size = UDim2.new(0, 54, 0, 22)

			Slider.Parent = Holder
			Slider.BackgroundColor3 = Colors.Dissabled
			Slider.Size = UDim2.new(0, 30, 0, 22)
			if Toggled then
				Slider.Position = UDim2.new(0, 24, 0, 0)
				Slider.BackgroundColor3 = Colors.Enabled
			end if game.TextService:GetTextSize(Clickable.Text, 15, Enum.Font.Legacy, Vector2.new(1000000000, 100000)).X > 358 then
				Clickable.TextScaled = true
			end

			Instance.new('UICorner', Toggle)
			Instance.new('UICorner', Color)
			Instance.new('UICorner', Clickable)
			Instance.new('UICorner', Holder)
			Instance.new('UICorner', Slider)
			SetCanvasSize(Page)

			local function toggle()
				if Locked then
					return
				end
				if Toggled then
					Toggled = false
					Tweem:Create(Slider, ANIMSPEED, {Position = UDim2.fromOffset(0, 0), BackgroundColor3 = Colors.Dissabled}):Play()
				else
					Toggled = true
					Tweem:Create(Slider, ANIMSPEED, {Position = UDim2.fromOffset(24, 0), BackgroundColor3 = Colors.Enabled}):Play()
				end
				if Table.Flag then
					UI.Flags[Table.Flag].Value = Toggled
				end if Table.Callback then
					Table.Callback(Toggled)
				end
				SaveData(UI.Flags)
			end

			Clickable.MouseButton1Click:Connect(toggle)
			Clickable.MouseButton2Click:Connect(function() OpenRightClickMenu(Table.Flag) end)

			local functions = {Element = Toggle}
			function functions:Set(Table)
				if Table.Name then
					Clickable.Text = Table.Name
					Toggle.Name = Table.Name
				end
				if Table.Value ~= nil then
					Toggled = not Table.Value
					toggle()
				end
				if Table.Locked then
					Locked = true
					Slider.BackgroundColor3 = Color3.fromRGB(191, 191, 191)
					Clickable.TextColor3 = Color3.fromRGB(191, 191, 191)
					Clickable.Selectable = false
				else 
					Locked = false
					Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255) 
					Clickable.TextColor3 = Color3.fromRGB(255, 255, 255) 
					Clickable.Selectable = true
				end
			end
			function functions:Delete()
				Toggle:Destroy()
				SetCanvasSize(Page)
			end
			if Table.Flag then
				UI.Flags[Table.Flag].Funcs = functions
			end
			return functions
		end
		
		
		
		
		function Tab:AddMutiToggle(Table)
			local Toggled = 0
			if Table.Default then
				Toggled = Table.Default
			end
			local FlagTable = {
				Value = Toggled,
				Save = false,
				KeyBind = 'None',
				Funcs = {}
			}
			if Table.Flag and not UI.Flags[Table.Flag] or Table.Flag and UI.Flags[Table.Flag].Save == false then
				if Table.Save then
					FlagTable.Save = true
				end
				UI.Flags[Table.Flag] = FlagTable
			elseif UI.Flags[Table.Flag] and UI.Flags[Table.Flag].Save then
				Toggled = UI.Flags[Table.Flag].Value
			end
			FlagTable = {}
			local TempColor
			if Table.Locked then
				TempColor = Color3.fromRGB(191, 191, 191)
			else 
				TempColor = Color3.fromRGB(255, 255, 255) 
			end local Locked = Table.Locked

			local Toggle = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local Clickable = Instance.new("TextButton")
			local Holder = Instance.new("Frame")
			local Slider = Instance.new("Frame")

			Toggle.Name = Table.Name
			Toggle.Parent = Table.Parent or Page
			Toggle.BackgroundColor3 = UI.Theme.Boarder
			Toggle.Size = UDim2.new(0, 358, 0, 32)

			Color.Name = "ButtonColor"
			Color.Parent = Toggle
			Color.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Color.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Color.Position = UDim2.new(0, pixelwith, 0, pixelwith)
			Color.Size = UDim2.new(0, 358 - pixelwith * 2, 0, 32 - pixelwith * 2)

			Clickable.Name = "Clickable"
			Clickable.Parent = Color
			Clickable.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Clickable.Position = UDim2.new(0, 7, 0, 1)
			Clickable.Size = UDim2.new(0, 348, 0, 28)
			Clickable.Font = Enum.Font.SourceSans
			Clickable.Text =  Table.Name
			Clickable.TextColor3 = TempColor
			Clickable.TextSize = 20.000
			Clickable.TextWrapped = true
			Clickable.Selectable = Locked or false
			Clickable.TextXAlignment = Enum.TextXAlignment.Left

			Holder.Parent = Color
			Holder.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
			Holder.Position = UDim2.new(0, 292, 0, 4)
			Holder.Size = UDim2.new(0, 54, 0, 22)

			Slider.Parent = Holder
			Slider.BackgroundColor3 = Colors.Dissabled
			Slider.Size = UDim2.new(0, 30, 0, 22)
			if Toggled == 2 then
				Slider.Position = UDim2.new(0, 24, 0, 0)
				Slider.BackgroundColor3 = Colors.Enabled
			elseif Toggled == 1 then
				Slider.Position = UDim2.new(0, 12, 0, 0)
				Slider.BackgroundColor3 = Colors.Idle
				
			end if game.TextService:GetTextSize(Clickable.Text, 15, Enum.Font.Legacy, Vector2.new(1000000000, 100000)).X > 358 then
				Clickable.TextScaled = true
			end

			Instance.new('UICorner', Toggle)
			Instance.new('UICorner', Color)
			Instance.new('UICorner', Clickable)
			Instance.new('UICorner', Holder)
			Instance.new('UICorner', Slider)
			SetCanvasSize(Page)

			local function toggle()
				if Locked then
					return
				end
				if Toggled == 2 then
					Toggled = 0
					Tweem:Create(Slider, ANIMSPEED, {Position = UDim2.fromOffset(0, 0), BackgroundColor3 = Colors.Dissabled}):Play()
				elseif Toggled == 1 then
					Toggled = 2
					Tweem:Create(Slider, ANIMSPEED, {Position = UDim2.fromOffset(24, 0), BackgroundColor3 = Colors.Enabled}):Play()
				else
					Toggled = 1
					Tweem:Create(Slider, ANIMSPEED, {Position = UDim2.fromOffset(12, 0), BackgroundColor3 = Colors.Idle}):Play()
				end
				
				if Table.Flag then
					UI.Flags[Table.Flag].Value = Toggled
				end if Table.Callback then
					Table.Callback(Toggled)
				end
				SaveData(UI.Flags)
			end

			Clickable.MouseButton1Click:Connect(toggle)
			Clickable.MouseButton2Click:Connect(function() OpenRightClickMenu(Table.Flag) end)

			local functions = {Element = Toggle}
			function functions:Set(Table)
				if Table.Name then
					Clickable.Text = Table.Name
					Toggle.Name = Table.Name
				end
				if Table.Value ~= nil then
					toggle()
				end
				if Table.Locked then
					Locked = true
					Slider.BackgroundColor3 = Color3.fromRGB(191, 191, 191)
					Clickable.TextColor3 = Color3.fromRGB(191, 191, 191)
					Clickable.Selectable = false
				else 
					Locked = false
					Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255) 
					Clickable.TextColor3 = Color3.fromRGB(255, 255, 255) 
					Clickable.Selectable = true
				end
			end
			function functions:Delete()
				Toggle:Destroy()
				SetCanvasSize(Page)
			end
			if Table.Flag then
				UI.Flags[Table.Flag].Funcs = functions
			end
			return functions
		end




		function Tab:AddTextbox(Table)
			local TextBox = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local Clickable = Instance.new("TextButton")
			local Input = Instance.new("TextBox")
			if not Table.Default then
				Table.Default = ''
			end

			if not Table.PlaceText then
				Table.PlaceText = ''
			end


			local FlagTable = {
				Value = Table.Default,
				Save = true
			}
			if Table.Flag and not UI.Flags[Table.Flag] or Table.Flag and UI.Flags[Table.Flag].Save == false then
				if Table.Save then
					FlagTable.Save = true
				end
				UI.Flags[Table.Flag] = FlagTable
			elseif UI.Flags[Table.Flag] and UI.Flags[Table.Flag].Save then
				Data = UI.Flags[Table.Flag]
				Table.Default = Data.Value
			end
			FlagTable = {}
			--Properties:

			TextBox.Name = Table.Name
			TextBox.Parent = Table.Parent or Page
			TextBox.BackgroundColor3 = UI.Theme.Boarder
			TextBox.Size = UDim2.new(0, 358, 0, 32)

			Color.Name = "ButtonColor"
			Color.Parent = TextBox
			Color.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Color.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Color.Position = UDim2.new(0, pixelwith, 0, pixelwith)
			Color.Size = UDim2.new(0, 358 - pixelwith * 2, 0, 32 - pixelwith * 2)

			Clickable.Name = "Clickable"
			Clickable.Parent = Color
			Clickable.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Clickable.Position = UDim2.new(0, 7, 0, 1)
			Clickable.Size = UDim2.new(0, 348, 0, 28)
			Clickable.Font = Enum.Font.SourceSans
			Clickable.Text = Table.Name
			Clickable.TextColor3 = Color3.fromRGB(255, 255, 255)
			Clickable.TextSize = 20.000
			Clickable.TextXAlignment = Enum.TextXAlignment.Left

			Input.Name = "Input"
			Input.Parent = TextBox
			Input.Active = false
			Input.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
			Input.Position = UDim2.new(0, 263, 0, 4)
			Input.Selectable = false
			Input.Size = UDim2.new(0, 85, 0, 22)
			Input.PlaceholderText = Table.PlaceText
			Input.Text = Table.Default
			Input.TextColor3 = Color3.fromRGB(255, 255, 255)
			Input.TextSize = 10.000
			Input.TextWrapped = true
			Input.ClearTextOnFocus = Table.TextDisappear
			if Clickable.TextBounds.X > 358 then
				Clickable.TextScaled = true
			end

			Clickable.MouseButton1Click:Connect(function()
				Input:CaptureFocus()
				Tweem:Create(Input, ANIMSPEED, {Position = UDim2.fromOffset(173, 4), Size = UDim2.fromOffset(175, 22)}):Play()
			end)
			Input.Focused:Connect(function()
				Tweem:Create(Input, ANIMSPEED, {Position = UDim2.fromOffset(173, 4), Size = UDim2.fromOffset(175, 22)}):Play()
			end)
			Input.FocusLost:Connect(function()
				Tweem:Create(Input, ANIMSPEED, {Position = UDim2.fromOffset(263, 4), Size = UDim2.fromOffset(85, 22)}):Play()
				if Table.Callback then
					Table.Callback(Input.Text)
				end
				if Table.Flag then
					UI.Flags[Table.Flag].Value = Input.Text
				end
				SaveData(UI.Flags)
			end)


			Instance.new('UICorner', TextBox)
			Instance.new('UICorner', Color)
			Instance.new('UICorner', Clickable)
			Instance.new('UICorner', TextBox)
			SetCanvasSize(Page)

			local functions = {Element = TextBox}
			function functions:Set(Table)
				if Table.Name then
					TextBox.Name = Table.Name
					Clickable.Text = Table.Name
				end
				if Table.Text then
					Input.Text = Table.Text
					SaveData(UI.Flags)
				end if Table.Placeholdertext then
					Input.PlaceholderText = Table.Placeholdertext
				end
			end
			function functions:Delete()
				TextBox:Destroy()
				SetCanvasSize(Page)
			end
			return functions
		end




		function Tab:AddBind(Table)
			local KeyBind = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local Clickable = Instance.new("TextButton")
			local Key = Instance.new("TextLabel")
			local Trigger = nil
			local PickNewKey = 1
			if not Table.Default then
				Table.Default = 'None'
			else
				Trigger = Table.Default
				Table.Default = Table.Default.Name
				PickNewKey = 0
			end

			local FlagTable = {
				Value = Table.Default,
				Save = false,
				Stage = 1
			}
			if Table.Flag and not UI.Flags[Table.Flag] or Table.Flag and UI.Flags[Table.Flag].Save == false then
				if Table.Save then
					FlagTable.Save = true
				end
				UI.Flags[Table.Flag] = FlagTable
			elseif UI.Flags[Table.Flag] and UI.Flags[Table.Flag].Save then
				Data = UI.Flags[Table.Flag]
				Table.Default = Data.Value
				Trigger = nil
				pcall(function() 
					if Enum.KeyCode[Data.Value] then
						Trigger = Enum.KeyCode[Data.Value]
					end	
				end)
				PickNewKey = Data.Stage
			end
			FlagTable = {}

			KeyBind.Name = Table.Name
			KeyBind.Parent = Table.Parent or Page
			KeyBind.BackgroundColor3 = UI.Theme.Boarder
			KeyBind.Size = UDim2.new(0, 358, 0, 32)

			Color.Name = "ButtonColor"
			Color.Parent = KeyBind
			Color.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Color.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Color.Position = UDim2.new(0, pixelwith, 0, pixelwith)
			Color.Size = UDim2.new(0, 358 - pixelwith * 2, 0, 32 - pixelwith * 2)

			Clickable.Name = "Clickable"
			Clickable.Parent = Color
			Clickable.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Clickable.Position = UDim2.new(0, 7, 0, 1)
			Clickable.Size = UDim2.new(0, 348, 0, 28)
			Clickable.Font = Enum.Font.SourceSans
			Clickable.Text = Table.Name
			Clickable.TextColor3 = Color3.fromRGB(255, 255, 255)
			Clickable.TextSize = 20.000
			Clickable.TextXAlignment = Enum.TextXAlignment.Left

			Key.Name = "Key"
			Key.Parent = KeyBind
			Key.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
			Key.Position = UDim2.new(0, 303, 0, 5)
			Key.Size = UDim2.new(0, 45, 0, 22)
			Key.Font = Enum.Font.Legacy
			Key.Text = Table.Default
			Key.TextColor3 = Color3.fromRGB(255, 255, 255)
			Key.TextSize = 10.000
			Key.TextWrapped = true
			if Clickable.TextBounds.X > 358 then
				Clickable.TextScaled = true
			end
			local function SetSize()
				local temp = game.TextService:GetTextSize(Key.Text, 10, Enum.Font.Legacy, Vector2.new(1000000000, 100000))
				Tweem:Create(Key, ANIMSPEED, {Size = UDim2.fromOffset(temp.X + 15, 22), Position = UDim2.fromOffset(348 - temp.X - 15, 5)}):Play()
			end

			game:GetService('UserInputService').InputBegan:Connect(function(key, gameProcessedEvent)
				key = key.KeyCode
				if key == Trigger and not gameProcessedEvent and Table.Callback then
					Table.Callback()
				end
				if PickNewKey == 3 then
					Trigger = key
					Key.Text = key.Name
					PickNewKey = 0
					SetSize()
					if Table.Flag and not save then
						UI.Flags[Table.Flag].Value = Key.Text
						UI.Flags[Table.Flag].Stage = PickNewKey
					end
					SaveData(UI.Flags)
				end
			end)

			Clickable.MouseButton1Click:Connect(function()
				if PickNewKey == 1 then
					Key.Text = '...'
					PickNewKey = 3
					SetSize()
				elseif PickNewKey == 0 then
					Trigger = nil
					Key.Text = 'None'
					PickNewKey = 1
					SetSize()
					if Table.Flag and not save then
						UI.Flags[Table.Flag].Value = Key.Text
						UI.Flags[Table.Flag].Stage = PickNewKey
					end
					SaveData(UI.Flags)
				end
			end)

			Instance.new('UICorner', KeyBind)
			Instance.new('UICorner', Color)
			Instance.new('UICorner', Clickable)
			Instance.new('UICorner', Key)
			SetCanvasSize(Page)
			SetSize()
			local functions = {Element = KeyBind}
			function functions:Set(Table)
				if Table.Name then
					Clickable.Text = Table.Name
					KeyBind.Name = Table.Name
				end if Table.Key then
					Trigger = Table.Key
					Key.Text = Table.Key.Name
					SetSize()
				end
			end
			function functions:Delete()
				KeyBind:Destroy()
				SetCanvasSize(Page)
			end
			return functions
		end




		function Tab:AddLabel(Name)
			local Label = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local View = Instance.new("TextLabel")
			if not Name then
				Name = 'nil'
			end

			Label.Name = Name
			Label.Parent = Table.Parent or Page
			Label.BackgroundColor3 = UI.Theme.Boarder
			Label.Size = UDim2.new(0, 358, 0, 32)

			Color.Name = "ButtonColor"
			Color.Parent = Label
			Color.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Color.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Color.Position = UDim2.new(0, pixelwith, 0, pixelwith)
			Color.Size = UDim2.new(0, 358 - pixelwith * 2, 0, 32 - pixelwith * 2)

			View.Name = Name
			View.Parent = Color
			View.Active = true
			View.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			View.Position = UDim2.new(0, 7, 0, 1)
			View.Selectable = true
			View.Size = UDim2.new(0, 348, 0, 28)
			View.Font = Enum.Font.SourceSans
			View.TextColor3 = Color3.fromRGB(0, 255, 0)
			View.TextSize = 20.000
			View.TextXAlignment = Enum.TextXAlignment.Left
			View.Text = Name

			Instance.new('UICorner', Label)
			Instance.new('UICorner', Color)
			Instance.new('UICorner', View)
			if game.TextService:GetTextSize(View.Text, 15, Enum.Font.Legacy, Vector2.new(1000000000, 100000)).X > 358 then
				View.TextScaled = true
			end

			SetCanvasSize(Page)
			local functions = {Element = View}
			function functions:Set(Text)
				View.Text = Text
				Label.Name = Text
			end

			function functions:Delete()
				Label:Destroy()
				SetCanvasSize(Page)
			end
			return functions
		end

		function Tab:AddParagraph(Table, whyjustdumb)
			local Paragraph = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local View = Instance.new("TextLabel")
			local text = whyjustdumb or Table.Content
			local text2 = Table.Content or Table

			Paragraph.Name = ''
			Paragraph.Parent = Table.Parent or Page
			Paragraph.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Paragraph.Size = UDim2.new(0, 358, 0, 32)

			Color.Name = "Color"
			Color.Parent = Paragraph
			Color.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Color.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Color.Position = UDim2.new(0, pixelwith, 0, pixelwith)
			Color.Size = UDim2.new(0, 358 - pixelwith * 2, 0, 32 - pixelwith * 2)

			View.Name = 'no text or error'
			View.Parent = Color
			View.Active = true
			View.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			View.Position = UDim2.new(0, 7, 0, 1)
			View.Selectable = true
			View.Size = UDim2.new(0, 348, 0, 28)
			View.Font = Enum.Font.SourceSans
			View.TextColor3 = Color3.fromRGB(255, 255, 255)
			View.TextSize = 15.000
			View.TextXAlignment = Enum.TextXAlignment.Left
			View.TextYAlignment = Enum.TextYAlignment.Top
			View.TextWrapped = true

			Instance.new('UICorner', Paragraph)
			Instance.new('UICorner', Color)
			Instance.new('UICorner', View)	
			local function SetText(Text)
				local TextBounds = game.TextService:GetTextSize(Text, 15, Enum.Font.Legacy, Vector2.new(384, 100000000))		
				View.Text = Text
				View.Size = UDim2.fromOffset(TextBounds.X, TextBounds.Y)
				Color.Size = UDim2.fromOffset(pixelwith * 2 + TextBounds.X, pixelwith * 2 + TextBounds.Y)
				Paragraph.Size = UDim2.fromOffset(TextBounds.X,TextBounds.Y)
			end
			SetText(text)

			SetCanvasSize(Page)
			local functions = {Element = View}
			function functions:Set(Text)
				View.Text = Text
				Paragraph.Name = Text
			end

			function functions:Delete()
				Paragraph:Destroy()
				SetCanvasSize(Page)
			end
		end




		function Tab:AddSlider(Table)
			local FlagTable = {
				Value = Table.Default or Table.Min,
				Save = false
			}

			if Table.Flag and not UI.Flags[Table.Flag] or Table.Flag and UI.Flags[Table.Flag].Save == false then
				if Table.Save then
					FlagTable.Save = true
				end
				UI.Flags[Table.Flag] = FlagTable
			elseif UI.Flags[Table.Flag] and UI.Flags[Table.Flag].Save then
				Data = UI.Flags[Table.Flag]
				Table.Default = Data.Value
			end
			FlagTable = {}

			if not Table.Min then
				Table.Min = 0
			end
			if not Table.Default then
				Table.Default = Table.Min
			end
			if not Table.Max then
				Table.Max = 100
			end
			if not Table.Increment then
				Table.Increment = 1
			end

			local Slider = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local View = Instance.new("TextLabel")
			local Bar = Instance.new("Frame")
			local Fill = Instance.new("Frame")
			local Pointer = Instance.new("Frame")
			local Input = Instance.new("TextBox")

			Slider.Name = Table.Name
			Slider.Parent =	Table.Parent or Page
			Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Slider.Position = UDim2.new(0, 0, 0, 0)
			Slider.Size = UDim2.new(0, 358, 0, 45)
			Slider.Selectable = true

			Color.Name = "Color"
			Color.Parent = Slider
			Color.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Color.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Color.Position = UDim2.new(0, pixelwith, 0, pixelwith)
			Color.Size = UDim2.new(0, 358 - pixelwith * 2, 0, 45 - pixelwith * 2)

			View.Name = "View"
			View.Parent = Color
			View.Active = true
			View.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			View.Position = UDim2.new(0, 7, 0, 1)
			View.Size = UDim2.new(0, 348, 0, 24)
			View.Font = Enum.Font.SourceSans
			View.Text = Table.Name
			View.TextColor3 = Color3.fromRGB(255, 255, 255)
			View.TextSize = 20.000
			View.TextXAlignment = Enum.TextXAlignment.Left

			Bar.Name = "Bar"
			Bar.Parent = Slider
			Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Bar.Position = UDim2.new(0, 7, 0, 30)
			Bar.Size = UDim2.new(0, 342, 0, 4)
			Bar.Transparency = 1

			Fill.Name = "Fill"
			Fill.Parent = Bar
			Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Fill.Size = UDim2.new(0, 50, 0, 4)

			Pointer.Name = "Pointer"
			Pointer.Parent = Fill
			Pointer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Pointer.Position = UDim2.new(1, 0, 0, -3)
			Pointer.Size = UDim2.new(0, 10, 0, 10)
			Input.Name = "Input"
			Input.Parent = Slider
			Input.Active = false
			Input.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Input.Position = UDim2.new(0, 290, 0, 5)
			Input.Selectable = false
			Input.Size = UDim2.new(0, 60, 0, 22)
			Input.Text = tostring(Table.Default)
			Input.TextColor3 = Color3.fromRGB(255, 255, 255)
			Input.TextSize = 10.000
			Input.TextWrapped = false
			Input.TextXAlignment = Enum.TextXAlignment.Right
			Instance.new('UICorner', Slider)
			Instance.new('UICorner', Color)
			Instance.new('UICorner', View)
			Instance.new('UICorner', Bar)
			Instance.new('UICorner', Fill)
			Instance.new('UICorner', Pointer)
			if game.TextService:GetTextSize(View.Text, 15, Enum.Font.Legacy, Vector2.new(1000000000, 100000)).X > 200 then
				View.TextScaled = true
			end
			SetCanvasSize(Page)
			local function SetValues(num)
				num = Round(num, Table.Increment)
				Input.Text = tostring(num)
				if Table.Callback then
					Table.Callback(num)
				end
				if Table.Flag then
					UI.Flags[Table.Flag].Value = num
				end
			end

			local function UpdateSlider(value, change)
				local bar = Bar
				local percent = (mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X

				if value then
					percent = (value - Table.Min) / (Table.Max - Table.Min)
				end

				percent = math.clamp(percent, 0, 1)
				value = value or math.floor(Table.Min + (Table.Max - Table.Min) * percent)
				value = Round(value, Table.Increment)
				if not change then
					print(value)
					if math.floor(Table.Increment) == 0 then
						SetValues(value * Table.Increment)
					else
						SetValues(Round(value, Table.Increment))
					end
					SaveData(UI.Flags)
				end
				Tweem:Create(Fill, ANIMSPEED, {Size = UDim2.new(percent, 0, 0, 4)}):Play()
				return value
			end
			UpdateSlider(Table.Default, true)
			Input.Changed:Connect(function(property)
				if Input[property] == Input.Text and tonumber(Input.Text) then
					UpdateSlider(Input.Text)
				end
			end)

			Slider.InputBegan:Connect(function(userinput)
				if userinput.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
				repeat UpdateSlider() task.wait(.1) until not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
				UpdateSlider()
			end)

			local functions = {Element = Slider}
			function functions:Set(changes)
				if changes.Name then
					View.Text = changes.Name
					Slider.Name = changes.Name
				end
				if changes.Value then
					UpdateSlider(changes.Value)
				end
			end
			function functions:Delete()
				Slider:Destroy()
				SetCanvasSize(Page)
			end
			return functions
		end




		function Tab:AddSection(Table)
			local DropDown = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local Clickable = Instance.new("TextButton")
			local Input = Instance.new("TextBox")
			local Arrow = Instance.new("TextLabel")
			local ScrollingFrame = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")

			DropDown.Name = Table.Name
			DropDown.Parent = Table.Parent or Page
			DropDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropDown.Size = UDim2.new(0, 358, 0, 32)

			Color.Name = "Color"
			Color.Parent = DropDown
			Color.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Color.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Color.Position = UDim2.new(0, pixelwith, 0, pixelwith)
			Color.Size = UDim2.new(0, 358 - pixelwith * 2, 0, 32 - pixelwith * 2)
			Color.ClipsDescendants = true

			Clickable.Name = "Clickable"
			Clickable.Parent = Color
			Clickable.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Clickable.Position = UDim2.new(0, 7, 0, 1)
			Clickable.Size = UDim2.new(0, 348, 0, 28)
			Clickable.AutoButtonColor = false
			Clickable.Font = Enum.Font.SourceSans
			Clickable.Text = Table.Name
			Clickable.TextColor3 = Color3.fromRGB(255, 255, 255)
			Clickable.TextSize = 20.000
			Clickable.TextXAlignment = Enum.TextXAlignment.Left

			Input.Name = "Input"
			Input.Parent = Color
			Input.Active = false
			Input.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			Input.Position = UDim2.new(0, 231, 0, 4)
			Input.Selectable = false
			Input.Size = UDim2.new(0, 85, 0, 22)
			Input.PlaceholderText = "Search"
			Input.Text = Table.Default or ""
			Input.TextColor3 = Color3.fromRGB(255, 255, 255)
			Input.TextSize = 10.000
			Input.TextWrapped = true
			Input.TextXAlignment = Enum.TextXAlignment.Right
			Input.ClearTextOnFocus = false

			Arrow.Name = "Arrow"
			Arrow.Parent = Color
			Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Arrow.BackgroundTransparency = 1.000
			Arrow.Position = UDim2.new(0, 327, 0, 4)
			Arrow.Rotation = 270
			Arrow.Size = UDim2.new(0, 20, 0, 20)
			Arrow.Font = Enum.Font.SourceSans
			Arrow.Text = ">"
			Arrow.TextColor3 = Color3.fromRGB(255, 255, 255)
			Arrow.TextSize = 25.000

			ScrollingFrame.Parent = Color
			ScrollingFrame.Active = true
			ScrollingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			ScrollingFrame.Position = UDim2.new(0, 0, 0, 35)
			ScrollingFrame.Size = UDim2.new(0, 367, 0, 208)
			ScrollingFrame.ScrollBarThickness = 0

			UIListLayout.Parent = ScrollingFrame
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 5)
			SetCanvasSize(Page)
			Instance.new('UICorner', DropDown)
			Instance.new('UICorner', Color)
			Instance.new('UICorner', Input)
			if game.TextService:GetTextSize(Clickable.Text, 15, Enum.Font.Legacy, Vector2.new(1000000000, 100000)).X > 358 then
				Clickable.TextScaled = true
			end
			local Selected = Table.Default or ''
			local Open = false
			local function Opendrop(Openn)
				local OpenSize = GetCanvasSize(ScrollingFrame)
				if OpenSize > 350 then
					OpenSize = 350
				end
				Open = Openn
				if Openn then
					ScrollingFrame.Size = UDim2.fromOffset(358, OpenSize)
					Tweem:Create(DropDown, ANIMSPEED, {Size = UDim2.fromOffset(358, OpenSize + 42)}):Play()
					Tweem:Create(Color, ANIMSPEED, {Size = UDim2.fromOffset(358 - pixelwith * 2, OpenSize + 42 - pixelwith * 2)}):Play()
					Tweem:Create(Arrow, ANIMSPEED, {Rotation = 90}):Play()
					task.wait(0.1)
					SetCanvasSize(Page)
				else
					Input.Text = Selected
					Tweem:Create(DropDown, ANIMSPEED, {Size = UDim2.fromOffset(358, 32)}):Play()
					Tweem:Create(Color, ANIMSPEED, {Size = UDim2.fromOffset(358 - pixelwith * 2, 32 - pixelwith * 2)}):Play()
					Tweem:Create(Arrow, ANIMSPEED, {Rotation = 270}):Play()
					task.wait(0.1)
					SetCanvasSize(Page)
				end
			end
			table.insert(Selections, 1, {Open = Opendrop, Page = Page, OgOpen = Open, Frame = ScrollingFrame, Element = DropDown})

			Clickable.MouseButton1Click:Connect(function()
				if Open then
					Opendrop(false)
				else
					Opendrop(true)
				end
			end)

			Input.Focused:Connect(function()
				Input.Text = ''
				Opendrop(true)
			end)

			Input.Changed:Connect(function(istext)
				if Input[istext] == Input.Text then
					SearchElement(Input.Text, ScrollingFrame)
				end
			end)

			local functions = {Element = DropDown}
			function functions:Set(changes)
				if changes.Name then
					Clickable.Text = changes.Name
					DropDown.Name = changes.Name
				end
				if changes.Open then
					Opendrop(changes.Open)
					Open = changes.Open
				end
			end

			function functions:AddLabel(NAME)
				local temp = Tab:AddLabel(NAME, ScrollingFrame)
				SetCanvasSize(ScrollingFrame)
				return temp
			end
			function functions:AddButton(TABLE)
				TABLE['Parent'] = ScrollingFrame
				local temp = Tab:AddButton(TABLE)
				SetCanvasSize(ScrollingFrame)
				return temp
			end
			function functions:AddToggle(TABLE)
				TABLE['Parent'] = ScrollingFrame
				local temp = Tab:AddToggle(TABLE)
				SetCanvasSize(ScrollingFrame)
				return temp
			end
			function functions:AddSlider(TABLE)
				TABLE['Parent'] = ScrollingFrame
				local temp = Tab:AddSlider(TABLE)
				SetCanvasSize(ScrollingFrame)
				return temp
			end
			function functions:AddDropdown(TABLE)
				TABLE['Parent'] = ScrollingFrame
				local temp = Tab:AddDropdown(TABLE)
				SetCanvasSize(ScrollingFrame)
				return temp
			end
			function functions:AddBind(TABLE)
				TABLE['Parent'] = ScrollingFrame
				local temp = Tab:AddBind(TABLE)
				SetCanvasSize(ScrollingFrame)
				return temp
			end
			function functions:AddParagraph(TABLE)
				TABLE['Parent'] = ScrollingFrame
				local temp = Tab:AddParagraph(TABLE)
				SetCanvasSize(ScrollingFrame)
				return temp
			end
			function functions:AddTextbox(TABLE)
				TABLE['Parent'] = ScrollingFrame
				local temp = Tab:AddTextbox(TABLE)
				SetCanvasSize(ScrollingFrame)
				return temp
			end
			function functions:Delete()
				DropDown:Destroy()
				SetCanvasSize(Page)
				SetCanvasSize(ScrollingFrame)
			end

			return functions
		end




		function Tab:AddDropdown(Table)
			local FlagTable = {
				Value = Table.Default,
				Save = false
			}

			if Table.Flag and not UI.Flags[Table.Flag] then
				if Table.Save then
					FlagTable.Save = true
				end
				UI.Flags[Table.Flag] = FlagTable
			elseif UI.Flags[Table.Flag] and UI.Flags[Table.Flag].Save then
				Data = UI.Flags[Table.Flag]
				Table.Default = Data.Value
			end
			FlagTable = {}

			if not Table.Options then
				Table.Options = {nil, nil}
			end

			local DropDown = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local Clickable = Instance.new("TextButton")
			local Input = Instance.new("TextBox")
			local Arrow = Instance.new("TextLabel")
			local ScrollingFrame = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")

			DropDown.Name = Table.Name
			DropDown.Parent = Table.Parent or Page
			DropDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropDown.Size = UDim2.new(0, 358, 0, 32)

			Color.Name = "Color"
			Color.Parent = DropDown
			Color.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Color.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Color.Position = UDim2.new(0, pixelwith, 0, pixelwith)
			Color.Size = UDim2.new(0, 358 - pixelwith * 2, 0, 32 - pixelwith * 2)
			Color.ClipsDescendants = true

			Clickable.Name = "Clickable"
			Clickable.Parent = Color
			Clickable.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Clickable.Position = UDim2.new(0, 7, 0, 1)
			Clickable.Size = UDim2.new(0, 348, 0, 28)
			Clickable.AutoButtonColor = false
			Clickable.Font = Enum.Font.SourceSans
			Clickable.Text = Table.Name
			Clickable.TextColor3 = Color3.fromRGB(255, 255, 255)
			Clickable.TextSize = 20.000
			Clickable.TextXAlignment = Enum.TextXAlignment.Left

			Input.Name = "Input"
			Input.Parent = Color
			Input.Active = false
			Input.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			Input.Position = UDim2.new(0, 231, 0, 4)
			Input.Selectable = false
			Input.Size = UDim2.new(0, 85, 0, 22)
			Input.PlaceholderText = "Select"
			Input.Text = Table.Default or ""
			Input.TextColor3 = Color3.fromRGB(255, 255, 255)
			Input.TextSize = 10.000
			Input.TextWrapped = true
			Input.TextXAlignment = Enum.TextXAlignment.Right
			Input.ClearTextOnFocus = false

			Arrow.Name = "Arrow"
			Arrow.Parent = Color
			Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Arrow.BackgroundTransparency = 1.000
			Arrow.Position = UDim2.new(0, 327, 0, 4)
			Arrow.Rotation = 270
			Arrow.Size = UDim2.new(0, 20, 0, 20)
			Arrow.Font = Enum.Font.SourceSans
			Arrow.Text = ">"
			Arrow.TextColor3 = Color3.fromRGB(255, 255, 255)
			Arrow.TextSize = 25.000

			ScrollingFrame.Parent = Color
			ScrollingFrame.Active = true
			ScrollingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			ScrollingFrame.Position = UDim2.new(0, 7, 0, 35)
			ScrollingFrame.Size = UDim2.new(0, 347, 0, 108)
			ScrollingFrame.ScrollBarThickness = 0

			UIListLayout.Parent = ScrollingFrame
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 3)
			SetCanvasSize(Page)
			Instance.new('UICorner', DropDown)
			Instance.new('UICorner', Color)
			Instance.new('UICorner', Input)
			if game.TextService:GetTextSize(Clickable.Text, 15, Enum.Font.Legacy, Vector2.new(1000000000, 100000)).X > 358 then
				Clickable.TextScaled = true
			end
			local Selected = Table.Default or ''
			local Open = false
			local HotKey;
			local function Opendrop(Openn)
				Open = Openn
				local OpenSize = GetCanvasSize(ScrollingFrame)
				if OpenSize > 350 then
					OpenSize = 350
				end
				if Openn then
					ScrollingFrame.Size = UDim2.fromOffset(358, OpenSize)
					Tweem:Create(DropDown, ANIMSPEED, {Size = UDim2.fromOffset(358, OpenSize + 42)}):Play()
					Tweem:Create(Color, ANIMSPEED, {Size = UDim2.fromOffset(358 - pixelwith * 2, OpenSize + 42 - pixelwith * 2)}):Play()
					Tweem:Create(Arrow, ANIMSPEED, {Rotation = 90}):Play()
					task.wait(0.1)
					SetCanvasSize(Page)
				else
					Input.Text = Selected
					Tweem:Create(DropDown, ANIMSPEED, {Size = UDim2.fromOffset(358, 32)}):Play()
					Tweem:Create(Color, ANIMSPEED, {Size = UDim2.fromOffset(358 - pixelwith * 2, 32 - pixelwith * 2)}):Play()
					Tweem:Create(Arrow, ANIMSPEED, {Rotation = 270}):Play()
					SearchElement('', ScrollingFrame)
					task.wait(0.1)
					SetCanvasSize(Page)
				end
			end
			local function Select(Name)
				Selected = Name
				if Table.Flag then
					UI.Flags[Table.Flag].Value = Name
				end
				Input.Text = Name
				Opendrop(false)
				if Table.Callback then
					Table.Callback(Name)
				end
				SaveData(UI.Flags)
			end
			local function AddButton(Name)
				local Button = Instance.new("Frame")
				local ButtonColor_2 = Instance.new("Frame")
				local Clickable_2 = Instance.new("TextButton")

				Button.Name = Name
				Button.Parent = ScrollingFrame
				Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Button.Size = UDim2.new(0, 340, 0, 26)

				ButtonColor_2.Name = "ButtonColor"
				ButtonColor_2.Parent = Button
				ButtonColor_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				ButtonColor_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
				ButtonColor_2.Position = UDim2.new(0, 1, 0, 1)
				ButtonColor_2.Size = UDim2.new(0, 338, 0, 24)

				Clickable_2.Name = "Clickable"
				Clickable_2.Parent = ButtonColor_2
				Clickable_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				Clickable_2.BackgroundTransparency = 1.000
				Clickable_2.Position = UDim2.new(0, 7, 0, 1)
				Clickable_2.Size = UDim2.new(0, 330, 0, 24)
				Clickable_2.Font = Enum.Font.SourceSans
				Clickable_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				Clickable_2.TextSize = 17.000
				Clickable_2.TextXAlignment = Enum.TextXAlignment.Left
				Clickable_2.Text = Name
				Instance.new('UICorner', Button)
				Instance.new('UICorner', Color)
				Instance.new('UICorner', Clickable)
				SetCanvasSize(ScrollingFrame)
				Clickable_2.MouseButton1Click:Connect(function()
					Select(Name)
				end)
			end
			local function FormatTable(TABLE)
				TABLE = Table.Options
				local returntable = {}
				for i, v in next, TABLE do
					if typeof(i) == 'string' then
						returntable[#returntable + 1] = i
					else
						if typeof(v) == 'string' then
							returntable[i] = v
						elseif v == nil then
							returntable[i] = 'Nil'
						elseif typeof(v) == 'Instance' then
							returntable[i] = v.Name
						end
					end
				end
				return returntable
			end

			for i, v in next, FormatTable(Table.Options) do
				AddButton(v)
			end
			SetCanvasSize(ScrollingFrame)

			Clickable.MouseButton1Click:Connect(function()
				if Open then
					Opendrop(false)
				else
					Opendrop(true)
				end
			end)

			Input.Focused:Connect(function()
				Input.Text = ''
				Opendrop(true)
				if HotKey then
					HotKey:Disconnect()
					HotKey = nil
				end
				HotKey = UserInputService.InputBegan:Connect(function(key)
					if key.KeyCode == Enum.KeyCode.Tab then
						for _, v in next, ScrollingFrame:GetChildren() do
							if v.ClassName == 'Frame' and v.Visible then
								Select(v.Name)
								Input:ReleaseFocus()
							end
						end
					end
				end)
			end)

			Input.Changed:Connect(function(istext)
				if Input[istext] == Input.Text then
					SearchElement(Input.Text, ScrollingFrame)
				end
			end)

			local functions = {Element = DropDown}
			function functions:Set(changes)
				if changes.Name then
					Clickable.Text = changes.Name
					DropDown.Name = changes.Name
				end
				if changes.Value then
					Input.Text = changes.Value
					Selected = changes.Value
				end
				if changes.Open then
					Opendrop(changes.Open)
					Open = changes.Open
				end
			end
			function functions:Delete()
				DropDown:Destroy()
				SetCanvasSize(Page)
			end
			return functions
		end






		function Tab:AddToggleList(Table)
			local FlagTable = {
				Value = Table.Default,
				Save = false
			}

			if Table.Flag and not UI.Flags[Table.Flag] then
				if Table.Save then
					FlagTable.Save = true
				end
				UI.Flags[Table.Flag] = FlagTable
			elseif UI.Flags[Table.Flag] and UI.Flags[Table.Flag].Save then
				Data = UI.Flags[Table.Flag]
				Table.Default = Data.Value
			end
			FlagTable = {}

			if not Table.Options then
				Table.Options = {nil, nil}
			end

			local DropDown = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local Clickable = Instance.new("TextButton")
			local Input = Instance.new("TextBox")
			local Arrow = Instance.new("TextLabel")
			local ScrollingFrame = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")

			DropDown.Name = Table.Name
			DropDown.Parent = Table.Parent or Page
			DropDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropDown.Size = UDim2.new(0, 358, 0, 32)

			Color.Name = "Color"
			Color.Parent = DropDown
			Color.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Color.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Color.Position = UDim2.new(0, pixelwith, 0, pixelwith)
			Color.Size = UDim2.new(0, 358 - pixelwith * 2, 0, 32 - pixelwith * 2)
			Color.ClipsDescendants = true

			Clickable.Name = "Clickable"
			Clickable.Parent = Color
			Clickable.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Clickable.Position = UDim2.new(0, 7, 0, 1)
			Clickable.Size = UDim2.new(0, 348, 0, 28)
			Clickable.AutoButtonColor = false
			Clickable.Font = Enum.Font.SourceSans
			Clickable.Text = Table.Name
			Clickable.TextColor3 = Color3.fromRGB(255, 255, 255)
			Clickable.TextSize = 20.000
			Clickable.TextXAlignment = Enum.TextXAlignment.Left

			Input.Name = "Input"
			Input.Parent = Color
			Input.Active = false
			Input.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			Input.Position = UDim2.new(0, 231, 0, 4)
			Input.Selectable = false
			Input.Size = UDim2.new(0, 85, 0, 22)
			Input.PlaceholderText = "Select"
			Input.Text = Table.Default or ""
			Input.TextColor3 = Color3.fromRGB(255, 255, 255)
			Input.TextSize = 10.000
			Input.TextWrapped = true
			Input.TextXAlignment = Enum.TextXAlignment.Right
			Input.ClearTextOnFocus = false

			Arrow.Name = "Arrow"
			Arrow.Parent = Color
			Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Arrow.BackgroundTransparency = 1.000
			Arrow.Position = UDim2.new(0, 327, 0, 4)
			Arrow.Rotation = 270
			Arrow.Size = UDim2.new(0, 20, 0, 20)
			Arrow.Font = Enum.Font.SourceSans
			Arrow.Text = ">"
			Arrow.TextColor3 = Color3.fromRGB(255, 255, 255)
			Arrow.TextSize = 25.000

			ScrollingFrame.Parent = Color
			ScrollingFrame.Active = true
			ScrollingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			ScrollingFrame.Position = UDim2.new(0, 7, 0, 35)
			ScrollingFrame.Size = UDim2.new(0, 347, 0, 108)
			ScrollingFrame.ScrollBarThickness = 0

			UIListLayout.Parent = ScrollingFrame
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 3)
			SetCanvasSize(Page)
			Instance.new('UICorner', DropDown)
			Instance.new('UICorner', Color)
			Instance.new('UICorner', Input)
			if game.TextService:GetTextSize(Clickable.Text, 15, Enum.Font.Legacy, Vector2.new(1000000000, 100000)).X > 358 then
				Clickable.TextScaled = true
			end
			local Selected = Table.Default or ''
			local Open = false
			local HotKey;
			local function Opendrop(Openn)
				Open = Openn
				local OpenSize = GetCanvasSize(ScrollingFrame)
				if OpenSize > 350 then
					OpenSize = 350
				end
				if Openn then
					ScrollingFrame.Size = UDim2.fromOffset(358, OpenSize)
					Tweem:Create(DropDown, ANIMSPEED, {Size = UDim2.fromOffset(358, OpenSize + 42)}):Play()
					Tweem:Create(Color, ANIMSPEED, {Size = UDim2.fromOffset(358 - pixelwith * 2, OpenSize + 42 - pixelwith * 2)}):Play()
					Tweem:Create(Arrow, ANIMSPEED, {Rotation = 90}):Play()
					task.wait(0.1)
					SetCanvasSize(Page)
				else
					Input.Text = Selected
					Tweem:Create(DropDown, ANIMSPEED, {Size = UDim2.fromOffset(358, 32)}):Play()
					Tweem:Create(Color, ANIMSPEED, {Size = UDim2.fromOffset(358 - pixelwith * 2, 32 - pixelwith * 2)}):Play()
					Tweem:Create(Arrow, ANIMSPEED, {Rotation = 270}):Play()
					SearchElement('', ScrollingFrame)
					task.wait(0.1)
					SetCanvasSize(Page)
				end
			end
			local function Select(Name)
				Selected = Name
				if Table.Flag then
					UI.Flags[Table.Flag].Value = Name
				end
				Input.Text = Name
				Opendrop(false)
				if Table.Callback then
					Table.Callback(Name)
				end
				SaveData(UI.Flags)
			end
			local function AddButton(Name)
				local Button = Instance.new("Frame")
				local ButtonColor_2 = Instance.new("Frame")
				local Clickable_2 = Instance.new("TextButton")

				Button.Name = Name
				Button.Parent = ScrollingFrame
				Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Button.Size = UDim2.new(0, 340, 0, 26)

				ButtonColor_2.Name = "ButtonColor"
				ButtonColor_2.Parent = Button
				ButtonColor_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				ButtonColor_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
				ButtonColor_2.Position = UDim2.new(0, 1, 0, 1)
				ButtonColor_2.Size = UDim2.new(0, 338, 0, 24)

				Clickable_2.Name = "Clickable"
				Clickable_2.Parent = ButtonColor_2
				Clickable_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				Clickable_2.BackgroundTransparency = 1.000
				Clickable_2.Position = UDim2.new(0, 7, 0, 1)
				Clickable_2.Size = UDim2.new(0, 330, 0, 24)
				Clickable_2.Font = Enum.Font.SourceSans
				Clickable_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				Clickable_2.TextSize = 17.000
				Clickable_2.TextXAlignment = Enum.TextXAlignment.Left
				Clickable_2.Text = Name
				Instance.new('UICorner', Button)
				Instance.new('UICorner', Color)
				Instance.new('UICorner', Clickable)
				SetCanvasSize(ScrollingFrame)
				Clickable_2.MouseButton1Click:Connect(function()
					Select(Name)
				end)
			end
			
			
			for i, v in next, Table.Options do
				AddButton(v)
			end
			SetCanvasSize(ScrollingFrame)

			Clickable.MouseButton1Click:Connect(function()
				if Open then
					Opendrop(false)
				else
					Opendrop(true)
				end
			end)

			Input.Focused:Connect(function()
				Input.Text = ''
				Opendrop(true)
				if HotKey then
					HotKey:Disconnect()
					HotKey = nil
				end
				HotKey = UserInputService.InputBegan:Connect(function(key)
					if key.KeyCode == Enum.KeyCode.Tab then
						for _, v in next, ScrollingFrame:GetChildren() do
							if v.ClassName == 'Frame' and v.Visible then
								Select(v.Name)
								Input:ReleaseFocus()
							end
						end
					end
				end)
			end)

			Input.Changed:Connect(function(istext)
				if Input[istext] == Input.Text then
					SearchElement(Input.Text, ScrollingFrame)
				end
			end)

			local functions = {Element = DropDown}
			function functions:Set(changes)
				if changes.Name then
					Clickable.Text = changes.Name
					DropDown.Name = changes.Name
				end
				if changes.Value then
					Input.Text = changes.Value
					Selected = changes.Value
				end
				if changes.Open then
					Opendrop(changes.Open)
					Open = changes.Open
				end
			end
			function functions:Delete()
				DropDown:Destroy()
				SetCanvasSize(Page)
			end
			return functions
		end
		
		
		
		
		







		-- EMD PF TAB
		SetCanvasSize(Pages)
		return Tab
	end
	return WindowReturn
end

return UI