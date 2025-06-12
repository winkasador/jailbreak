extends Sprite2D

@export var use_custom_cursor: bool

func _ready() -> void:
	if use_custom_cursor:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	if use_custom_cursor:
		var mouse_pos = get_viewport().get_mouse_position()
		position = mouse_pos.floor()
