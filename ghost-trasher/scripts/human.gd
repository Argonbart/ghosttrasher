extends RigidBody2D
class_name Human


# exports
@export_category("Nodes")
@export var sprite: AnimatedSprite2D
@export var ghost_slot: Node2D
@export_category("Parameters")
@export var change_direction_time: float = 1.5
@export_category("Movement Bounding")
@export var area_min: Vector2 = Vector2(-200, -100)
@export var area_max: Vector2 = Vector2(200, 100)

# variables
var direction: Vector2 = Vector2.ZERO
var timer: float = 0.0
var speed: float = 0.0

# ghost related variables
#


func _ready():
	
	# connect signals
	WorldManager.connect("world_state_changed", _on_world_state_changed)
	
	# set rigid body parameters
	gravity_scale = 0.0
	linear_damp = 0.0
	
	# initialise
	_pick_new_direction()
	_set_random_color()


func _physics_process(delta):
	
	# update timer
	timer -= delta
	if timer <= 0.0:
		_pick_new_direction()
	
	# update velocity
	linear_velocity = direction * speed
	
	# check for boundaries
	_keep_inside_bounds()


func _on_world_state_changed(new_state):
	sprite.material.set_shader_parameter("world_state", new_state)


func _pick_new_direction():
	direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
	timer = change_direction_time + randf_range(-0.5, 0.5)
	speed = randf_range(10.0, 30.0)


func _bounce_of_body(body):
	direction = (global_position - body.global_position).normalized()
	timer = change_direction_time + randf_range(-0.5, 0.5)
	speed = randf_range(10.0, 30.0)


func _keep_inside_bounds():
	var pos: Vector2 = global_position
	var vel: Vector2 = linear_velocity
	
	if pos.x < area_min.x:
		pos.x = area_min.x
		vel.x = abs(vel.x)
	elif pos.x > area_max.x:
		pos.x = area_max.x
		vel.x = -abs(vel.x)
	
	if pos.y < area_min.y:
		pos.y = area_min.y
		vel.y = abs(vel.y)
	elif pos.y > area_max.y:
		pos.y = area_max.y
		vel.y = -abs(vel.y)
	
	global_position = pos
	linear_velocity = vel


func _set_random_color():
	var mat = sprite.material.duplicate()
	mat.set_shader_parameter("new_color", Color(randf(), randf(), randf()))
	sprite.material = mat


func _on_body_entered(body):
	_bounce_of_body(body)
