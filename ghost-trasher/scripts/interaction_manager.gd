extends Node2D

var player: CharacterBody2D
@onready var label: Label = $Label


const base_text = "[E]"

var active_areas_unmarked = []
var active_areas_marked = []
var can_interact: bool = true


func register_area_unmarked(area: Interactable):
	active_areas_unmarked.push_back(area)


func register_area_marked(area: Interactable):
	active_areas_marked.push_back(area)


func unregister_area_unmarked(area: Interactable):
	var index = active_areas_unmarked.find(area)
	if index != -1:
		active_areas_unmarked.remove_at(index)


func unregister_area_marked(area: Interactable):
	var index = active_areas_marked.find(area)
	if index != -1:
		active_areas_marked.remove_at(index)


func _process(_delta: float) -> void:
	if (active_areas_unmarked.size() > 0 || active_areas_marked.size() > 0) && can_interact:
		if active_areas_marked.size() > 0:
			active_areas_marked.sort_custom(_sort_by_distance_to_player)
			label.text = base_text
			label.global_position = active_areas_marked[0].global_position
			label.global_position.y -= active_areas_marked[0].label_offset
			label.global_position.x -= label.size.x / 2
			label.show()
		else:
			active_areas_unmarked.sort_custom(_sort_by_distance_to_player)
			for i in range(active_areas_unmarked.size()):
				active_areas_unmarked[i].outline.hide()
			label.text = base_text
			label.global_position = active_areas_unmarked[0].global_position
			label.global_position.y -= active_areas_unmarked[0].label_offset
			label.global_position.x -= label.size.x / 2
			label.show()
			active_areas_unmarked[0].outline.show()
	else:
		label.hide()


func _sort_by_distance_to_player(area1, area2):
		var area1_to_player = player.global_position.distance_to(area1.global_position)
		var area2_to_player = player.global_position.distance_to(area2.global_position)
		return area1_to_player < area2_to_player


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && can_interact:
		if active_areas_marked.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas_marked[0].interact.call()
			
			can_interact = true
		elif active_areas_unmarked.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas_unmarked[0].interact.call()
			
			can_interact = true
	elif event.is_action_pressed("kill") && can_interact:
		print("töten")



func _set_player():
	player = get_tree().get_first_node_in_group("player")
