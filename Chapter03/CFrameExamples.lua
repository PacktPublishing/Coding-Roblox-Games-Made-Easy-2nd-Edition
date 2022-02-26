local myCFrame = CFrame.new(0,0,0)	


local Part1 = workspace.Part1
local Part2 = workspace.Part2
Part1.CFrame = CFrame.new(Part1.Position, Part2.Position)


myCFrame *= CFrame.new(0,0,-1)


myCFrame = CFrame.new()
myCFrame *= CFrame.Angles(0,math.pi,0)


local orientation = Vector3.new(myCFrame:ToOrientation())	
part.Orientation = orientation * (360 / (2 * math.pi))
