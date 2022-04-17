local Version = "0.4.1"
local Github = "https://github.com/bloxain/Roblox/raw/main/Games/"
local file = ""
function Run()
	loadstring(readfile("Bloxhub#7364/GameFinder.Lua"))()
end
if isfolder then
	if isfolder("Bloxhub#7364") then
		if readfile("Bloxhub#7364/Data.Lua") == Version then
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
else
	print("Get a Better Exploit sorry")
end
