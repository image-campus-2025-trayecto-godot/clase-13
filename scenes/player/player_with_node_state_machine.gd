class_name PlayerWithNodeStateMachine
extends Boxer

@export_range(0.05, 1.0, 0.01) var dodge_time: float = 0.5
@onready var dodge_time_left = 0.0
@onready var state_machine: Node2D = $StateMachine

func _process(delta: float) -> void:
	state_machine.process_state(delta)

func play_animation(animation_name):
	animated_sprite_2d.play(animation_name)
	
func is_defeated():
	false

func defeat():
	pass

func receive_punch_at(direction: Combat.Direction):
	state_machine.receive_punch_at(direction)
	if health <= 0:
		state_machine.change_state("Defeated")

func _on_animated_sprite_2d_animation_finished() -> void:
	state_machine.animation_finished()
