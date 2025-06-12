extends Area2D

@export var message: String = "This is a message."

var is_active: bool = true

func _on_body_entered(body: Node2D) -> void:
	if is_active:
		if body is Player:
			UIManager.get_instance().display_info_bubble(message)
			is_active = false
