local part = workspace.FloatingPart 
local mass = part:GetMass() 

local attachment = Instance.new("Attachment") 
attachment.Parent = part 

local vectorForce = Instance.new("VectorForce") 
vectorForce.Force = Vector3.new(0,mass * workspace.Gravity,0) 
vectorForce.Attachment0 = attachment 
vectorForce.Parent = part 


local part = workspace.TouchPart

part.Touched:Connect(function(hit)
	print(hit)
end)


local part = workspace.TouchPart

local function printHitName(hit)
	print(hit)
end

part.Touched:Connect(printHitName)
