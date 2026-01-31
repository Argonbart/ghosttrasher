shader_type canvas_item;

uniform vec4 flower_color_1: source_color;
uniform vec4 flower_color_2: source_color;
uniform vec4 flower_color_3: source_color;
uniform vec4 flower_color_4: source_color;
uniform vec4 flower_color_5: source_color;
uniform vec4 flower_color_6: source_color;

uniform int world_state = 0;

void fragment() {
	float color_diff_1 = length(flower_color_1.rgb - COLOR.rgb);
	float color_diff_2 = length(flower_color_2.rgb - COLOR.rgb);
	float color_diff_3 = length(flower_color_3.rgb - COLOR.rgb);
	float color_diff_4 = length(flower_color_4.rgb - COLOR.rgb);
	float color_diff_5 = length(flower_color_5.rgb - COLOR.rgb);
	float color_diff_6 = length(flower_color_6.rgb - COLOR.rgb);
	if (world_state == 1  && (color_diff_1 < 0.05 || color_diff_2 < 0.05 || color_diff_3 < 0.05 || color_diff_4 < 0.05 || color_diff_5 < 0.05 || color_diff_6 < 0.05)) {
		float color_average = ((COLOR.r + COLOR.g + COLOR.b) / 3.0) / 30.0;
		COLOR = vec4(color_average, color_average, color_average, 1.0);
	} else if (world_state == 1 && COLOR.a > 0.0) {
		COLOR *= 0.6;
	}
}