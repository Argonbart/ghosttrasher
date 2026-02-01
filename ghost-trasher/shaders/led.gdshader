shader_type canvas_item;

uniform int world_state = 0;
uniform float gray_factor: hint_range(1.0, 50.0, 1.0) = 1.0;
uniform float alpha_value: hint_range(0.0, 1.0, 0.001) = 0.5;

uniform vec4 flex_color: source_color;
uniform vec4 new_color: source_color;
uniform float alpha_min_value: hint_range(0.0, 1.0, 0.001) = 0.4;
uniform float alpha_max_value: hint_range(0.0, 1.0, 0.001) = 0.8;
uniform float blink_speed: hint_range(0.0, 10.0, 0.1) = 2.0;
uniform float color_change_speed: hint_range(0.001, 1.0, 0.001) = 0.1;
uniform float speed = 1.0;

void fragment() {
	
	// Time-based hue rotation
	float t = TIME * speed;
	
	// Convert time to RGB via phase-shifted sine waves
	vec3 color;
	color.r = 0.5 + 0.5 * sin(t + 0.0);
	color.g = 0.5 + 0.5 * sin(t + 2.094); // 120°
	color.b = 0.5 + 0.5 * sin(t + 4.188); // 240°
	color *= new_color.rgb;
	
	float blink_speed_vary = blink_speed + ((sin(TIME) / 2.0) + 0.5) * 0.1;
	float color_diff = length(flex_color.rgb - COLOR.rgb);
	if (COLOR.a > 0.0 && color_diff < 0.05) {
		COLOR.rgb = color;
		COLOR.a = alpha_min_value + ((sin(TIME * blink_speed_vary) / 2.0) + 0.5) * (alpha_max_value - alpha_min_value);
	}
	
	// ghost world condition
	if (world_state == 1 && COLOR.a > 0.0) {
		float color_average = (COLOR.r + COLOR.g + COLOR.b) / gray_factor;
		COLOR = vec4(color_average, color_average, color_average, alpha_value);
	}
}