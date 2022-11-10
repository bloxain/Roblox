_G.versoin = {'0.5.2.1', 'https://github.com/bloxain/Roblox/raw/main/'}
if pcall(function() 	
		if readfile("BloxainHub/Modules/Versoin.lua") == _G.versoin[1] then
			loadstring(readfile("BloxainHub/Modules/GameFinder.Lua"))()
		else
			loadstring(game:HttpGet(_G.versoin[2].."modules/Updater.Lua"))()
		end end) == false then
	loadstring(game:HttpGet(_G.versoin[2].."modules/Updater.Lua"))()
end
loadstring(readfile("BloxainHub/Modules/GameFinder.Lua"))()
