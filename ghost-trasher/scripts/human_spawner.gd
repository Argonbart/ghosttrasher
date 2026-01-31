extends Node2D


const HUMAN = preload("uid://bnhciy5dl5n0s")

@export_range(0.0, 300.0, 1.0) var human_count: float = 150.0


func _ready():
	for i in range(human_count):
		spawn_human()


func spawn_human():
	var new_human: Human = HUMAN.instantiate()
	new_human.global_position = Vector2(randf_range(-150.0, 150.0), randf_range(-60.0, 60.0))
	add_child(new_human)
