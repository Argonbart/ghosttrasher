extends Node


signal world_state_changed(new_state: WORLD_STATE)

enum WORLD_STATE { HUMAN_WORLD, GHOST_WORLD }

var current_state: WORLD_STATE = WORLD_STATE.HUMAN_WORLD


func _input(event):
	if event is InputEventKey and event.keycode == KEY_Q and event.pressed and not event.echo:
		current_state = (current_state + 1) % WORLD_STATE.size()
		world_state_changed.emit(current_state)
