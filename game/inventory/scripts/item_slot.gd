extends TextureRect
class_name ItemSlot

@onready var item_texture: TextureRect = $HeldItemTexture
@onready var number: AnimatedSprite2D = $SlotDigit
@onready var selection_highlight_sprites: AnimatedSprite2D = $SelectionHighlightSprites

signal select_item(index: int)
signal drop_item(index: int)

var item: Item
var is_selected: bool
var index: int

func _process(delta: float) -> void:
	if is_selected:
		selection_highlight_sprites.visible = true
		selection_highlight_sprites.play()
	else:
		selection_highlight_sprites.visible = false

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			select_item.emit(index)
		elif event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			drop_item.emit(index)

func show_index():
	number.visible = true
	number.frame = index + 1

func set_item(item: Item):
	self.item = item
	if item:
		item_texture.texture = item.texture
	else:
		item_texture.texture = null
