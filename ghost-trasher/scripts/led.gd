extends Node2D


@export var sprite: Sprite2D
@export var size_factor: float = 0.5
@export_category("Parameters")
@export_range(10.0, 300.0, 1.0) var radius: float = 200.0
@export_range(10.0, 300.0, 1.0) var speed: float = 100.0
@export_range(0.1, 5.0, 0.1) var change_interval: float = 1.5
@export_range(0.0, 1.0, 0.1) var circular_chance: float = 0.3   # probability [0–1] to use circular motion
@export_range(0.1, 2.0, 0.1) var angular_speed: float = 1.5     # radians per second

var _target: Vector2
var _time_accum := 0.0
var _mode := "wander"  # "wander" or "circle"
var _angle := 0.0

var _center: Vector2

func _ready():
	WorldManager.connect("world_state_changed", _on_world_state_changed)
	sprite.scale = Vector2(size_factor, size_factor)
	_center = position
	_set_new_color()
	_choose_mode()


func _on_world_state_changed(new_state):
	sprite.material.set_shader_parameter("world_state", new_state)


func _process(delta):
	_time_accum += delta
	if _mode == "wander" and _time_accum >= change_interval:
		_time_accum = 0.0
		_pick_new_target()

	if _mode == "wander":
		position = position.move_toward(_center + _target, speed * delta)
	else:
		_angle += angular_speed * delta
		position = _center + Vector2(cos(_angle), sin(_angle)) * radius

func _choose_mode():
	if randf() < circular_chance:
		_mode = "circle"
		_angle = randf() * TAU
	else:
		_mode = "wander"
		_pick_new_target()

func _pick_new_target():
	# Random point inside a circle around the origin
	var angle = randf() * TAU
	var r = sqrt(randf()) * radius
	_target = Vector2(cos(angle), sin(angle)) * r


func _set_new_color():
	var mat = sprite.material.duplicate()
	mat.set_shader_parameter("new_color", Color(randf(), randf(), randf()))
	sprite.material = mat
