extends Area2D
class_name Interactable

@export var is_interactable: bool = true
@export var label_offset: float = 36.0

var interact: Callable = func():
	pass


func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)
