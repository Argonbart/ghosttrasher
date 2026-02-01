extends Node2D
class_name Ghost


@export var humans: Node2D
@export var sprite: AnimatedSprite2D
@export var sprite_outline: AnimatedSprite2D
@export var trigger_shape: CollisionShape2D

var parent_human:Human
var current_state: int = 0
var player_in_range: bool = true


func _ready():
	WorldManager.connect("world_state_changed", _on_world_state_changed)
	await RenderingServer.frame_post_draw
	if player_in_range:
		_change_human()


func _process(_delta):
	
	# flip
	if get_parent() and get_parent() is Human:
		sprite.flip_h = get_parent().sprite.flip_h
		sprite_outline.flip_h = get_parent().sprite.flip_h
	
	if current_state == 1 and player_in_range and !parent_human.marked_by_talisman:
		parent_human.possessed_by_ghost = false
		_change_human()


func _on_world_state_changed(new_state):
	visible = !visible
	if get_parent() and get_parent() is Human:
		get_parent().toggle_outline()
	current_state = new_state


func _change_human():
	var far_humans = []
	for human in humans.get_children():
		if (human.global_position - Globals.player.global_position).length() > trigger_shape.shape.radius:
			far_humans.append(human)
	if far_humans.is_empty():
		return
	var next_human = far_humans[randi_range(0, len(far_humans) - 1)]
	reparent(next_human, false)
	parent_human = next_human
	parent_human.possessed_by_ghost = true
	player_in_range = false


func _on_trigger_area_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
