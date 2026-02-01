extends Node2D


const RUNE_CELL_MATERIAL = preload("uid://cpmpcwq02bwc3")

@export var block_tiles: TileMapLayer
@export var flower_tiles: TileMapLayer
@export var nail_tiles: TileMapLayer

var last_cell_pos: Vector2i


func _ready():
	WorldManager.connect("world_state_changed", _on_world_state_changed)


func _on_world_state_changed(new_state: WorldManager.WORLD_STATE):
	block_tiles.material.set_shader_parameter("world_state", new_state)
	flower_tiles.material.set_shader_parameter("world_state", new_state)
	RUNE_CELL_MATERIAL.set_shader_parameter("world_state", new_state)
	block_tiles.set_cell(last_cell_pos, 4, Vector2i(0,0))
	if new_state == WorldManager.WORLD_STATE.HUMAN_WORLD:
		block_tiles.tile_set.set_physics_layer_collision_layer(0, 4096)
	if new_state == WorldManager.WORLD_STATE.GHOST_WORLD:
		block_tiles.tile_set.set_physics_layer_collision_layer(0, 0)


func _process(_delta):
	var player_pos = Globals.player.global_position
	var local_coords = block_tiles.to_local(player_pos) + Vector2(0.0, 149.0)
	var map_coords = block_tiles.local_to_map(local_coords)
	_create_glowing_cell(map_coords)


func _create_glowing_cell(map_coords):
	
	# works only in ghost world
	if WorldManager.current_state != WorldManager.WORLD_STATE.GHOST_WORLD:
		return
	
	# remove last glowing cell if new pos
	if last_cell_pos != map_coords:
		block_tiles.set_cell(last_cell_pos, 4, Vector2i(0,0))
	
	# ignore non-standard blocks
	if block_tiles.get_cell_atlas_coords(map_coords) != Vector2i(0,0):
		last_cell_pos = Vector2i(100, 100)
		return
	
	# replace standard block with glowing one
	block_tiles.set_cell(map_coords, 4, Vector2i(0,0), 1)
	last_cell_pos = map_coords


func _input(event):
	if event.is_action_pressed("nail"):
		var player_pos = Globals.player.global_position
		var local_coords = block_tiles.to_local(player_pos) + Vector2(0.0, 149.0)
		var map_coords = block_tiles.local_to_map(local_coords)
		_create_3_by_3_field(map_coords)


func _create_3_by_3_field(map_coords):
	
	# works only in ghost world
	if WorldManager.current_state != WorldManager.WORLD_STATE.GHOST_WORLD:
		return
	
	for x_offset in [-1, 0, 1]:
		for y_offset in [-1, 0, 1]:
			var pos = map_coords + Vector2i(x_offset, y_offset)
			
			# place runes block
			if block_tiles.get_cell_atlas_coords(pos) == Vector2i(0,0):
				block_tiles.set_cell(pos, 4, Vector2i(1, 0))
			
			# place corner nails
			if x_offset == -1 and y_offset == -1:
				nail_tiles.set_cell(pos, 4, Vector2i(0, 3))
			if x_offset == -1 and y_offset == 1:
				nail_tiles.set_cell(pos, 4, Vector2i(3, 3))
			if x_offset == 1 and y_offset == -1:
				nail_tiles.set_cell(pos, 4, Vector2i(1, 3))
			if x_offset == 1 and y_offset == 1:
				nail_tiles.set_cell(pos, 4, Vector2i(2, 3))


func _is_inside_prison(pos: Vector2):
	var local_coords = block_tiles.to_local(pos) + Vector2(0.0, 149.0)
	var map_coords = block_tiles.local_to_map(local_coords)
	if block_tiles.get_cell_atlas_coords(map_coords) != Vector2i(0,0):
		return true
	return false
