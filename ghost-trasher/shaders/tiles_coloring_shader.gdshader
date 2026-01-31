shader_type canvas_item;

uniform bool active = false;

void fragment() {
	if (!active) {
		COLOR *= 0.6;
	}
}