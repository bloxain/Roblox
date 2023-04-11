local GamesPath = _G.BloxainSettings.Games
local Games = listfiles(GamesPath)
if isfile(GamesPath..'/'..tostring(game.GameId)..'.lua') then
	loadstring(readfile(GamesPath..'/'..tostring(game.GameId)..'.lua'))()
else
	loadstring(readfile(_G.BloxainSettings.Path..'/Universal_Gui.lua'))()
end