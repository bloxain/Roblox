repeat task.wait(.1) until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and Nexus
_G.STOPALTCONTROL = false
---------------------------------------------------------------------------------
function findTarget(TargetPos)
	local player = game.Players.LocalPlayer.Character
	local rootPos = player.HumanoidRootPart.Position
	local Hum = player.Humanoid

	local pathfinder = game:GetService("PathfindingService")
	local path = pathfinder:FindPathAsync(rootPos, TargetPos)
	local points = path:GetWaypoints()

	if path.Status == Enum.PathStatus.Success then
		for i, v in pairs(points) do
			Hum:MoveTo(v.Position)
			Hum.MoveToFinished:Wait()
			if v.Action == Enum.PathWaypointAction.Jump then
				Hum.Jump = true
			end
		end
	end
end

function FindPlayer(Namee)
	for i, v in pairs(game:GetService'Players':GetPlayers()) do
		if string.find(string.lower(v.Name), Namee) then
			return v
		end
	end
end

function Control(Name)
	if FindPlayer(Name) and FindPlayer(Name).Character then
		local char = FindPlayer(Name).Character
		local Hum = char.Humanoid
		local Hum2 = game.Players.LocalPlayer.Character.Humanoid
		local Root = char.HumanoidRootPart
		local Root2 = game.Players.LocalPlayer.Character.HumanoidRootPart
		while task.wait() do
			Root2.CFrame = Root.CFrame
			local AnimationTracks = Hum.Animator:GetPlayingAnimationTracks()
			local AnimationTracks2 = Hum2.Animator:GetPlayingAnimationTracks()
			
			for _, n in pairs(AnimationTracks) do
				for i, v in pairs(AnimationTracks2) do
					if not table.find(AnimationTracks, v) then
						v:Stop()
						v:Destroy()
					end
				end
				local danceAnimation = Hum2.Animator:LoadAnimation(n.Animation) -- requires an animation object
				danceAnimation:Play()
				danceAnimation:AdjustSpeed(n.Speed) 
				danceAnimation.TimePosition = n.TimePosition
			end

		end
	end
end

local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

---------------------------------------------------------------------------------
function HANDELR(msg)
	print(msg)
	loadstring("message = "..msg)();
	local playername = string.lower(game.Players.LocalPlayer.Name)
	local CMD = message[1];
	if CMD == "chat" then
		for i = 3, #message - 1 do
			message[2] = message[2]..' '..message[i]
		end
		if game.ReplicatedStorage:FindFirstChild('DefaultChatSystemChatEvents') then
			game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message[2], "All")
		else
			game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(message[2])
		end
	elseif CMD == "kill" then
		if FindPlayer(message[2]) == game.Players.LocalPlayer or message[2] == 'all' then
			game.Players.LocalPlayer.Character.Humanoid.Health = 0
		end
	elseif CMD == "walk" then
		game.Players.LocalPlayer.Character.Humanoid:MoveTo(FindPlayer(message[2]).Character.HumanoidRootPart.Position)
	elseif CMD == "tp" then
		game.Players.LocalPlayer.Character:MoveTo(FindPlayer(message[2]).Character.HumanoidRootPart.Position)
	elseif CMD == "swalk" then
		findTarget(FindPlayer(message[2]).Character.HumanoidRootPart.Position)
	elseif CMD == "fps" then
		if not Enabled then
			performance(5)
			Enabled = true
		end
	elseif CMD == "rchat" then
		for i = 3, #message - 1 do
			message[2] = message[2]..' '..message[i]
		end
		task.wait(math.random(1, 100) / 10)
		if game.ReplicatedStorage:FindFirstChild('DefaultChatSystemChatEvents') then
			game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message[2], "All")
		else
			game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(message[2])
		end
	elseif CMD == "exec" then
		for i = 3, #message - 1 do
			message[2] = message[2]..' '..message[i]
		end
		loadstring(message[2])()
	elseif CMD == "jump" then
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
	elseif CMD == "vol" then
		UserSettings():GetService('UserGameSettings').MasterVolume = message[2]
	elseif CMD == "stop" then
		game:shutdown()
	elseif CMD == "follow" then
		Control(message[2])
	elseif CMD == "sit" then
		if FindPlayer(message[2]) == game.Players.LocalPlayer or message[2] == 'all' then
			game.Players.LocalPlayer.Character.Humanoid.Sit = true
		end
	end
end
Nexus.MessageReceived:Connect(function(Message)
	if _G.STOPALTCONTROL == false then
		HANDELR(Message)
	end
end)

local CMDS = {'Chat','walk','tp','swalk','rchat','exec','jump','vol'}

for i, v in pairs(CMDS) do
	Nexus:AddCommand(v, function(Message)
		HANDELR('{"'..v..'","'..Message..'"}')
	end)
end
