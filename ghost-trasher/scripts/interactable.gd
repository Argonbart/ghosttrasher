extends Area2D
class_name Interactable

@export var is_interactable: bool = true
@export var label_offset: float = 36.0
@export var outline:AnimatedSprite2D
@export var parent_object: Human

var interact: Callable = func():
	pass


func _on_body_entered(_body: Node2D) -> void:
	if parent_object.marked_by_talisman:
		InteractionManager.register_area_marked(self)
	else:
		InteractionManager.register_area_unmarked(self)


func _on_body_exited(_body: Node2D) -> void:
	if parent_object.marked_by_talisman:
		InteractionManager.unregister_area_marked(self)
	else:
		outline.hide()
		InteractionManager.unregister_area_unmarked(self)
