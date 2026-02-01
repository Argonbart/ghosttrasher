extends StaticBody2D

var humans = []
@export var effects: Node2D
@onready var timer: Timer = $Timer
@export var cooldown: float = 7.5


func _ready() -> void:
	timer.wait_time = cooldown

func _on_interact():
	if timer.time_left > 0 and timer.time_left != cooldown:
		return
	else:
		timer.start()
		effects.toggle_effects()
		Globals.music.pitch_scale = 1.5
		
		for human in humans:
			human._on_music_state_changed()


func _on_music_area_body_entered(body: Node2D) -> void:
	if body is Human:
		humans.append(body)
		body.hit_by_music = true
		body.music_origin = self


func _on_music_area_body_exited(body: Node2D) -> void:
	if body is Human:
		humans.erase(body)
		body.hit_by_music = false


func _on_timer_timeout() -> void:
	timer.wait_time = cooldown
	effects.toggle_effects()
	Globals.music.pitch_scale = 1.0
