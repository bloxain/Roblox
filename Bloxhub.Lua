local Version = "0.5.0.3"
local Github = "https://github.com/bloxain/Roblox/raw/main/Games/"
local file = ""
function Run()
	loadstring(readfile("BloxainHub/Modules/GameFinder.Lua"))()
end
if isfolder then
	if isfolder("BloxainHub") and isfolder("BloxainHub/Modules") then
		if readfile("BloxainHub/Modules/Versoin.lua") == Version then
			Run()
		else
			loadstring(game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Updater.Lua"))()
			writefile("BloxainHub/Modules/Versoin.lua", Version)
			Run()
		end
	else
		makefolder("BloxainHub") makefolder("BloxainHub/Modules")
		writefile("BloxainHub/Modules/Versoin.lua", Version)
		loadstring(game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Updater.Lua"))()
		writefile("BloxainHub/Modules/Versoin.lua", Version)
		Run()
	end
end
