extends Node2D

@export var player: Player

func _process(delta: float) -> void:
	if player.destination:
		visible = true
		var angle_to_dest = global_position.angle_to_point(player.destination.global_position)
		rotation = angle_to_dest + deg_to_rad(90)
	else:
		visible = false
