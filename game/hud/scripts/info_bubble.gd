extends NinePatchRect
class_name InfoBubble

@onready var info_bubble_label: Label = $InfoBubbleLabel

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	pass

func set_message(message: String):
	info_bubble_label.text = message
	visible = true

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			visible = false
