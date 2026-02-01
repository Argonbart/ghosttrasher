extends CharacterBody2D
class_name Player

#parameters
@export_category("Parameters")
@export var speed: float = 25.0
@export var max_talismans: int = 3


#nodes
@export_category("Nodes")
@export var anim_sprite_outline: AnimatedSprite2D
@export var anim_sprite: AnimatedSprite2D
@export var room: Node2D
@export var camera: Camera2D


#variables
var last_animation: String = "idle_down"
var remaining_talismans: int
var game_ui: Control
@onready var attack_anim: AnimatedSprite2D = $AttackAnimSprite
var player_won: bool = false
var block_all_input = false


func _ready():
	Globals.player = self
	remaining_talismans = max_talismans


func _physics_process(_delta: float) -> void:
	if !block_all_input:
		#wasd direction
		var input_direction: Vector2 = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).normalized()
			
		#right or left animation
		if abs(input_direction.x) >= abs(input_direction.y):
			if input_direction.x > 0.0:
				anim_sprite.play("run_right")
				anim_sprite_outline.play("run_right")
				last_animation = "idle_right"
			elif input_direction.x < 0.0:
				anim_sprite.play("run_left")
				anim_sprite_outline.play("run_left")
				last_animation = "idle_left"
			else:
				anim_sprite.play(last_animation)
				anim_sprite_outline.play(last_animation)
		# up or down animation
		else:
			if input_direction.y > 0.0:
				anim_sprite.play("run_down")
				anim_sprite_outline.play("run_down")
				last_animation = "idle_down"
			elif input_direction.y < 0.0:
				anim_sprite.play("run_up")
				anim_sprite_outline.play("run_up")
				last_animation = "idle_up"
			else:
				anim_sprite.play(last_animation)
				anim_sprite_outline.play(last_animation)
				
		#set velocity
		velocity = Vector2(input_direction.x * speed,input_direction.y * speed)
		move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		camera.zoom += Vector2(0.15, 0.15)
	
	if event.is_action_pressed("zoom_out"):
		camera.zoom -= Vector2(0.15, 0.15)
