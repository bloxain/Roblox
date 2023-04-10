local Path = _G.BloxainSettings.Path
local WebAddress = _G.BloxainSettings.WebAddress

local Folders = {
	'Games',
	'Modules'
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
		if not isfolder(Folder) then
			makefolder(Folder)
		end
	end
	
	for _, file in next, Files do
		spawn(function()
			writefileasync(file[1], syn.request({Url = WebAddress..file[1]..tostring(game.GameId)..'.lua', Method = "GET"}).Body)
		end)
	end
	
	local GameFile = writefileasync(Path..'/Games/'..tostring(game.GameId), syn.request({Url = WebAddress..'Games/'..tostring(game.GameId)..'.lua', Method = "GET"}).Body)
end
