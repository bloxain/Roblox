function Main()
	local Github = "https://github.com/bloxain/Roblox/raw/main/Games/"

	if game.GameId == 703124385 then
		loadstring(game:HttpGet(Github.."T/Tower_Of_Hell.Lua"))()
		return
	end

	if game.GameId == 781563604 then
		loadstring(game:HttpGet(Github.."D/Destruction_Simulator.Lua"))()
		return
	end
	
	if game.GameId == 2035583477 then
		loadstring(game:HttpGet(Github.."T/Tower_Simulator.Lua"))()
		return
	end

	-- UNIVERSAL
	loadstring(game:HttpGet("https://github.com/bloxain/Roblox/raw/main/Universal%20Guil.Lua"))()
	
end


Main()
