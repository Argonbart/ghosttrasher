extends RigidBody2D
class_name Human


# exports
@export_category("Nodes")
@export var talisman_sprite: Sprite2D
@export var outline_sprite: AnimatedSprite2D
@export var sprite: AnimatedSprite2D
@export var ghost_slot: Node2D
@export var interactable: Interactable
@export_category("Parameters")
@export_range(1.0, 20.0, 0.1) var change_direction_time: float = 1.5
@export_range(0.0, 5.0, 0.1) var change_direction_time_vary: float = 0.5
@export_range(1.0, 100.0, 1.0) var min_speed: float = 10.0
@export_range(1.0, 100.0, 1.0) var max_speed: float = 30.0
@export_category("Movement Bounding")
@export var area_center: Vector2 = Vector2.ZERO
@export var radius_x: float = 200.0   # east / west reach
@export var radius_y: float = 120.0   # north / south reach
@export_category("Appearances")
@export var sprite_frames_array: Array[SpriteFrames]
var marked_by_talisman: bool = false
var possessed_by_ghost: bool = false


# variables
var direction: Vector2 = Vector2.ZERO
var timer: float = 0.0
var speed: float = 0.0


func _ready():
	
	# connect signals
	WorldManager.connect("world_state_changed", _on_world_state_changed)
	
	# set rigid body parameters
	gravity_scale = 0.0
	linear_damp = 0.0
	
	# initialise
	_pick_new_direction()
	_set_random_appearance()
	_set_outline_material()


func _on_interact():
	
	# already marked
	if marked_by_talisman:
		return
	
	# can mark
	if !marked_by_talisman && Globals.player.remaining_talismans > 0:
		marked_by_talisman = true
		Globals.player.remaining_talismans -= 1
		Globals.player.talismans_label.text = "Remaining Talismans: " + str(Globals.player.remaining_talismans)
		talisman_sprite.show()


func _on_kill():
	if possessed_by_ghost:
		get_tree().change_scene_to_file("res://playgrounds/win_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://playgrounds/defeat_screen.tscn")


func _physics_process(delta):
	
	# update timer
	timer -= delta
	if timer <= 0.0:
		_pick_new_direction()
	
	# update velocity
	linear_velocity = direction * speed
	
	# flip
	if direction.x > 0.0:
		sprite.flip_h = true
		outline_sprite.flip_h = true
	else:
		sprite.flip_h = false
		outline_sprite.flip_h = false
	
	# check for boundaries
	_keep_inside_bounds()


func _on_world_state_changed(new_state):
	sprite.material.set_shader_parameter("world_state", new_state)


func _pick_new_direction():
	if randf() < 0.5:
		direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
	else:
		direction = Vector2(0.0, 0.0)
	timer = change_direction_time + randf_range(-change_direction_time_vary, change_direction_time_vary)
	speed = randf_range(min_speed, max_speed)


func _bounce_of_body(body):
	direction = (global_position - body.global_position).normalized()
	timer = change_direction_time + randf_range(-change_direction_time_vary, change_direction_time_vary)
	speed = randf_range(min_speed, max_speed)


func _keep_inside_bounds():
	var pos: Vector2 = global_position
	var vel: Vector2 = linear_velocity
	var local := pos - area_center
	
	# Normalized diamond distance
	var d = abs(local.x) / radius_x + abs(local.y) / radius_y
	
	if d > 1.0:
		
		# Clamp position onto diamond edge
		local /= d
		pos = area_center + local
		
		# Boundary normal for stretched diamond
		var normal := Vector2(sign(local.x) / radius_x, sign(local.y) / radius_y).normalized()
		
		# Reflect velocity
		vel = vel - 2.0 * vel.dot(normal) * normal
	
	global_position = pos
	linear_velocity = vel


func _set_random_appearance():
	
	# set random sprite frames
	var sprite_frames: SpriteFrames = sprite_frames_array[randi_range(0,len(sprite_frames_array) - 1)]
	sprite.sprite_frames = sprite_frames
	outline_sprite.sprite_frames = sprite_frames
	sprite.play("default")
	outline_sprite.play("default")
	
	# set random color
	var mat = sprite.material.duplicate()
	mat.set_shader_parameter("new_color", Color(randf(), randf(), randf()))
	mat.set_shader_parameter("new_color_2", Color(randf(), randf(), randf()))
	sprite.material = mat


func _set_outline_material():
	var mat = outline_sprite.material.duplicate()
	outline_sprite.material = mat


func toggle_outline():
	outline_sprite.material.set_shader_parameter("outline_active", !outline_sprite.material.get_shader_parameter("outline_active"))


func _on_body_entered(body):
	_bounce_of_body(body)
