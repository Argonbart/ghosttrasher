extends CharacterBody2D

#parameters
@export_category("Parameters")
@export var speed: float = 25.0

#nodes
@export_category("Nodes")
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

#variables
var last_animation: String = "idle_down"


func _ready():
	Globals.player = self


func _physics_process(_delta: float) -> void:
	
	#wasd direction
	var input_direction: Vector2 = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).normalized()
		
	#right or left animation
	if abs(input_direction.x) >= abs(input_direction.y):
		if input_direction.x > 0.0:
			anim_sprite.play("run_right")
			last_animation = "idle_right"
		elif input_direction.x < 0.0:
			anim_sprite.play("run_left")
			last_animation = "idle_left"
		else:
			anim_sprite.play(last_animation)
	# up or down animation
	else:
		if input_direction.y > 0.0:
			anim_sprite.play("run_down")
			last_animation = "idle_down"
		elif input_direction.y < 0.0:
			anim_sprite.play("run_up")
			last_animation = "idle_up"
		else:
			anim_sprite.play(last_animation)
			
	#set velocity
	velocity = Vector2(input_direction.x * speed,input_direction.y * speed)
	move_and_slide()
