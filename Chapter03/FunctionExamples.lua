local random = Random.new()

local function fillStoreSupply()
	local storeSupply = {}

	for i = 1, 10 do
		local ranVal = random:NextInteger(1,3)
		local item
    
		if ranVal == 1 then 
			item = "Fruit" 
		elseif ranVal == 2 then 
			item = "Vegetable" 
		else 
			item = "Shoe" 
		end 

			table.insert(storeSupply, item)
		end

	return storeSupply
end

local supplyTable = fillStoreSupply()


local function factorial(n)
	assert(n == math.floor(n), "n must be a whole number.")

	local factorial = 1 --Empty product should be 1
	while n > 1 do
		factorial *= n
		n -= 1
	end

	return factorial
end

print(factorial(12))


local function sum(...)
	local args = {...}
	local sum = 0
	
	for _, number in pairs(args) do
		sum += number
	end

	return sum
end

local num = sum(7, 9, 12, 3, 2, 6, 13)
print(num)


local timeElapsed = 0
task.defer(function()
	while task.wait(1) do
		timeElapsed += 1
		print(timeElapsed)
	end
end)

print("Code after loop can still execute!")


local function factorial(n)
	assert(n == math.floor(n), "n must be a whole number.")

	if n <= 1 then
		return 1
	else
		return n * factorial(n - 1)
	end
end

print(factorial(6))


local function checkEquality(table1, table2)
	print("Variable 1: ".. tostring(table1))
	print("Variable 2: ".. tostring(table2))
	print("First and second variable same table = ".. tostring(table1 == table2))
end

local group = {"Ashitosh", "Grey", "Manish", "Meenakshi"}
local groupClone = group
checkEquality(group, groupClone)


local items = {
	Egg = {fragile = true;};
	Water = {wet = true};
}

local function recursiveCopy(targetTable)
	local tableCopy = {}
	for index, value in pairs(targetTable) do
		if type(value) == "table" then
			value = recursiveCopy(value)
		end
		tableCopy[index] = value
	end

	return tableCopy
end

local itemsClone = recursiveCopy(items)
checkEquality(items, itemsClone)
