extends Control

func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://playgrounds/alex_playground.tscn")


func _on_return_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://playgrounds/main_menu.tscn")
