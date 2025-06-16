extends Control

const ITEM_SLOT = preload("res://game/inventory/item_slot.tscn")

var component: PlayerInventoryComponent
var inventory: Inventory
var slots: Array[ItemSlot]

var default_padding: int = 24

func _ready() -> void:
	await get_tree().process_frame
	
	component = GameManager.get_instance().player.get_component("inventory")
	inventory = component.inventory
	
	_init_slots()

func _process(delta: float) -> void:
	for i in range(0, inventory.items.size()):
		slots[i].set_item(inventory.items[i])
		if component.selected_index == i:
			slots[i].is_selected = true
		else:
			slots[i].is_selected = false

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

func _on_slot_select_request(index: int):
	component.try_select_index(index)

func _on_item_drop_request(index: int):
	component.try_drop_index(index)
