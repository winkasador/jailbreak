class_name PlayerDebugContoller extends Node2D

@export var character_body: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D
@export var animation_controller: CharacterAnimationController
@export var collision_area: CollisionShape2D
@export var camera: Camera2D
@export var camera_zoom_speed: float = 2

var is_click_tp_enabled: bool = false
var is_noclip_enabled: bool = false

func _physics_process(delta: float) -> void:
	# F3 needs to be pressed down in order for other debug keys to do anything.
	# For example, the noclip key is 'R', so you need to press F3+R to activate it.
	if(Input.is_action_pressed("debug_key")):
		# Toggles click teleporting, which allows the player to teleport
		# to the mouse position on right click.
		if(Input.is_action_just_pressed("debug_toggle_click_tp")):
			is_click_tp_enabled = !is_click_tp_enabled
			print("[Debug] Turned click teleportation %s." % ["on" if is_click_tp_enabled else "off"])
		
		# Initiates the player spin animation, used for testing this
		# because it can be a bit finicky.
		if(Input.is_action_just_pressed("debug_force_spin") and animation_controller):
			animation_controller.do_spin_effect()
			print("[Debug] Spun Player")
		
		# Enables noclip and toggles the visual effect (Slight transluceny).
		if(Input.is_action_just_pressed("debug_noclip") and collision_area):
			is_noclip_enabled = !is_noclip_enabled
			collision_area.disabled = is_noclip_enabled
			character_body.modulate.a = 0.4 if is_noclip_enabled else 1
			print("[Debug] Turned noclip %s." % ["on" if is_noclip_enabled else "off"])
		
		# Zoom in and out, don't allow zoom levels less than 1 or more than 4. (Default is 4)
		if(Input.is_action_pressed("debug_zoom_in") and camera):
			var zoom: float = clamp(camera.zoom.x - camera_zoom_speed * delta, 1, 4)
			camera.zoom = Vector2(zoom, zoom)
		elif(Input.is_action_pressed("debug_zoom_out") and camera):
			var zoom: float = clamp(camera.zoom.x + camera_zoom_speed * delta, 1, 4)
			camera.zoom = Vector2(zoom, zoom)

# Capture right clicks
func _unhandled_input(event):
	# Click teleporting requires this debug flag to be set first. (And something to teleport)
	if(is_click_tp_enabled and character_body):
		if(event is InputEventMouseButton and event.is_pressed()):
			if(event.button_index == MOUSE_BUTTON_RIGHT):
				var mouse_pos: Vector2 = get_global_mouse_position()
				
				# Creates an outline of the player where they teleported from as a
				# cute visual effect, the outline will fade after a couple seconds.
				# This is disabled whilst noclipping as a visual preference.
				# (because of the translucency effect when noclipping)
				if(animated_sprite and not is_noclip_enabled):
					var texture: Texture2D = animated_sprite.sprite_frames.get_frame_texture(animated_sprite.animation, animated_sprite.frame)
					GameManager._create_teleportation_shadow(character_body.position, texture)
				
				# This has something to do with screen coordinates I think.
				character_body.global_position = mouse_pos
				print("[Debug] Teleported Player to (%.1f, %.1f)." % [character_body.position.x, character_body.position.y])
