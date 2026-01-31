extends TileMapLayer


func _input(event):
	if event is InputEventKey and event.keycode == KEY_Q and event.pressed and not event.echo:
		material.set_shader_parameter("active", not material.get_shader_parameter("active"))
