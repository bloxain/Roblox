local LoaderV2 = Instance.new("ScreenGui")
local Basic_Loader = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Sliders = Instance.new("Frame")
local Fill = Instance.new("Frame")
local Versoin = Instance.new("TextLabel")
local Value = Instance.new("TextLabel")

--Properties:

LoaderV2.Name = "Loader V2"
LoaderV2.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
LoaderV2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Basic_Loader.Name = "Basic_Loader"
Basic_Loader.Parent = LoaderV2
Basic_Loader.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Basic_Loader.Position = UDim2.new(0.424, 0, -.1, 0)
Basic_Loader.Size = UDim2.new(0, 500, 0, 148)
Basic_Loader.Visible = false

Title.Name = "Title"
Title.Parent = Basic_Loader
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0.300000012, 0, 0, 0)
Title.Size = UDim2.new(0, 200, 0, 50)
Title.Font = Enum.Font.Unknown
Title.Text = "Installing..."
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 30.000
Title.TextWrapped = true

Sliders.Name = "Sliders"
Sliders.Parent = Basic_Loader
Sliders.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Sliders.BackgroundTransparency = 0.800
Sliders.Position = UDim2.new(0.0120000001, 0, 0.573648691, 0)
Sliders.Size = UDim2.new(0, 488, 0, 30)

Fill.Name = "Fill"
Fill.Parent = Sliders
Fill.BackgroundColor3 = Color3.fromRGB(0, 125, 0)
Fill.Size = UDim2.new(0, 0, 0, 30)

Versoin.Name = "Versoin"
Versoin.Parent = Basic_Loader
Versoin.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Versoin.BackgroundTransparency = 1.000
Versoin.Position = UDim2.new(0.300000012, 0, 0.337837845, 0)
Versoin.Size = UDim2.new(0, 200, 0, 25)
Versoin.Font = Enum.Font.Roboto
Versoin.Text = 'Gathering file info.../'
Versoin.TextColor3 = Color3.fromRGB(255, 255, 255)
Versoin.TextScaled = true
Versoin.TextSize = 14.000
Versoin.TextWrapped = true

Value.Name = "Value"
Value.Parent = Basic_Loader
Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Value.BackgroundTransparency = 1.000
Value.Position = UDim2.new(0.300000012, 0, 0.837000012, 0)
Value.Size = UDim2.new(0, 200, 0, 21)
Value.Font = Enum.Font.Roboto
Value.Text = "1/10 (10%)"
Value.TextColor3 = Color3.fromRGB(255, 255, 255)
Value.TextScaled = true
Value.TextSize = 14.000
Value.TextWrapped = true

Instance.new('UICorner', Basic_Loader)
Instance.new('UICorner', Sliders)
Instance.new('UICorner', File)
Instance.new('UICorner', Settings)
Instance.new('UICorner', Info)
Instance.new('UICorner', Run)
Instance.new('UICorner', Info).CornerRadius = UDim.new(0, 10)
Instance.new('UICorner', Settings_Panel).CornerRadius = UDim.new(0, 10)
Instance.new('UICorner', Setting)
Instance.new('UICorner', Outer).CornerRadius = UDim.new(0, 5)
Instance.new('UICorner', Outer_2)

local TweenSevice = game.TweenService

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

local function Show(Number)
	local Progress_settings = {Total = Number, Move_Amount = Sliders.Size.X.Offset / Number, Done = 0, Done_Fill = 0}
	Value.Text = Progress_settings.Done..'/'..Number..' {0%)'
	Basic_Loader.Visible = true
	TweenSevice:Create(Basic_Loader, TweenInfo.new(.2, Enum.EasingStyle.Back), {Position = UDim2.fromScale(0.424, 0.458)}):Play()
	local Funcs = {}
	function Funcs:Update()
		Progress_settings.Done_Fill += Progress_settings.Move_Amount
		Progress_settings.Done += 1
		Value.Text = Progress_settings.Done..'/'..Number..' ('..Round((100 / Number) * Progress_settings.Done)..'%)'
		TweenSevice:Create(Fill, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(Progress_settings.Done_Fill, 30)}):Play()
	end
	return Funcs
end

local function GetTableLen(Table)
	local max = 0
	for i, _ in next, Table do
		max += 1
	end
	return max
end
local WebAddress = _G.BloxainSettings.WebAddress

local function Download(NewestFiles)
	local UpdatedFiles = game.HttpService:JSONDecode(NewestFiles.Body)
	local UpdateUI = Show(GetTableLen(UpdatedFiles))
	Versoin.Text = 'Marking files for install'
	for file, datechanged in next, UpdatedFiles do
		local Folders = file:split('/')
		table.remove(Folders, #Folders) -- Delete last item since we dont want to create the file as a folder.
		local Dir = ''
		for _, Folder in next, Folders do
			if not isfolder(Dir..'/'..Folder) then
				makefolder(Dir..'/'..Folder)
			end
			Dir = Dir..Folder..'/'
		end
	end
	Versoin.Text = 'Updateing...'
	for file, datechanged in next, UpdatedFiles do
		spawn(function()
			Versoin.Text = 'Downloading'..file..'...'
			writefile(file, syn.request({Url = WebAddress..file, Method = "GET"}).Body)
			UpdateUI:Update()
			Versoin.Text = 'Downloaded'..file..'!'
		end)
	end
	writefile(_G.BloxainSettings.OldUpdate, NewestFiles.Body)
end


local function Update()
	local Success = false pcall(function() -- Get Web Data
		DownloadedFiles = syn.request({Url = _G.BloxainSettings.FullAddress..'UpdatedFiles', Method = "GET"})
		Success = DownloadedFiles.Success
	end) if not Success then warn('COULD NOT GET DATA SCRIPT IS NOT UPDATED!') return end
	local MainFolder = _G.BloxainSettings.Path
	local OldUpdate = _G.BloxainSettings.OldUpdate
	local UpdatedFiles = game.HttpService:JSONDecode(DownloadedFiles.Body)
	if isfolder(_G.BloxainSettings.Path) and isfile(_G.BloxainSettings.OldUpdate) then OldUpdatedFiles = game.HttpService:JSONDecode(readfile(_G.BloxainSettings.OldUpdate)) else Download(DownloadedFiles) return end
	-- Create Folders
	for file, datechanged in next, UpdatedFiles do
		local Folders = file:split('/')
		table.remove(Folders, #Folders) -- Delete last item since we dont want to create the file as a folder.
		local Dir = _G.BloxainSettings.Path
		for _, Folder in next, Folders do
			if not isfolder(Dir..'/'..Folder) then
				makefolder(Dir..'/'..Folder)
			end
			Dir = Dir..Folder..'/'
		end
	end
	-- Mark Files For Update
	local ToUpdate = {}
	for file, datechanged in next, UpdatedFiles do
		if OldUpdatedFiles[file] ~= datechanged then
			table.insert(ToUpdate, file)
		end
	end
	for _, file in next, ToUpdate do
		spawn(function()
			print('Downloading '..file..'...')
			writefile(file, syn.request({Url = WebAddress..file, Method = "GET"}).Body)
			print('Downloaded '..file..'!')
		end)
	end
	writefile(OldUpdate, DownloadedFiles.Body)
end
Update()

-- Dont waste time
spawn(function()
	TweenSevice:Create(Basic_Loader, TweenInfo.new(.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.424, 1)}):Play()
	task.wait(0.2)
	LoaderV2:Destroy()
end)
