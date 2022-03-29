local playerService = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local dataMod = require(script.Parent.Data)
local partFunctionsMod = {}
local coinCodes = {}

playerService.PlayerAdded:Connect(function(player)
	coinCodes[player.UserId] = {}	
end)

playerService.PlayerRemoving:Connect(function(player)
	coinCodes[player.UserId] = nil	
end)

partFunctionsMod.playerFromHit = function(hit)
	local char = hit:FindFirstAncestorOfClass("Model")
	local player = playerService:GetPlayerFromCharacter(char)
	
	return player, char
end

partFunctionsMod.KillParts = function(part)
	part.Touched:Connect(function(hit)
		local player, char = partFunctionsMod.playerFromHit(hit)
		if player and char.Humanoid.Health > 0 then
			char.Humanoid.Health = 0
		end
	end)
end

partFunctionsMod.DamageParts = function(part)
	local debounce = false
	local damage = part:GetAttribute("Damage")
	
	part.Touched:Connect(function(hit)
		local player, char = partFunctionsMod.playerFromHit(hit)
		
		if player and not debounce then
			debounce = true
			local hum = char.Humanoid
			hum:TakeDamage(damage)
			
			task.delay(0.1, function()
				debounce = false
			end)
		end
	end)
end

partFunctionsMod.SpawnParts = function(part)
	local stage = part:GetAttribute("Stage")
	
	part.Touched:Connect(function(hit)
		local player, char = partFunctionsMod.playerFromHit(hit)
		if player and dataMod.get(player, "Stage") == stage - 1 then
			dataMod.set(player, "Stage", stage)
			replicatedStorage.Effect:FireClient(player, part)
		end
	end)
end

local uniqueCode = 0

partFunctionsMod.RewardParts = function(part)
	local reward = part:GetAttribute("Reward")
	local code = uniqueCode
	uniqueCode += 1
	
	part.Touched:Connect(function(hit)
		local player = partFunctionsMod.playerFromHit(hit)
		
		if player then
			local playerCoinCodes = coinCodes[player.UserId]
			
			if not table.find(playerCoinCodes, code) then
				dataMod.increment(player, "Coins", reward)
				table.insert(playerCoinCodes, code)
				replicatedStorage.Effect:FireClient(player, part)
			end
		end
	end)
end

local badgeService = game:GetService("BadgeService")

partFunctionsMod.BadgeParts = function(part)
	local badgeId = part:GetAttribute("BadgeId")
	
	part.Touched:Connect(function(hit)
		local player = partFunctionsMod.playerFromHit(hit)
		
		if player then
			local key = player.UserId
			local hasBadge = badgeService:UserHasBadgeAsync(key, badgeId)
			
			if not hasBadge then
				badgeService:AwardBadge(key, badgeId)
			end
		end
	end)
end


local marketService = game:GetService("MarketplaceService")

partFunctionsMod.PurchaseParts = function(part)
	local promptId = part:GetAttribute("PromptId")
	local isProduct = part:GetAttribute("IsProduct")
	
	part.Touched:Connect(function(hit)
		local player = partFunctionsMod.playerFromHit(hit)
		if player then
			if isProduct then
				marketService:PromptProductPurchase(player, promptId)
			else
				marketService:PromptGamePassPurchase(player, promptId)
			end
		end
	end)
end

local items = {
	["Spring Potion"] = {
		Price = 5;	
	} ;
}

local replicatedStorage = game:GetService("ReplicatedStorage")

partFunctionsMod.ShopParts = function(part)
	local itemName = part:GetAttribute("ItemName")
	local item = items[itemName]
	
	part.Touched:Connect(function(hit)
		local player = partFunctionsMod.playerFromHit(hit)
		
		if player and dataMod.get(player, "Coins") >= item.Price then
			dataMod.increment(player, "Coins", -item.Price)
			local shopFolder = replicatedStorage.ShopItems
			local tool = shopFolder:FindFirstChild(itemName):Clone()
			
			tool.Parent = player.Backpack
		end
	end)
end


local partGroups = {
	workspace.KillParts;
	workspace.DamageParts;
	workspace.SpawnParts;
	workspace.RewardParts;
	workspace.BadgeParts;
	workspace.PurchaseParts;
	workspace.ShopParts;
}

for _, group in pairs(partGroups) do
	for _, part in pairs(group:GetChildren()) do
		if part:IsA("BasePart") then
			partFunctionsMod[group.Name](part)
		end
	end
end

return partFunctionsMod
