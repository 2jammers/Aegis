-- TODO: Use this as a runtime storage manager.
-- // Folders
local Types = script.Parent.Parent.Types

-- // Dependencies
local InternalTypes = require(Types.InternalTypes)

-- // Variables
local Storage = {
	Scheduler = {
		Server = { Connection = nil, Active = {} },
		Client = { Connection = nil, Active = {} },
	} :: Scheduler,
	AnimatableDataTypes = {
		number = {
			ToLinear = function(value: number)
				return { value }
			end,
			FromLinear = function(value: { number })
				return value[1]
			end,
		},
		Vector3 = {
			ToLinear = function(value: Vector3)
				return { value.X, value.Y, value.Z }
			end,

			FromLinear = function(value: { number })
				return Vector3.new(value[1], value[2], value[3])
			end,
		},
		Vector2 = {
			ToLinear = function(value: Vector2)
				return { value.X, value.Y }
			end,

			FromLinear = function(value: { number })
				return Vector2.new(value[1], value[2])
			end,
		},
		UDim2 = {
			ToLinear = function(value: UDim2)
				return { value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset }
			end,

			FromLinear = function(value: { number })
				return UDim2.new(value[1], value[2], value[3], value[4])
			end,
		},
		UDim = {
			ToLinear = function(value: Vector2)
				return { value.X, value.Y }
			end,

			FromLinear = function(value: { number })
				return UDim.new(value[1], value[2])
			end,
		},
	} :: AnimatableDataTypes,
}

-- // Types
type AnimatableDataTypes = {
	[string]: {
		ToLinear: (value: InternalTypes.Animatable) -> { number },
		FromLinear: (value: { number }) -> InternalTypes.Animatable,
	},
}
type Scheduler = {
	[string]: { Connection: RBXScriptConnection?, Active: { [number]: (deltaTime: number) -> () } },
}
-- // Returning
return Storage
