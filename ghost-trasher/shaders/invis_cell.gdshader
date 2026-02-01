shader_type canvas_item;

uniform vec4 flex_color: source_color;
uniform float alpha_value: hint_range(0.0, 1.0, 0.1) = 0.0;

void fragment() {
	
	float color_diff = length(flex_color.rgb - COLOR.rgb);
	
	if (COLOR.a > 0.0 && color_diff < 0.05) {
		COLOR.a = alpha_value;
	}
}