shader_type canvas_item;

uniform vec4 color : source_color = vec4(0.043, 0.039, 0.009, 1);

void fragment() {
	COLOR.rgb = color.rgb;
}