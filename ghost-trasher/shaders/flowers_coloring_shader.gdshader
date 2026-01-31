shader_type canvas_item;

uniform int world_state = 0;

void fragment() {
	if (world_state == 1 && COLOR.a > 0.0) {
		float color_average = ((COLOR.r + COLOR.g + COLOR.b) / 3.0) / 30.0;
		COLOR = vec4(color_average, color_average, color_average, 1.0);
	}
}