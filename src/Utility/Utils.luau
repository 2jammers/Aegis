-- // Dependencies
local Debugger = require(script.Parent.Debugger)
local Keys = require(script.Parent.Parent.Keys)

-- // Variables
local Utils = {}

-- // Functions
function Utils.ApplyNormalProperty(instance: Instance, prop: string, value: any): ()
	-- Check if type matches
	if typeof((instance :: any)[prop]) ~= typeof(value) then
		Debugger.Warn("TypeMismatch", typeof((instance :: any)[prop]), typeof(value))
		return
	end

	(instance :: any)[prop] = value -- And set the value
end

function Utils.ApplySpecialKeyProperty(instance: Instance, prop: {}, value: any): ()
	local Key = Keys[(prop :: any).AegisType] or nil

	if Key ~= nil then
		Key.Apply(instance, prop, value, Utils)
	else
		Debugger.Warn("MissingChild", `Aegis.Keys.{(prop :: any).AegisType}`, script.Parent.Keys:GetFullName())
	end
end

function Utils.GetAndSetAtPath(self: {}, path: string, optionalValue: any?): any
	-- Split the path by "/" and create a new variable to reference the self.__state table
	local Paths = string.split(path, "/")
	local Current = (self :: any).__state

	for index, key in Paths do
		--[[
			If the index is at the last index of the Paths table and optionalValue is provided
			and after indexing, Current[key] is not nil, set it to the new value.
		]]
		if index == #Paths then
			local Old = Current[key] -- A variable just needed for checking Current[key]

			if optionalValue and Old then
				if (self :: any).__protectType and typeof(Old) ~= typeof(optionalValue) then
					Debugger.Warn("TypeMismatch", typeof(Old), typeof(optionalValue))
					continue
				else
					Current[key] = optionalValue
				end
			end

			Current = Current[key] -- Optional value wasn't provided, set it regardless
		end

		Current = Current[key] -- If it does not meet the above checks just set it normally.
	end

	return Current
end

-- // Returning
return Utils