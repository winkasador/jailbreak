extends Node
class_name DoorVisibilityComponent

@onready var sprite_2d: Sprite2D = $Sprite2D

var bodies: int = 0

func _process(delta: float) -> void:
	if bodies > 0:
		sprite_2d.visible = false
	else:
		sprite_2d.visible = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		bodies += 1

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		bodies -= 1
