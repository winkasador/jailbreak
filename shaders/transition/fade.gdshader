shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;

uniform float progress: hint_range(0.0, 1.0, 0.01);

void fragment() {
	COLOR.rgb = vec3(0.0, 0.0, 0.0);
	COLOR.a = 1.0 * progress;
}
