extends Node2D

@export var particle_effects: Array[GPUParticles2D]

func toggle_effects():
	for particle_effect in particle_effects:
		particle_effect.emitting = !particle_effect.emitting
