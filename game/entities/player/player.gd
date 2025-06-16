extends CharacterBody2D
class_name Player

## px/frame
@export var move_speed = 3 # Orignal value is possibly 2 (at 45 FPS)
@export var diagonal_move_speed = 2 # Orignal value is possibly 2 (at 45 FPS)

var destination: Node2D
var use_object: Node2D
var last_direction: Vector2
var components: Dictionary[String, Node]

# Player States #
# Moving
# Sleeping
# Ziplining
# Hiding
# Occupied
# KnockedOut

func _physics_process(delta: float) -> void:
	var vector = _calculate_movement_vector()
	var speed = vector
	
	var length = vector.length_squared()
	if vector and length > 0:
		last_direction = vector
	
	if length <= 1:
		speed = vector * move_speed
	else:
		speed = vector * diagonal_move_speed
	
	if speed.x != 0:
		var collision = move_and_collide(Vector2(speed.x, 0))
	if speed.y != 0:
		var collision = move_and_collide(Vector2(0, speed.y))

func _calculate_movement_vector() -> Vector2:
	var vector: Vector2
	if Input.is_action_pressed("move_down"):
		vector.y = 1
	elif Input.is_action_pressed("move_up"):
		vector.y = -1
	if Input.is_action_pressed("move_right"):
		vector.x = 1
	elif Input.is_action_pressed("move_left"):
		vector.x = -1
	
	return vector

func get_component(id: String) -> Node:
	return components[id]

func add_component(id: String, component: Node) -> void:
	components.set(id, component)
