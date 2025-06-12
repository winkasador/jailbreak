extends Control
class_name UIManager

@onready var info_bubble: InfoBubble = $UIBase/Control/InfoBubble
@onready var tooltip: NinePatchRect = $UIBase/Cursor/Tooltip

var active_panel: Control

static var _instance: UIManager

func _ready() -> void:
	_instance = self

func display_info_bubble(message: String):
	info_bubble.set_message(message)

func set_tooltip(message: String):
	if message == "":
		tooltip.label.text = ""
		tooltip.visible = false
	else:
		tooltip.label.text = message
		tooltip.visible = true

static func get_instance():
	return _instance
