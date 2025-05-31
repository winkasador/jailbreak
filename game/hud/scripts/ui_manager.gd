extends Control
class_name UIManager

@onready var info_bubble: InfoBubble = $UIBase/Control/InfoBubble

var active_panel: Control

static var _instance: UIManager

func _ready() -> void:
	_instance = self

func post_tutorial_message(message: String):
	info_bubble.set_message(message)

static func get_instance():
	return _instance
