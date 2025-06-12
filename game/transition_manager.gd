extends CanvasLayer

@onready var fade: TextureRect = $Curtains

@export var speed: float = 0.01

var progress: float = 0
var state: FadeState = FadeState.None

enum FadeState {
	None,
	FadingIn,
	FadingOut,
}

func _process(delta: float) -> void:
	if state == FadeState.FadingIn:
		progress -= delta * speed
		progress = max(progress, 0)
		if progress == 0:
			state = FadeState.None
	elif state == FadeState.FadingOut:
		progress += delta * speed
		progress = min(progress, 1)
		if progress == 1:
			state = FadeState.None
	
	fade.material.set_shader_parameter("progress", progress)

func fade_in() -> void:
	progress = 1
	state = FadeState.FadingIn

func fade_out() -> void:
	progress = 0
	state = FadeState.FadingOut
