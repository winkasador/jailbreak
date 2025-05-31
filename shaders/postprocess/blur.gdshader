shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform float strength: hint_range(0.0, 5) = 0.0;
uniform float brightness: hint_range(0.0, 1.0) = 1.0;
// Applies the blur onto the texture rather than replacing the texture.
uniform bool burn = false;

void fragment(){
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV, strength);
	color.rgb *= brightness;
	if(burn) {
		COLOR *= color;
	}
	else {
		COLOR = color;
	}
}