extends Resource
class_name Inventory

var items: Array[Item]

func _init(size: int) -> void:
	items.resize(size)
