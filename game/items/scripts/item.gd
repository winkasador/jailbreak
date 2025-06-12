extends Resource
class_name Item

@export var id: String
@export var texture: Texture2D
@export var contraband_level: ContrabandLevel

enum ContrabandLevel {
	## You are allowed to have this.
	Allowed = 0,
	## Will be confiscated if discovered. Will be sent to solitary if in desk.
	Disallowed = 1,
	## Like disallowed, but will trigger solitary if it's discovered anywhere.
	Illegal = 2
}

func is_illegal() -> bool:
	return contraband_level > 0
