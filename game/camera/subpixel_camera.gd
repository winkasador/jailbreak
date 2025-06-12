extends Camera2D

@export var follow_target: Node2D
@export var smoothing_rate: float = 3
## Remaining distance to the follow target where the camera will instantly snap to its position.
## This is to prevent ugly visual artifacts when the camera is moving a tiny amount each frame.
@export var snap_distance: float = 0.15

var real_position: Vector2

func _process(delta: float) -> void:
	if follow_target:
		global_position = follow_target.global_position
		
		real_position = real_position.lerp(follow_target.global_position, delta * smoothing_rate)
		if real_position.distance_to(follow_target.global_position) < snap_distance:
			real_position = follow_target.global_position
		
		# clamp real position
		var limit_min = Vector2(limit_left, limit_top)
		var limit_max = Vector2(limit_right, limit_bottom)
		var screen_half = get_viewport_rect().size * 0.5 / zoom

		var min_camera = limit_min + screen_half
		var max_camera = limit_max - screen_half

		real_position = real_position.clamp(min_camera, max_camera)
		
		var subpixel_offset = real_position.round() - real_position
		ResolutionManager.get_instance().gameplay_viewport_container.material.set_shader_parameter("camera_offset", subpixel_offset)
		
		global_position = real_position.round()
