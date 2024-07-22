class_name CharacterMovementController extends Node

@export var character_body: CharacterBody2D

func _physics_process(delta: float) -> void:
	character_body.move_and_slide()
