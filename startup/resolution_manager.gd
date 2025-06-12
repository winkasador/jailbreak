extends Node
class_name ResolutionManager

@onready var gameplay_viewport_container: SubViewportContainer = $"../CanvasLayer/SubpixelGameContainer"
@onready var ui_viewport_container: SubViewportContainer = $"../CanvasLayer/SubpixelUserInterfaceContainer"

@export var integer_scaling: bool = false
@export var use_hd_mode: bool = false

static var _instance: ResolutionManager

func _ready() -> void:
	_instance = self
	
	_update()

func _process(delta: float) -> void:
	_update()

func _update():
	var size = DisplayServer.window_get_size()
	var width: float = size.x / 320.0
	var height: float = size.y / 240.0
	
	if integer_scaling:
		var scale_factor: int = min(width, height)
		_set_viewport_scale(Vector2(scale_factor, scale_factor))
	else:
		_set_viewport_scale(Vector2(width, height))

func _set_viewport_scale(scale: Vector2):
	gameplay_viewport_container.scale = scale
	ui_viewport_container.scale = scale

static func get_instance() -> ResolutionManager:
	return _instance
