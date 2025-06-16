extends Node

@export var interaction_component: InteractionComponent
@export var items: Array[Item]

func _ready() -> void:
	if interaction_component:
		interaction_component.on_interact.connect(on_interact)

func on_interact():
	if items.size() < 0:
		return
	var item = items[randi_range(0, items.size() - 1)]
	GameManager.get_instance().player.get_component("inventory").inventory.add_to_empty(item)
