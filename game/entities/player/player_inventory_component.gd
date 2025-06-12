extends Node
class_name PlayerInventoryComponent

const RED_KEY = preload("res://game/items/red_key.tres")

@onready var player: Player = $".."

@export var capacity: int = 6

var selected_index: int = -1
var inventory: Inventory

func _ready() -> void:
	inventory = Inventory.new(capacity)
	inventory.add(RED_KEY, 0)
	player.add_component("inventory", self)

func try_select_index(index: int) -> void:
	if inventory.items[index]:
		selected_index = index

func try_drop_index(index: int) -> void:
	if inventory.items[index]:
		var drop_position = GameManager.get_instance().player.global_position
		var result = GameManager.get_instance().try_drop_item(inventory.items[index], drop_position)
		if result:
			inventory.remove(index)
			if selected_index == index:
				selected_index = -1
