extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://playgrounds/alex_playground.tscn")

func _on_tutorial_pressed() -> void:
	print("Hier Control Sheet einfügen")


func _on_quit_pressed() -> void:
	get_tree().quit()


























func _on_button_pressed() -> void:
	$VideoStreamPlayer.play()
	$ButtonManager/Button.hide()
