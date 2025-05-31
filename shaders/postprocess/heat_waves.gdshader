shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_nearest;

uniform float speed: hint_range(0.0, 1.0, 0.01) = 0.1;
uniform float strength: hint_range(1.0, 2.0, 0.01) = 1.2;

void fragment() {
	float time = TIME * speed;
	float offset = float(int(sin((SCREEN_UV.y + time) * 100.0) * strength));

	vec2 uv = SCREEN_UV;
	uv.x += SCREEN_PIXEL_SIZE.x * offset;

	COLOR = texture(screen_texture, uv);
}
