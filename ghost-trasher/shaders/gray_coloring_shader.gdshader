shader_type canvas_item;

// others
uniform int world_state = 0;
uniform float gray_factor: hint_range(1.0, 50.0, 1.0) = 1.0;
uniform float alpha_value: hint_range(0.0, 1.0, 0.001) = 0.5;

void fragment() {
	
	// ghost world condition
	if (world_state == 1 && COLOR.a > 0.0) {
		float color_average = (COLOR.r + COLOR.g + COLOR.b) / gray_factor;
		COLOR = vec4(color_average, color_average, color_average, alpha_value);
	}
}