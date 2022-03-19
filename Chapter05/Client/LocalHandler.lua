local returnModFunc = script.ReturnMod
local modules = {}

for _, module in pairs(script:GetChildren()) do
	if module:IsA("ModuleScript") then
		task.defer(function()
			modules[module.Name] = require(module)
		end)
	end
end

returnModFunc.OnInvoke = function(name)
	return modules[name] or require(script:FindFirstChild(name))
end
