for i = 0, 10, 1 do
	print(i)
end


local n = 17
local sum = 0

for i = 1, n do
	sum += i
end

print(sum)
print("Function working = ".. tostring(sum == (n * (n + 1)) / 2)) 


local items = {
	Animal = "Elephant";
	Food = "Egg";
	Plant = "Flower"
}

for index, value in pairs(items) do
	print(index, value)
end


local values = {37, 60, 59, 20, 4, 10, 100, 75, 83}

for index, value in pairs(values) do
	value %= 2
	if value == 1 then --Odd number
		values[index] *= 2
	end
end

print(values)


local items = workspace:GetDescendants()

for _, object in pairs(items) do
	if object:IsA("BasePart") then
		object.Anchored = true
	end
end


local num = 0
while num < 10 do
	num += 1
end

print(num) 


local timeElapsed = 0

while true do
	task.wait(1)
	timeElapsed += 1
	print(timeElapsed)
end


local num = 12

repeat
	num -= 1
until num == 0

print(num)
