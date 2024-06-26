-- State types
export type StateClass = {
	Get: <T>(self: StateInternal) -> T,
	Set: (self: StateInternal, newValue: any) -> (),
	Listen: (self: StateInternal, fn: (oldValue: any, newValue: any) -> ()) -> (),
}

export type StateInternal = {
	AegisName: "State",

	_state: any,
	_listeners: { (oldValue: any, newValue: any) -> () },
	_protectType: boolean,
} & StateClass & API<StateInternal>

-- Spring types
export type SpringClass<State> = {
	_update: (self: SpringInternal<State>, linearTargetPosition: { number }, delta: number) -> (),
	Get: (self: SpringInternal<State>) -> (),
}

export type SpringInternal<State> = {
	AegisName: "Spring",

	_type: string,
	_state: State,
	_damping: number,
	_velocity: number,
	_frequency: number,
	_currentLinearPosition: { number },
} & SpringClass<State> & API<SpringInternal<State>>

-- Extra
export type Key = {
	AegisClass: "Key",
	AegisName: string,
	Apply: (instance: Instance, index: any, value: any) -> (),
}

export type API<self> = {
	AegisClass: "API",
	AegisName: string,
	_apply: (self: self, prop: string, instance: Instance) -> (),
}

export type Animatable = number | UDim2 | UDim | Vector3 | Vector3int16 | Vector2 | Vector2int16

return "Aegis.Types.Internal"
