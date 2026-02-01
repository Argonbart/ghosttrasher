extends StaticBody2D

signal music_state_changed(new_state: MUSIC_STATE	)

enum MUSIC_STATE { MUSIC_ON, MUSIC_OFF }

var current_state: MUSIC_STATE = MUSIC_STATE.MUSIC_OFF

func _on_interact():
	music_state_changed.emit(current_state)


func _on_music_area_body_entered(body: Node2D) -> void:
	if body is Human:
		print("Enter")


func _on_music_area_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
