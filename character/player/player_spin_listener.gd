class_name PlayerSpinListener extends Node

@export var spin_threshold = 8
@export var animation_controller: CharacterAnimationController

var direction_history = []
var max_history_length = 10

# Function to update direction history
func update_direction_history(direction):
	direction_history.append(direction)
	if direction_history.size() > max_history_length:
		direction_history.pop_front()

# Function to check for rapid direction changes
func is_spinning_quickly():
	var changes = 0
	for i in range(1, direction_history.size()):
		if direction_history[i] != direction_history[i - 1]:
			changes += 1
	
	return changes >= spin_threshold

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1

	if direction != Vector2.ZERO:
		update_direction_history(direction)

	if is_spinning_quickly():
		direction_history = []
		animation_controller.do_spin_effect()
