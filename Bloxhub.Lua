local Version = "0.4.9.6"
local Github = "https://github.com/bloxain/Roblox/raw/main/Games/"
local file = ""
function Run()
	loadstring(readfile("Bloxhub#7364/Modules/GameFinder.Lua"))()
end
if isfolder then
	if isfolder("Bloxhub#7364") and isfolder("Bloxhub#7364/Modules") then
		if readfile("Bloxhub#7364/Modules/Versoin.lua") == Version then
			Run()
		else
			loadstring(game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Updater.Lua"))()
			writefile("Bloxhub#7364/Modules/Versoin.lua", Version)
			Run()
		end
	else
		makefolder("Bloxhub#7364") makefolder("Bloxhub#7364/Modules")
		writefile("Bloxhub#7364/Modules/Versoin.lua", Version)
		loadstring(game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Updater.Lua"))()
		writefile("Bloxhub#7364/Modules/Versoin.lua", Version)
		Run()
	end
end
