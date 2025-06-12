shader_type canvas_item;

uniform float progress: hint_range(0.0, 1.0, 0.01);

void fragment() {
	COLOR.rgb = vec3(0.0, 0.0, 0.0);
	float p = FRAGCOORD.x / (320.0 / 2.0);
	if(p <= progress) {
		COLOR.a = 1.0;
	}
	else {
		COLOR.a = 0.0;
	}
}