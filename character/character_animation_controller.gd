class_name CharacterAnimationController extends Node

@export_group("References")
@export var character_body: CharacterBody2D
@export var animation_tree: AnimationTree

@export_group("Spin")
## Should this character be allowed to do a spin animation?
## (Intended for use by the player, mainly.)
@export var allow_spin: bool = true
## How fast the character will start spinning.
## This number also effects how long the character will spin for.
@export_range(0, 200) var base_spin_velocity: int = 100
## How fast the character's spin will slow down.
## The higher the number, the slower the rate of decrease.
## (Setting this to 1 will cause the character to spin forever, so don't do that.)
@export_range(0, 0.9999) var spin_velocity_decay: float = 0.98
@export_range(0, 100) var spin_end_threshold: float = 0.8
@export_range(0, 100) var spin_cancel_threshold: float = 25
@export_range(0, 20000) var spin_cancel_required_magnitude: int = 6000

@onready var state_machine = animation_tree["parameters/playback"]

enum {WALK}
var state = WALK

var blend_position: Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/walk/walk_blendspace2d/blend_position"
]
var animtree_state_keys = [
	"walk"
]

var spin = 0.0
var spin_velocity = 0

func _physics_process(delta) -> void:
	var velocity = character_body.velocity
	
	if(velocity != Vector2.ZERO):
		state = WALK
		blend_position = velocity
	
	if(spin_velocity > 0 and allow_spin):
		if(spin_velocity < spin_cancel_threshold 
		and character_body.velocity.distance_squared_to(Vector2.ZERO) > spin_cancel_required_magnitude):
			spin = 0
			spin_velocity = 0
		
		state = WALK
		spin += spin_velocity * delta
		
		# Calculate the new blend position
		var x = (0.1 * spin) * cos(spin)
		var y = (0.1 * spin) * sin(spin)
		# Set the blend position in the BlendSpace2D
		blend_position = Vector2(x, y)
		
		# Gradually slow down the increment to slow the spin
		spin_velocity *= spin_velocity_decay
		
		if(spin_velocity <= spin_end_threshold):
			spin = 0
			spin_velocity = 0
		
	elif(velocity != Vector2.ZERO):
		state = WALK
		blend_position = velocity
	
	animate()

func animate() -> void:
	state_machine.travel(animtree_state_keys[state])
	animation_tree.set(blend_pos_paths[state], blend_position)

func do_spin_effect() -> void:
	if(allow_spin):
		spin_velocity = base_spin_velocity
