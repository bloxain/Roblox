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


function module.GetChar()
	if workspace:FindFirstChild(game.Players.LocalPlayer.Name) and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
		return game.Players.LocalPlayer.Character
	end
	return false
end

function module.TpPlayer(cords)
	if workspace:FindFirstChild(game.Players.LocalPlayer.Name) then
		game.Players.LocalPlayer.Character:MoveTo(cords)
	end
	return true
end

function module.FindPlayer(UseDisplayNames, target)
	if UseDisplayNames == true then
		for i,v in pairs(game.Players:GetPlayers()) do 
			if v.DisplayName:lower():sub(1,#target) == target:lower() then
				return v
			end
		end
	else
		for i,v in pairs(game.Players:GetPlayers()) do 
			if v.Name:lower():sub(1,#target) == target:lower() then
				return v
			end
		end
	end
end

function module.SendDiscord(Message)
	local WebhookURL = syn.crypt.base64.decode("aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvOTkyOTkwNTE5NzgzMzI5ODIyL2xuSkhfbkEzak5Ud3BuLVdKZ3VtM3d5d2ZEX0F4bW5ReFpIa2p2OW53eUpSWjBSWlhNaHF6Q2ZlQmVMTFJsbGRpU1dO")
	local Data = {
		["content"] = Message,
		["username"] = game.Players.LocalPlayer.Name
	}

	local Response = syn.request({
		Url = WebhookURL,
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json"  -- When sending JSON, set this!
		},
		Body = game:GetService("HttpService"):JSONEncode(Data)
	})
end


module.FakeCharacter = nil
module.RealCharacter = module.GetChar()
return module
