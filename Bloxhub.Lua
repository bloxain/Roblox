local Version = "0.3.7"
local Github = "https://github.com/bloxain/Roblox/raw/main/Games/"
function Run()
	if game.GameId == 703124385 then
		loadstring(readfile("Bloxhub#7364/Tower_Of_Hell.Lua"))()
		return
	end

	if game.GameId == 781563604 then
		loadstring(readfile("Bloxhub#7364/Destruction_Simulator.Lua"))()
		return
	end

	if game.GameId == 2035583477 then
		loadstring(readfile("Bloxhub#7364/Tower_Simulator.Lua"))()
		return
	end
	
	loadstring(readfile("Bloxhub#7364/Universal_Gui.Lua"))()
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
