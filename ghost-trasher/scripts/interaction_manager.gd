extends Node2D


var areas = []


func _ready() -> void:
	WorldManager.connect("world_state_changed", _on_world_state_changed)


func _on_world_state_changed(new_state: WorldManager.WORLD_STATE):
	
	# remove humans on swap to ghost world
	if new_state == WorldManager.WORLD_STATE.GHOST_WORLD:
		var idx = 0
		while idx < areas.size():
			if areas[idx].get_parent() is Human:
				areas[idx].outline.hide()
				areas.remove_at(idx)
				idx -= 1
			idx += 1
	
	# remove all non-humans on swap to human world
	if new_state == WorldManager.WORLD_STATE.HUMAN_WORLD:
		var idx = 0
		while idx < areas.size():
			if areas[idx].get_parent() is not Human:
				areas[idx].outline.hide()
				areas.remove_at(idx)
				idx -= 1
			idx += 1


func register_area(area: Interactable):
	
	# register only humans in human world
	if area.get_parent() is Human and WorldManager.current_state == WorldManager.WORLD_STATE.HUMAN_WORLD:
		areas.append(area)
	
	# register only non-humans in ghost world
	if area.get_parent() is not Human and WorldManager.current_state == WorldManager.WORLD_STATE.GHOST_WORLD:
		areas.append(area)


func unregister_area(area: Interactable):
	area.outline.hide()
	areas.erase(area)


func _process(_delta: float) -> void:
	
	# show outline of closest area in areas
	if areas.size() > 0:
		areas.sort_custom(_sort_by_distance_to_player)
		for area in areas:
			area.outline.hide()
		areas[0].outline.show()


func _input(event: InputEvent) -> void:
	
	# nothing to interact with
	if areas.is_empty():
		return
	
	# interact with next interactable
	if event.is_action_pressed("interact"):
		areas[0].interact.call()
	
	# kill if next to human
	if event.is_action_pressed("kill") and areas[0].get_parent() is Human:
		areas[0].kill.call()
	
	# steal if next to human
	if event.is_action_pressed("steal") and areas[0].get_parent() is Human:
		areas[0].steal.call()


func _sort_by_distance_to_player(area1, area2):
		var area1_to_player = Globals.player.global_position.distance_to(area1.global_position)
		var area2_to_player = Globals.player.global_position.distance_to(area2.global_position)
		return area1_to_player < area2_to_player
