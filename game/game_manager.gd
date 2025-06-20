extends Node2D
class_name GameManager

const DROPPED_ITEM = preload("res://game/items/dropped_item.tscn")

@onready var tiles: TileMapLayer = $Floors/GroundFloor/Tiles
@onready var ground_floor: Node2D = $Floors/GroundFloor
@onready var transitions: CanvasLayer = $Transitions
@onready var camera_2d: Camera2D = $Camera2D

@export var player: Player

static var _instance: GameManager

var interactables: Array[Control]

func _ready() -> void:
	_instance = self
	interactables = []
	await get_tree().process_frame
	transitions.fade_in()

func try_drop_item(item: Item, position: Vector2) -> bool:
	var tile_position = (position / 16).floor()
	
	if is_tile_obstructed(tile_position):
		return false
	
	var drop_position = tile_position * 16 + Vector2(8, 8)
	
	var dropped_item = DROPPED_ITEM.instantiate()
	dropped_item.item = item
	dropped_item.position = drop_position
	ground_floor.add_child(dropped_item)
	return true

func is_tile_obstructed(tile_position: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	
	var shape = RectangleShape2D.new()
	shape.size = Vector2(8, 8)
	
	var transform = Transform2D()
	transform.origin = (tile_position * 16) + Vector2(8, 8)
	
	var params = PhysicsShapeQueryParameters2D.new()
	params.shape = shape
	params.transform = transform
	params.collision_mask = 1 | 5
	params.exclude = [player]
	
	var result = space_state.intersect_shape(params, 1)
	
	return !result.is_empty()

func get_camera() -> Camera2D:
	return camera_2d

func mouse_click(button_mask: int, position: Vector2):
	for node: Control in interactables:
		if node:
			var rect: Rect2 = Rect2(node.global_position, node.size)
			if rect.has_point(position):
				node.on_interaction(button_mask)
				return

func mouse_motion(position: Vector2):
	for node: Control in interactables:
		if node:
			var rect: Rect2 = Rect2(node.global_position, node.size)
			if rect.has_point(position):
				UIManager.get_instance().set_tooltip(node.hover_message)
				return
	UIManager.get_instance().set_tooltip("")

static func get_instance() -> GameManager:
	return _instance
