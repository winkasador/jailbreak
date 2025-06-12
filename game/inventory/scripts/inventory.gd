extends Resource
class_name Inventory

var items: Array[Item]

func _init(size: int) -> void:
	items.resize(size)

func add(item: Item, index: int) -> void:
	items[index] = item

func add_to_empty(item: Item) -> bool:
	for i in range(0, items.size()):
		if items[i] == null:
			items[i] = item
			return true
	return false

func remove(index: int) -> void:
	items[index] = null
