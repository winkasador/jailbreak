class_name PlayerTeleportationEffect extends Sprite2D

@onready var shader = preload("res://shaders/teleportation_burn_mark.gdshader")

@export var decay_time: float = 3
var time_left: float

func _ready() -> void:
	time_left = decay_time
	material = ShaderMaterial.new()
	material.shader = shader 

func _process(delta: float) -> void:
	time_left -= delta
	modulate.a = clamp(time_left / decay_time, 0, 1)
	if(time_left <= 0):
		queue_free()
