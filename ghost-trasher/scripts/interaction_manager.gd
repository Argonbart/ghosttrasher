extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label: Label = $Label


const base_text = "[E]"

var active_areas = []
var can_interact: bool = true
var last_interactable: Interactable


func register_area(area: Interactable):
	active_areas.push_back(area)


func unregister_area(area: Interactable):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)


func _process(_delta: float) -> void:
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		if active_areas.size() > 0:
			for i in range(active_areas.size()):
				active_areas[i].outline.hide()
		label.text = base_text
		last_interactable = active_areas[0]
		label.global_position = active_areas[0].global_position
		label.global_position.y -= active_areas[0].label_offset
		label.global_position.x -= label.size.x / 2
		label.show()
		active_areas[0].outline.show()
	else:
		label.hide()


func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true
