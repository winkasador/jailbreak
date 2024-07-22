class_name PlayerMovementInput extends Node

@export var character_body: CharacterBody2D
@export var movement_stats: CharacterMovementStats = CharacterMovementStats.new()

func _physics_process(delta: float) -> void:
	if(character_body and not Input.is_action_pressed("debug_key")):
		var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if(input.length() > 0):
			character_body.velocity = character_body.velocity.move_toward(
				input * movement_stats.max_speed, 
				movement_stats.acceleration * delta)
		else:
			character_body.velocity = character_body.velocity.move_toward(Vector2.ZERO, movement_stats.friction * delta)
