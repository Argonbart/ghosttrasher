extends Node2D

var areas = []

func _ready() -> void:
	WorldManager.connect("world_state_changed", _on_world_state_changed)


func _on_world_state_changed(new_state: WorldManager.WORLD_STATE):
	var remove_counter = 0
	if new_state == WorldManager.WORLD_STATE.GHOST_WORLD:
		for i in range(areas.size()):
			if areas[i - remove_counter].get_parent() is Human:
				areas[i - remove_counter].outline.hide()
				areas.remove_at(i - remove_counter)
				remove_counter += 1 
	else:
		for i in range(areas.size()):
			if areas[i - remove_counter].get_parent() is not Human:
				areas[i - remove_counter].outline.hide()
				areas.remove_at(i - remove_counter)
				remove_counter += 1 

func register_area(area: Interactable):
	if area.get_parent() is Human and WorldManager.current_state == WorldManager.WORLD_STATE.HUMAN_WORLD:
		areas.append(area)
		
	if area.get_parent() is not Human and WorldManager.current_state == WorldManager.WORLD_STATE.GHOST_WORLD:
		areas.append(area)


func unregister_area(area: Interactable):
	areas.erase(area)


func _process(_delta: float) -> void:	
	if areas.size() > 0:
		areas.sort_custom(_sort_by_distance_to_player)
		for i in range(areas.size()):
			areas[i].outline.hide()
		areas[0].outline.show()


func _sort_by_distance_to_player(area1, area2):
		var area1_to_player = Globals.player.global_position.distance_to(area1.global_position)
		var area2_to_player = Globals.player.global_position.distance_to(area2.global_position)
		return area1_to_player < area2_to_player


func _input(event: InputEvent) -> void:
	if areas.is_empty():
		return
	
	if event.is_action_pressed("interact"):
		areas[0].interact.call()
	elif event.is_action_pressed("kill"):
		print("töten")
