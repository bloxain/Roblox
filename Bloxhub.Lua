_G.versoin = {'0.5.0.7', 'https://github.com/bloxain/Roblox/bloxain-large-update/raw/'}
if pcall(function() 	
		if readfile("BloxainHub/Modules/Versoin.lua") == _G.versoin[1] then
			loadstring(readfile("BloxainHub/Modules/GameFinder.Lua"))()
		end end) ~= true then
	loadstring(game:HttpGet(_G.versoin[2].."main/modules/Updater.Lua"))()
end
