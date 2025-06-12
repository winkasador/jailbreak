extends NinePatchRect

@onready var label: Label = $Label

func _process(delta: float) -> void:
	if visible:
		size.x = label.size.x + 6
		size.y = 16
		
		var mouse_position = get_parent().position
