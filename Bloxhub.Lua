local Version = "0.4.3"
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
			writefile("Bloxhub#7364/Data.Lua", Version)
			loadstring(game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Updater.Lua"))()
			Run()
		end
	else
		makefolder("Bloxhub#7364")
		writefile("Bloxhub#7364/Data.Lua", Version)
		loadstring(game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Updater.Lua"))()
		Run()
	end
end
