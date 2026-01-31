shader_type canvas_item;

uniform vec4 flex_color : source_color;
uniform vec4 new_color : source_color;
uniform int world_state = 0;

void fragment() {
	if (world_state == 0 && COLOR == flex_color) {
		COLOR = new_color;
	}
	if (world_state == 1 && COLOR == vec4(0.0, 0.0, 0.0, 1.0)) {
		COLOR = vec4(1.0, 1.0, 1.0, 1.0);
	}
}