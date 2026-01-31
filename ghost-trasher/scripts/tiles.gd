extends TileMapLayer


func _ready():
	WorldManager.connect("world_state_changed", _on_world_state_changed)


func _on_world_state_changed(new_state):
	material.set_shader_parameter("world_state", new_state)
