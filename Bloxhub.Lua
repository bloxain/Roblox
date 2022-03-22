local Version = "0.3.6"
local Github = "https://github.com/bloxain/Roblox/raw/main/Games/"
local file = ""
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
function Update()
	writefile("Bloxhub#7364/Tower_Of_Hell.Lua", game:HttpGet(Github.."T/Tower_Of_Hell.Lua"))
	writefile("Bloxhub#7364/Destruction_Simulator.Lua", game:HttpGet(Github.."D/Destruction_Simulator.Lua"))
	writefile("Bloxhub#7364/Tower_Simulator.Lua", game:HttpGet(Github.."T/Tower_Simulator.Lua"))
	writefile("Bloxhub#7364/Universal_Gui.Lua", game:HttpGet("https://github.com/bloxain/Roblox/raw/main/Universal_Gui.Lua"))
	writefile("Bloxhub#7364/Data.Lua", game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Version"))
	writefile("Bloxhub#7364/Venyx_UI.Lua", game:HttpGet("https://github.com/bloxain/Roblox/raw/main/modules/Venyx_UI.Lua"))
	Run()
end
if isfolder then
	if isfolder("Bloxhub#7364") then
		if readfile("Bloxhub#7364/Data.Lua") == Version then
			Run()
		else
			Update()
		end
	else
		makefolder("Bloxhub#7364")
		Update()
	end
else
	loadstring(game:HttpGet("https://github.com/bloxain/Roblox/raw/main/Old/Bloxhub.Lua"))
end
