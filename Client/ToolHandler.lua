local playerService = game:GetService("Players")
local player = playerService.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local tool = script.Parent
local mouse = player:GetMouse()

local equipped
local clicked = false
local JUMP_HEIGHT = 14

tool.Equipped:Connect(function()
	equipped = true
end)

tool.Unequipped:Connect(function()
	equipped = false
end)

mouse.Button1Down:Connect(function()
	if equipped and not clicked then
		clicked = true
		char.Humanoid.JumpHeight = JUMP_HEIGHT
		
		task.delay(30, function()
			char.Humanoid.JumpHeight = 7.2
			tool:Destroy()
		end)
	end
end)
