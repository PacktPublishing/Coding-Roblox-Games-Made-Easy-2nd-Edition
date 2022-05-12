local playerService = game:GetService("Players")
local dataMod = require(script.Parent.Data)
local spawnParts = workspace.SpawnParts
local initializeMod = {}

local function getStage(stageNum)
	for _, stagePart in pairs(spawnParts:GetChildren()) do
		if stagePart:GetAttribute("Stage") == stageNum then
			return stagePart
		end
	end
end

playerService.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		char:WaitForChild("HumanoidRootPart")
		initializeMod.givePremiumTools(player)
		local stageNum = dataMod.get(player, "Stage")
		local spawnPoint = getStage(stageNum)
				
		task.wait()
		char:SetPrimaryPartCFrame(spawnPoint.CFrame * CFrame.new(0,3,0))
	end)
end)

local collectionService = game:GetService("CollectionService")
local marketService = game:GetService("MarketplaceService")
local monetization = require(script.Parent.Monetization)
local toolPasses = {}

initializeMod.givePremiumTools = function(player)
	for _, passId in pairs(toolPasses) do
		local key = player.UserId
		local ownsPass = monetization.ownsPass(key, passId)
		local hasTag = collectionService:HasTag(player, passId)
		
		if hasTag or ownsPass then
			monetization[passId](player)
		end
	end
end

return initializeMod
