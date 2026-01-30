shader_type canvas_item;

uniform vec4 flex_color : source_color;
uniform vec4 new_color : source_color;
uniform bool active = false;

void fragment() {
	if (active && COLOR == flex_color) {
		COLOR = new_color;
	}
}