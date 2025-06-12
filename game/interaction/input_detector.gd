extends Control

func _ready() -> void:
	visible = false # This node blocks input if visible for some reason

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		var world_position = Vector2(320, 240) * (event.position / size)
		world_position += GameManager.get_instance().get_camera().position - Vector2(320, 240) / 2
		world_position = world_position.floor()
		world_position += Vector2(12, 8)
		if event is InputEventMouseButton:
			GameManager.get_instance().mouse_click(event.button_mask, world_position)
		if event is InputEventMouseMotion:
			GameManager.get_instance().mouse_motion(world_position)
