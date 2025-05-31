extends CharacterBody2D
class_name Player

@export var movement_speed = 130.0

const RED_KEY = preload("res://game/items/red_key.tres")

var destination: Node2D
var use_object: Node2D
var last_direction: Vector2
var inventory: Inventory

# Player States #
# Moving
# Sleeping
# Ziplining
# Hiding
# Occupied
# KnockedOut

func _ready() -> void:
	inventory = Inventory.new(6)
	inventory.items[0] = RED_KEY

func _physics_process(delta: float) -> void:
	var vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var speed = vector * movement_speed

	if vector and vector.length() > 0:
		last_direction = vector
	
	velocity = speed

	move_and_slide()
