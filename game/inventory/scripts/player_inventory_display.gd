extends Control

const ITEM_SLOT = preload("res://game/inventory/item_slot.tscn")

var inventory: Inventory
var slots: Array[ItemSlot]

var default_padding: int = 24

func _ready() -> void:
	await get_tree().process_frame
	
	inventory = GameManager.get_instance().player.inventory
	
	_init_slots()
	_update_display()

func _init_slots():
	slots = []
	
	for i in range(0, inventory.items.size()):
		var slot = ITEM_SLOT.instantiate()
		await add_child(slot)
		slot.position = Vector2(1, 1 + (i * default_padding))
		slot.index = i
		slot.show_index()
		slot.connect("drop_item", _on_item_drop_request)
		slot.connect("select_item", _on_slot_select_request)
		slots.append(slot)

func _update_display():
	for i in range(0, inventory.items.size()):
		slots[i].item = inventory.items[i]

func _on_slot_select_request(index: int):
	for slot in slots:
		slot.is_selected = false
	slots[index].is_selected = true

func _on_item_drop_request(index: int):
	if slots[index].item:
		GameManager.get_instance().try_drop_item(slots[index].item, GameManager.get_instance().player.global_position)
