extends Node

@onready var character_sprites: AnimatedSprite2D = $"../CharacterSprites"

@export var player: Player
@export var animation_tree: AnimationTree

func _process(delta: float) -> void:
	animation_tree.set("parameters/walk/blend_position", player.last_direction)
	character_sprites.play()
