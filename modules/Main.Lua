local module = {}
function module.Test()
	
end

function module.MangeFakePlayer(inv)
	if inv then
		if module.FakeCharacter then
			module.FakeCharacter:Destroy()
		end
		game.Players.LocalPlayer.Character.Archivable = true
		module.RealCharacter = game.Players.LocalPlayer.Character
		module.FakeCharacter = game.Players.LocalPlayer.Character:Clone()
		module.FakeCharacter.Parent = workspace
		game.Players.LocalPlayer.Character = module.FakeCharacter
		workspace.Camera.CameraSubject = module.FakeCharacter.Humanoid
		return
	end
	game.Players.LocalPlayer.Character = module.RealCharacter
	workspace.Camera.CameraSubject = module.RealCharacter.Humanoid
end

function module.TpFakePlayer(cords)
	if module.FakeCharacter then
		module.FakeCharacter:MoveTo(cords)
	end
	return true
end


function module.CheckChar()
	if workspace:FindFirstChild(game.Players.LocalPlayer.Name) then
		return game.Players.LocalPlayer.Character
	end
	return false
end

function module.TpPlayer(cords)
	if module.CheckChar() then
		game.Players.LocalPlayer.Character:MoveTo(cords)
	end
	return true
end

module.FakeCharacter = nil
module.RealCharacter = module.CheckChar()
return module
