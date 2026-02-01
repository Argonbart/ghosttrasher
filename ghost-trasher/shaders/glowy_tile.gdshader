shader_type canvas_item;

uniform vec4 flex_color: source_color;

void fragment() {
	
	float color_diff = length(flex_color.rgb - COLOR.rgb);
	
	if (COLOR.a > 0.0 && color_diff < 0.05) {
		COLOR.rgb = vec3(0.8, 0.8, 0.8);
		COLOR.a = 0.1;
	}
}