shader_type canvas_item;

uniform vec4 normal_color: source_color;
uniform vec4 floor_color: source_color;

uniform vec4 flex_color_1: source_color;
uniform vec4 flex_color_2: source_color;
uniform vec4 flex_color_3: source_color;

uniform vec4 new_color_1: source_color;
uniform vec4 new_color_2: source_color;
uniform vec4 new_color_3: source_color;

uniform int world_state = 0;
uniform float gray_factor: hint_range(1.0, 50.0, 1.0) = 1.0;
uniform float alpha_value: hint_range(0.0, 1.0, 0.001) = 0.5;

uniform float glow_factor: hint_range(0.0, 10.0, 0.1) = 2.0;

void fragment() {
	
	float color_diff_1 = length(flex_color_1.rgb - COLOR.rgb);
	float color_diff_2 = length(flex_color_2.rgb - COLOR.rgb);
	float color_diff_3 = length(flex_color_3.rgb - COLOR.rgb);
	float color_diff_4 = length(floor_color.rgb - COLOR.rgb);
	
	if (world_state == 0 && COLOR.a > 0.0) {
		if (color_diff_1 < 0.05 || color_diff_2 < 0.05 || color_diff_3 < 0.05) {
			COLOR = normal_color;
		}
	}
	
	// ghost world condition
	if (world_state == 1 && COLOR.a > 0.0) {
		
		if (color_diff_1 < 0.05) {
			COLOR.rgb = new_color_1.rgb * glow_factor;
		} else if (color_diff_2 < 0.05) {
			COLOR.rgb = new_color_2.rgb * glow_factor;
		} else if (color_diff_3 < 0.05) {
			COLOR.rgb = new_color_3.rgb * glow_factor;
		} else {
			float color_average = (COLOR.r + COLOR.g + COLOR.b) / gray_factor;
			COLOR = vec4(color_average, color_average, color_average, alpha_value);
		}
	}
}