extends Area2D
class_name Interactable

@export var is_interactable: bool = true
@export var label_offset: float = 36.0
@export var outline:AnimatedSprite2D 

var interact: Callable = func():
	pass


func _on_body_entered(_body: Node2D) -> void:
	InteractionManager.register_area(self)


func _on_body_exited(_body: Node2D) -> void:
	outline.hide()
	InteractionManager.unregister_area(self)
