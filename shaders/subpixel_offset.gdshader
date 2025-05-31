// Used to offset the full resolution camera between pixels to imitate camera smoothing. //

shader_type canvas_item;

uniform vec2 camera_offset = vec2(0.0, 0.0);

void vertex() {
	VERTEX += camera_offset;
}