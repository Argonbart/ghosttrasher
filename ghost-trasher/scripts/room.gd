extends Node2D


@export var tile_map: TileMapLayer
@export var flowers: Sprite2D


func _ready():
	WorldManager.connect("world_state_changed", _on_world_state_changed)


func _on_world_state_changed(new_state):
	tile_map.material.set_shader_parameter("world_state", new_state)
	flowers.material.set_shader_parameter("world_state", new_state)
