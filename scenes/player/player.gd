class_name Player
extends Boxer

@export_range(0.05, 1.0, 0.01) var dodge_time: float = 0.5
@onready var dodge_time_left = 0.0

enum PlayerState {
	Dodging,
	Idle,
	Defeated,
	Blocking,
	Ducking,
	Punching,
	Hurt
}
var state = PlayerState.Idle

func is_defeated():
	return PlayerState.Defeated == state 
	
func defeat():
	state = PlayerState.Defeated

func _process(delta: float) -> void:
	if is_defeated():
		return
	if PlayerState.Dodging == state:
		dodge_time_left = move_toward(dodge_time_left, 0.0, delta)
		if dodge_time_left <= 0.0:
			state = PlayerState.Idle
			animated_sprite_2d.play("idle")
			animated_sprite_2d.position.x = 0
			animated_sprite_2d.flip_h = false
	if Input.is_action_pressed("block"):
		print("BLOCK")
		animated_sprite_2d.position.x = 0
		animated_sprite_2d.play("block")
	if Input.is_action_just_pressed("dodge_left"):
		print("DODGE LEFT")
		state = PlayerState.Dodging
		dodge_time_left = dodge_time
		animated_sprite_2d.play("dodge")
		animated_sprite_2d.position.x = -50
		animated_sprite_2d.flip_h = true
	if Input.is_action_just_pressed("dodge_right"):
		print("DODGE RIGHT")
		state = PlayerState.Dodging
		dodge_time_left = dodge_time
		animated_sprite_2d.play("dodge")
		animated_sprite_2d.position.x = 50
		animated_sprite_2d.flip_h = false
	if Input.is_action_just_pressed("punch_left"):
		print("PUNCH LEFT")
		state = PlayerState.Punching
		animated_sprite_2d.play("punch")
		animated_sprite_2d.position.x = 0
		animated_sprite_2d.flip_h = true
		punched_at.emit(Combat.Direction.Left)
	if Input.is_action_just_pressed("punch_right"):
		print("PUNCH RIGHT")
		state = PlayerState.Punching
		animated_sprite_2d.play("punch")
		animated_sprite_2d.position.x = 0
		animated_sprite_2d.flip_h = false
		punched_at.emit(Combat.Direction.Right)
	if Input.is_action_pressed("duck"):
		print("DUCK")
		state = PlayerState.Ducking
		animated_sprite_2d.play("duck")
		animated_sprite_2d.position.x = 0
		animated_sprite_2d.flip_h = false


func _on_animated_sprite_2d_animation_finished() -> void:
	if PlayerState.Defeated == state:
		return
	if PlayerState.Dodging == state:
		return
	animated_sprite_2d.play("idle")
	animated_sprite_2d.position.x = 0
	animated_sprite_2d.flip_h = false
