extends Node2D
class_name Ghost


@export var humans: Node2D

var current_human: Human = null


func _ready():
	WorldManager.connect("world_state_changed", _on_world_state_changed)


func _on_world_state_changed(new_state):
	visible = !visible
	if new_state == 0:
		_change_human()


func _change_human():
	var next_human = humans.get_child(randi_range(0, humans.get_child_count()))
	reparent(next_human, false)
