extends Node

@onready var dropped_item: Node2D = $".."

func _on_interaction_component_on_interact() -> void:
	var result = GameManager.get_instance().player.get_component("inventory").inventory.add_to_empty(dropped_item.item)
	if result:
		get_parent().queue_free()
