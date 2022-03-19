local part = workspace.Part
local attachment = Instance.new("Attachment")
attachment.Parent = part

local vectorForce = Instance.new("VectorForce")
vectorForce.Parent = part
vectorForce.Attachment0 = attachment
vectorForce.RelativeTo = Enum.ActuatorRelativeTo.World

local requiredForce = part:GetMass() * workspace.Gravity
vectorForce.Force = Vector3.new(0,requiredForce,0)


local part1 = workspace.Part1
local attachment = Instance.new("Attachment")
attachment.Parent = part1

local linearVelocity = Instance.new("LinearVelocity")
linearVelocity.Parent = part1
linearVelocity.Attachment0 = attachment
linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
linearVelocity.MaxForce = math.huge

local projectileVel = 5
local vectorVel = part1.CFrame.LookVector * projectileVel
linearVelocity.VectorVelocity = vectorVel


local part2 = workspace.Part2
local lookVector = (part2.Position - part1.Position).Unit
--p2 – p1 = directional vector at p1 looking at p2
local vectorVel = lookVector * projectileVel
linearVelocity.VectorVelocity = vectorVel


local part = workspace.Part
local attachment = Instance.new("Attachment")
attachment.Parent = part

local alignPosition = Instance.new("AlignPosition")
alignPosition.Parent = part
alignPosition.Attachment0 = attachment
alignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
alignPosition.ReactionForceEnabled = true
alignPosition.MaxForce = math.huge
alignPosition.Position = Vector3.new(0,15,0)


local part = workspace.Part
local attachment = Instance.new("Attachment")
attachment.Parent = part

local alignOrientation = Instance.new("AlignOrientation")
alignOrientation.Parent = part
alignOrientation.Attachment0 = attachment
alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
alignOrientation.ReactionTorqueEnabled = true
alignOrientation.MaxTorque = math.huge
alignOrientation.CFrame = part.CFrame * CFrame.Angles(0,0, math.pi/4)
