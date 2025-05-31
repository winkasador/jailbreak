extends Camera2D

@export var follow_target: Node2D
@export var smoothing_rate: float = 3

var real_position: Vector2

func _process(delta: float) -> void:
	if follow_target:
		global_position = follow_target.global_position
		
		real_position = real_position.lerp(follow_target.global_position, delta * smoothing_rate)
		
		# clamp real position
		var limit_min = Vector2(limit_left, limit_top)
		var limit_max = Vector2(limit_right, limit_bottom)
		var screen_half = get_viewport_rect().size * 0.5 / zoom

		var min_camera = limit_min + screen_half
		var max_camera = limit_max - screen_half

		real_position = real_position.clamp(min_camera, max_camera)
		
		var subpixel_offset = real_position.round() - real_position
		get_parent().get_parent().get_parent().material.set_shader_parameter("camera_offset", subpixel_offset)
		
		global_position = real_position.round()
