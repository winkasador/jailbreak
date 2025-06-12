extends Control
class_name InteractionComponent

@onready var dropped_item: Node2D = $".."

@export var hover_message: String

signal on_interact

func _ready() -> void:
	await get_tree().process_frame
	hover_message = dropped_item.item.id
	GameManager.get_instance().interactables.append(self)

func on_interaction(button: int):
	if button == MOUSE_BUTTON_MASK_LEFT:
		on_interact.emit()
