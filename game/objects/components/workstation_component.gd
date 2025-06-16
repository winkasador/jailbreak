extends Node
class_name WorkstationComponent

@export var input: Item
@export var output: Item
@export var time: float = 5 * 45
@export var trigger: InteractionComponent

var held_item: Item = null
var time_remaining: int

func start() -> void:
	time_remaining = time

func collect_item() -> void:
	if GameManager.get_instance().player.get_component("inventory").inventory.add_to_empty(held_item):
		held_item = null

func _ready() -> void:
	if trigger:
		trigger.on_interact.connect(interact)

func _process(delta: float) -> void:
	if time_remaining > 0:
		time_remaining - 1

func interact():
	if time_remaining != 0:
		return
	
	if held_item:
		collect_item()
	else:
		start()
