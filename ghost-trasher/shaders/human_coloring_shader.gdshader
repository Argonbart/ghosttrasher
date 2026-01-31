shader_type canvas_item;

uniform vec4 flex_color : source_color;
uniform vec4 new_color : source_color;
uniform int world_state = 0;

void fragment() {
	float color_diff = length(flex_color.rgb - COLOR.rgb);
	if (world_state == 0 && color_diff < 0.05) {
		COLOR = new_color;
	}
	if (world_state == 1 && COLOR == vec4(0.0, 0.0, 0.0, 1.0)) {
		COLOR = vec4(1.0, 1.0, 1.0, 1.0);
	}
}