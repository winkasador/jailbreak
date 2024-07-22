class_name PlayerDebugContoller extends Node2D

@export var camera: Camera2D
@export var animation_controller: CharacterAnimationController
@export var character_body: CharacterBody2D
@export var collision_area: CollisionShape2D
@export var camera_zoom_speed: float = 2

var is_click_tp_enabled: bool = false
var is_noclip_enabled: bool = false

func _physics_process(delta: float) -> void:
	if(Input.is_action_pressed("debug_key")):
		if(Input.is_action_just_pressed("debug_toggle_click_tp")):
			is_click_tp_enabled = !is_click_tp_enabled
			print("[Debug] Turned click teleportation %s." % ["on" if is_click_tp_enabled else "off"])
		
		if(Input.is_action_just_pressed("debug_force_spin") and animation_controller):
			animation_controller.do_spin_effect()
			print("[Debug] Spun Player")
		
		if(Input.is_action_just_pressed("debug_noclip") and collision_area):
			is_noclip_enabled = !is_noclip_enabled
			collision_area.disabled = is_noclip_enabled
			character_body.modulate.a = 0.4 if is_noclip_enabled else 1
			print("[Debug] Turned noclip %s." % ["on" if is_noclip_enabled else "off"])
		
		if(Input.is_action_pressed("debug_zoom_in") and camera):
			var zoom: float = clamp(camera.zoom.x - camera_zoom_speed * delta, 1, 4)
			camera.zoom = Vector2(zoom, zoom)
		elif(Input.is_action_pressed("debug_zoom_out") and camera):
			var zoom: float = clamp(camera.zoom.x + camera_zoom_speed * delta, 1, 4)
			camera.zoom = Vector2(zoom, zoom)

func _unhandled_input(event):
	if(is_click_tp_enabled and character_body):
		if(event is InputEventMouseButton and event.is_pressed()):
			if(event.button_index == MOUSE_BUTTON_RIGHT):
				var mouse_pos = get_global_mouse_position()
				character_body.global_position = mouse_pos
				print("[Debug] Teleported Player to (%.1f, %.1f)." % [character_body.position.x, character_body.position.y])
