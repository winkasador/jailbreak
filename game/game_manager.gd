class_name GameManager extends Node2D

static var _instance: GameManager

var player_teleportation_effect = preload("res://character/player/player_teleportation_effect.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_instance = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

static func _get_instance() -> GameManager:
	return _instance

static func _create_teleportation_shadow(position: Vector2, last_texture: Texture2D) -> void:
	var instance: PlayerTeleportationEffect = _instance.player_teleportation_effect.new()
	instance.texture = last_texture
	instance.position = position
	_instance.add_child(instance)
