extends Node2D
class_name Ghost


@export var humans: Node2D


func _ready():
	WorldManager.connect("world_state_changed", _on_world_state_changed)
	await RenderingServer.frame_post_draw
	_change_human()


func _on_world_state_changed(new_state):
	visible = !visible
	if get_parent() and get_parent() is Human:
		get_parent().toggle_outline()
	if new_state == 0:
		_change_human()


func _change_human():
	var next_human = humans.get_child(randi_range(0, humans.get_child_count()))
	reparent(next_human, false)
