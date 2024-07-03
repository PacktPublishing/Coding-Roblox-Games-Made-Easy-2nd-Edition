local playerService = game:GetService("Players")
local physicsService = game:GetService("PhysicsService")
local physicsMod = {}

physicsService:RegisterCollisionGroup("Players")
physicsService:CollisionGroupSetCollidable("Players", "Players", false)

playerService.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CollisionGroup = "Players"
			end
		end
	end)
end)


return physicsMod
