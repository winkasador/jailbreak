extends Area2D

@export var message: String = "This is a message."

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		UIManager.get_instance().post_tutorial_message(message)
