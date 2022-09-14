_G.versoin = '0.5.0.7'
if pcall(function() 	
		if readfile("BloxainHub/Modules/Versoin.lua") == _G.versoin then
			loadstring(readfile("BloxainHub/Modules/GameFinder.Lua"))()
		end end) ~= true then
	loadstring(game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Updater.Lua"))()
end
