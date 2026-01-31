shader_type canvas_item;

uniform vec4 flex_color : source_color;
uniform vec4 flex_color_2 : source_color;
uniform vec4 new_color : source_color;
uniform vec4 new_color_2 : source_color;
uniform int world_state = 0;

void fragment() {
	float color_diff = length(flex_color.rgb - COLOR.rgb);
	float color_diff_2 = length(flex_color_2.rgb - COLOR.rgb);
	if (world_state == 0 && color_diff < 0.05) {
		COLOR = new_color;
	}
	if (world_state == 0 && color_diff_2 < 0.05) {
		COLOR = new_color_2;
	}
	if (world_state == 1 && COLOR.a > 0.0) {
		float color_average = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
		COLOR = vec4(color_average, color_average, color_average, 0.5);
	}
}