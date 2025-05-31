@tool
extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var item: Item

func _ready() -> void:
	if item:
		sprite_2d.texture = item.texture
