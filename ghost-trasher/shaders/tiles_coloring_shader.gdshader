shader_type canvas_item;

uniform int world_state = 0;

void fragment() {
	if (world_state == 1) {
		COLOR *= 0.6;
	}
}