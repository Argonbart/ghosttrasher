extends Area2D
class_name Interactable


@export var outline: AnimatedSprite2D


func interact():
	get_parent()._on_interact()


func kill():
	if get_parent() is Human:
		get_parent()._on_kill()


func steal():
	if get_parent() is Human:
		get_parent()._on_steal()


func _on_body_entered(_body) -> void:
	InteractionManager.register_area(self)


func _on_body_exited(_body) -> void:
	InteractionManager.unregister_area(self)
