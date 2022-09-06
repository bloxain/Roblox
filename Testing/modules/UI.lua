-- Get Rid Of Warnings
local syn = nil
local pixelwith = 1
local mouse = game.Players.LocalPlayer:GetMouse()
local Tweem = game.TweenService
local UserInputService = game:GetService('UserInputService')
-- global
local NotificationsOffset = -.063
local ANIMSPEED = TweenInfo.new(0.1)

local function SetCanvasSize(Frame)
	local YSize = 0
	local padding 
		if Frame.UIListLayout then padding = Frame.UIListLayout.Padding.Offset else padding = 4 end
	for i, v in next, Frame:GetChildren() do
		if v.ClassName ~= 'UIListLayout' and v.Visible then
			YSize = YSize + v.Size.Y.Offset + padding
		end
	end
	Frame.CanvasSize = UDim2.new(0, Frame.CanvasSize.X, 0, YSize)
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
	if Text ~= '' then
		for i, v in next, Element:GetChildren() do
			if v.ClassName == 'Frame' then
				if string.find(string.lower(v.Name), string.lower(Text)) then
					v.Visible = true
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

function UI:MakeWindow(Table)
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
	
	Storage.Name = 'Pages'
	Instance.new('UICorner', Window)
	Instance.new('UICorner', Search)
	
	Search.Changed:Connect(function(istext)
		if Search[istext] == Search.Text and SelectedPage then
			SearchElement(Search.Text, SelectedPage.Page)
		end
	end)
	
	local gui = Window
	local dragging
	local dragInput
	local dragStart
	local startPos
	local function Lerp(a, b, m)
		return a + (b - a) * m
	end;
	local lastMousePos
	local lastGoalPos
	local DRAG_SPEED = (8); -- // The speed of the UI darg.
	local function Update(dt)
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
	TopBar.InputBegan:Connect(function(input)
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
	TopBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	game["Run Service"].Heartbeat:Connect(Update)

	task.spawn(function()
		local isscaling = false
		local defaluatcursor = mouse.Icon
		local Asset = Instance.new('ImageLabel')
		Asset.Size = UDim2.fromOffset(27, 27)
		Asset.BackgroundTransparency = 1
		Asset.Image= 'http://www.roblox.com/asset/?id=10787604883'
		local function setmouse()
			isscaling = true
			UserInputService.MouseIconEnabled = false
			Asset.Parent = UIScreen
			Asset.Position = UDim2.fromOffset(mouse.X - 13.5, mouse.Y - 13.5)
		end
		while true do
			local mousepos = mouse.Y
			local mousepos2 = mouse.X
			local check = Window.Position.Y.Offset + Window.Size.Y.Offset
			local check2 = Window.Position.Y.Offset
			local check3 = Window.Position.Y.Offset + Window.Size.X.Offset
			if mousepos >= check - 10 and mousepos <= check + 10 and mousepos2 >= check3 and check3 and not dragging then
				if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
					local temp = mouse.Y
					local oldSizeY = Window.Size.Y.Offset
					local oldSizeX = Window.Size.X.Offset
					repeat Window.Size = UDim2.fromOffset(oldSizeX, oldSizeY + mouse.Y - temp) setmouse() Pages.Size = UDim2.fromOffset(155, Window.Size.X.Offset - 40) if SelectedPage then SelectedPage.Page.Size = UDim2.fromOffset(367, Window.Size.Y.Offset - 45) end task.wait() until not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
				end
				setmouse()
			else
				if isscaling then
					isscaling = false
					mouse.Icon = defaluatcursor
					UserInputService.MouseIconEnabled = true
					if SelectedPage then
						SetCanvasSize(SelectedPage.Page)
						SetCanvasSize(Pages)
					end
					Pages.Size = UDim2.fromOffset(155, Window.Size.X.Offset - 40)
					Asset.Parent = nil
					for i, v in next, Storage:GetChildren() do
						v.Size = UDim2.fromOffset(367, Window.Size.Y.Offset - 45)
					end
				end
			end
			task.wait()
		end
	end)
	
	local WindowReturn = {element = Window}
	function WindowReturn:Delete()
		UIScreen:Destroy()
	end
	if not Table.Image then
		Table.Image = ''
	end
	
	function WindowReturn:MakeTab(Table)
		local Page = Instance.new("ScrollingFrame")
		local UIListLayout_3 = Instance.new("UIListLayout")
		local PageButtonHolder = Instance.new('Frame')
		local PageButton = Instance.new("TextButton")
		local PageValue = Instance.new('ObjectValue')

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

		PageValue.Name = 'Page'
		PageValue.Parent = PageButton
		PageValue.Value = Page
		PageButton.MouseButton1Click:Connect(function()
			Page.Parent = Window
			PageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			Tweem:Create(PageButton, ANIMSPEED, {Position = UDim2.fromOffset(15, 0), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			if SelectedPage and SelectedPage.Page ~= Page then
				SelectedPage['Page'].Parent = Storage
				Tweem:Create(SelectedPage.Button, ANIMSPEED, {Position = UDim2.fromOffset(0, 0), TextColor3 = Color3.fromRGB(198, 198, 198)}):Play()
			end
			SelectedPage = {Page = Page, Button = PageButton}
		end)
		
		local Tab = {element = SelectedPage}
		function Tab:AddButton(Table)
			local Button = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local Clickable = Instance.new("TextButton")

			Button.Name = Table.Name
			Button.Parent = Page
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
				Save = false
			}
			if Table.Flag then
				if Table.Save then
					FlagTable.Save = true
				end
				UI.Flags[Table.Flag] = FlagTable
			end
			
			local Toggle = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local Clickable = Instance.new("TextButton")
			local Holder = Instance.new("Frame")
			local Slider = Instance.new("Frame")

			Toggle.Name = Table.Name
			Toggle.Parent = Page
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
			Clickable.TextColor3 = Color3.fromRGB(255, 255, 255)
			Clickable.TextSize = 20.000
			Clickable.TextWrapped = true
			Clickable.TextXAlignment = Enum.TextXAlignment.Left

			Holder.Parent = Color
			Holder.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
			Holder.Position = UDim2.new(0, 292, 0, 4)
			Holder.Size = UDim2.new(0, 54, 0, 22)
			
			Slider.Parent = Holder
			Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Slider.Size = UDim2.new(0, 30, 0, 22)
			if Toggled then
				Slider.Position = UDim2.new(0, 24, 0, 0)
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
				if Toggled then
					Toggled = false
					Tweem:Create(Slider, ANIMSPEED, {Position = UDim2.fromOffset(0, 0)}):Play()
				else
					Toggled = true
					Tweem:Create(Slider, ANIMSPEED, {Position = UDim2.fromOffset(24, 0)}):Play()
				end
				if Table.Flag then
					UI.Flags[Table.Flag].Value = Toggled
				end if Table.Callback then
					Table.Callback(Toggled)
				end
			end
			
			Clickable.MouseButton1Click:Connect(toggle)
			
			local functions = {Element = Toggle}
			function functions:Set(Table)
				if Table.Name then
					Clickable.Text = Table.Name
					Toggle.Name = Table.Name
				end
				if Table.Value then
					Toggled = not Table.Value
					toggle()
				end
			end
			function functions:Delete()
				Toggle:Destroy()
				SetCanvasSize(Page)
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
			local FlagTable = {
				Value = Table.Default,
				Save = true
			}
			if Table.Flag then
				if Table.Save then
					FlagTable.Save = true
				end
				UI.Flags[Table.Flag] = FlagTable
			end if not Table.Placeholdertext then
				Table.Placeholdertext = ''
			end if Table.TextDisappear == nil then
				Table.TextDisappear = true
			end

			--Properties:

			TextBox.Name = Table.Name
			TextBox.Parent = Page
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
			Clickable.Text = "TextBox"
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
			Input.PlaceholderText = Table.Placeholdertext
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
			if not Table.Hold then
				
			end if not Table.Default then
				Table.Default = 'None'
			else
				Trigger = Table.Default
				Table.Default = Table.Default.Name
				PickNewKey = 0
			end
			
			local FlagTable = {
				Value = Table.Default,
				Save = false
			}
			if Table.Default == 'None' then
				FlagTable.Value = nil
			end
			
			if Table.Flag then
				if Table.Save then
					FlagTable.Save = true
				end
				UI.Flags[Table.Flag] = FlagTable
			end
			KeyBind.Name = Table.Name
			KeyBind.Parent = Page
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
				if key == Trigger then
					if Table.Callback then
						Table.Callback()
					end
				end
				if PickNewKey == 3 then
					Trigger = key
					Key.Text = key.Name
					PickNewKey = 0
					if Table.Flag then
						UI.Flags[Table.Flag].Value = key.Name
					end
					SetSize()
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
					SetSize()
					PickNewKey = 1
					if Table.Flag then
						if Table.Flag then
							UI.Flags[Table.Flag].Value = nil
						end
					end
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
		
		function Tab:AddLabel(Table)
			local Label = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local View = Instance.new("TextLabel")

			Label.Name = Table.Name
			Label.Parent = Page
			Label.BackgroundColor3 = UI.Theme.Boarder
			Label.Size = UDim2.new(0, 358, 0, 32)

			Color.Name = "ButtonColor"
			Color.Parent = Label
			Color.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Color.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Color.Position = UDim2.new(0, pixelwith, 0, pixelwith)
			Color.Size = UDim2.new(0, 358 - pixelwith * 2, 0, 32 - pixelwith * 2)

			View.Name = Table.Name
			View.Parent = Color
			View.Active = true
			View.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			View.Position = UDim2.new(0, 7, 0, 1)
			View.Selectable = true
			View.Size = UDim2.new(0, 348, 0, 28)
			View.Font = Enum.Font.SourceSans
			View.TextColor3 = Color3.fromRGB(255, 255, 255)
			View.TextSize = 20.000
			View.TextXAlignment = Enum.TextXAlignment.Left

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

			Paragraph.Name = text2
			Paragraph.Parent = Page
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
			
			local FlagTable = {
				Value = Table.Default,
				Save = false
			}

			if Table.Flag then
				if Table.Save then
					FlagTable.Save = true
				end
				UI.Flags[Table.Flag] = FlagTable
			end
			local Slider = Instance.new("Frame")
			local Color = Instance.new("Frame")
			local View = Instance.new("TextLabel")
			local Bar = Instance.new("Frame")
			local Fill = Instance.new("Frame")
			local Pointer = Instance.new("Frame")
			local Input = Instance.new("TextBox")

			Slider.Name = Table.Name
			Slider.Parent =	Page
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
				if Table.Callback then
					Table.Callback(num)
				end
				if Table.Flag then
					UI.Flags[Table.Flag].Value = num
				end
			end
			
			local function UpdateSlider(value, set)
				local bar = Bar
				local percent = (mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
				
				if value then
					percent = (value - Table.Min) / (Table.Max - Table.Min)
				end

				percent = math.clamp(percent, 0, 1)
				value = value or math.floor(Table.Min + (Table.Max - Table.Min) * percent)
				value = Round(value, Table.Increment)
				Input.Text = value
				if set ~= '$Stop' then SetValues(value) end
				Tweem:Create(Fill, ANIMSPEED, {Size = UDim2.new(percent, 0, 0, 4)}):Play()
				return value
			end
			UpdateSlider(Table.Default, '$Stop')
			Input.Changed:Connect(function(property)
				if Input[property] == Input.Text and tonumber(Input.Text) then
					print(UpdateSlider(Input.Text))
				end
			end)
			
			Slider.InputBegan:Connect(function(userinput)
				if userinput.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
				repeat UpdateSlider() task.wait() until not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
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
		
		function Tab:AddDropdown(Table)
			local FlagTable = {
				Value = Table.Default,
				Save = false
			}
			
			if Table.Flag then
				if Table.Save then
					FlagTable.Save = true
				end
				UI.Flags[Table.Flag] = FlagTable
			end
			
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
			DropDown.Parent = Page
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
			Input.PlaceholderText = "test"
			Input.Text = ""
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
			Arrow.Rotation = 90.000
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
				Open = Openn
				if Openn then
					Tweem:Create(DropDown, ANIMSPEED, {Size = UDim2.fromOffset(358, 150)}):Play()
					Tweem:Create(Color, ANIMSPEED, {Size = UDim2.fromOffset(358 - pixelwith * 2, 150 - pixelwith * 2)}):Play()
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
					Selected = Name
					if Table.Flag then
						UI.Flags[Table.Flag].Value = Name
					end
					Input.Text = Name
					Opendrop(false)
					if Table.Callback then
						Table.Callback(Name)
					end
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
		
		
		SetCanvasSize(Pages)
		return Tab
	end
	return WindowReturn
end

return UI

--local Window = UI:MakeWindow({Name = 'Test'})
--local Tab = Window:MakeTab({Name = 'TestTab'})
--local Tab2 = Window:MakeTab({Name = 'textBox'})

--local Temp = Tab:AddButton({
--	Name = "Kill",
--	Callback = function()
--		Window:Delete()
--	end    
--})

--local Temp2 = Tab:AddButton({
--	Name = "Delete me",
--	Callback = function()
--		Window:Delete()
--	end    
--})

--local Temp3 = Tab:AddToggle({
--	Name = "KillUI",
--	Flag = 'test',
--	Callback = function(Value)
--		print(Value)
--	end  
--})

--Tab:AddButton({
--	Name = "Set Value",
--	Callback = function()
--		Temp:Set('kill UI')
--		Temp2:Delete()
--		Temp3:Set({Name = 'to pro', Value = true})
--	end    
--})

-- local temp4 = Tab2:AddTextbox({
--	Name = "text box",
--	Default = "default box input",
--	TextDisappear = true,
--	Flag = 'text',
--	Callback = function(Value)
--		print(Value)
--	end	  
--})

--Tab2:AddButton({
--	Name = "Set Value",
--	Callback = function()
--		print(UI.Flags['test'].Value)
--		temp4:Set({Name = 'to pro', Text = 'changed'})
--	end    
--})

--Tab:AddBind({
--	Name = "Bind",
--	Default = Enum.KeyCode.E,
--	Hold = false,
--	Callback = function()
--		print("press")
--	end    
--})

--Tab2:AddSlider({
--	Name = "Slider" ,
--	Min = -20,
--	Max = 20,
--	Increment = 5
--})

--Tab:AddSlider({
--	Name = "Slider" ,
--	Min = -20,
--	Max = 20,
--	Default = 0,
--	Increment = 0.25
--})

--Tab:AddDropdown({
--	Name = "Dropdown",
--	Default = "1",
--	Options = {"1", "2"},
--	Callback = function(Value)
--		print(Value)
--	end    
--})

------[[
----Name = <string> - The name of the dropdown.
----Default = <string> - The default value of the dropdown.
----Options = <table> - The options in the dropdown.
----Callback = <function> - The function of the dropdown.
----]]
