extends Area2D
class_name Interactable

@export var is_interactable: bool = true
@export var outline:AnimatedSprite2D
@export var parent_object: Node2D


var interact: Callable = func():
	get_parent()._on_interact()
	pass

var kill: Callable = func():
	pass

func _on_body_entered(_body: Node2D) -> void:
	
	# Case Human
	if parent_object is Human:
		if WorldManager.current_state == WorldManager.WORLD_STATE.HUMAN_WORLD:
			if !parent_object.marked_by_talisman:
				InteractionManager.register_area(self)
	
	# Hier checken auf andere Dinge
	# if parent_object is DjBooth:


func _on_body_exited(_body: Node2D) -> void:
	if parent_object is Human:
		if !parent_object.marked_by_talisman:
			outline.hide()
			InteractionManager.unregister_area(self)
