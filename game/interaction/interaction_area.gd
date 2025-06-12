extends Area2D

signal on_interaction

@export var interaction_radius: float = 16

func _input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("U")
	if event is InputEventMouseButton:
		on_interaction.emit()
