local Path = _G.BloxainSettings.Path
local WebAddress = _G.BloxainSettings.WebAddress..Path..'/'
local Modules = _G.BloxainSettings.Modules
local Games = _G.BloxainSettings.WebAddress.._G.BloxainSettings.Games

local Folders = {
	'/Games',
	'/Modules'
}

local Files = {
	{'Universal_Gui.lua', 1},
	{'Modules/Updater.lua', 1},
	{'Modules/UI.Lua', 1},
	{'Modules/Game_Finder.Lua', 1}
}

local function Update()
	if not isfolder(_G.BloxainSettings.Path) then makefolder(_G.BloxainSettings.Path) end
	for _, Folder in next, Folders do
		if not isfolder(Path..Folder) then
			makefolder(Path..Folder)
		end
	end
	
	for _, file in next, Files do
		spawn(function()
			writefile(Path..'/'..file[1], syn.request({Url = WebAddress..file[1], Method = "GET"}).Body)
		end)
	end
print(WebAddress, Games)
	local GameFile = writefile(Path..'/Games/'..tostring(game.GameId)..'.lua', syn.request({Url = Games..'/'..tostring(game.GameId)..'.lua', Method = "GET"}).Body)
end

Update()
