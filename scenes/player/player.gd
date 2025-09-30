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
var state_data: Dictionary[PlayerState, Dictionary] = {}

func is_defeated():
	return PlayerState.Defeated == state 

func change_state(new_state, data = {}):
	state = new_state
	state_data[state] = data
	on_enter_state(data)

func _process(delta: float) -> void:
	process_state(delta)

func on_enter_state(data):
	match state:
		PlayerState.Dodging:
			dodge_time_left = dodge_time
			animated_sprite_2d.position.x = -50 if Combat.Direction.Left == data.direction else 50
			animated_sprite_2d.flip_h = data.direction == Combat.Direction.Left
		PlayerState.Punching:
			punched_at.emit(data.direction)
			animated_sprite_2d.flip_h = data.direction == Combat.Direction.Left

func process_state(delta):
	match state:
		PlayerState.Idle:
			animated_sprite_2d.play("idle")
		PlayerState.Defeated:
			animated_sprite_2d.play("defeated")
		PlayerState.Blocking:
			animated_sprite_2d.play("block")
		PlayerState.Ducking:
			animated_sprite_2d.play("duck")
		PlayerState.Hurt:
			animated_sprite_2d.play("hit")
		PlayerState.Dodging:
			animated_sprite_2d.play("dodge")
			dodge_time_left = move_toward(dodge_time_left, 0.0, delta)
			if dodge_time_left <= 0.0:
				change_state(PlayerState.Idle)
			if Input.is_action_just_pressed("punch_left"):
				change_state(PlayerState.Punching, { "direction": Combat.Direction.Left })
			if Input.is_action_just_pressed("punch_right"):
				change_state(PlayerState.Punching, { "direction": Combat.Direction.Right })
		PlayerState.Punching:
			animated_sprite_2d.play("punch")
	if state != PlayerState.Dodging:
		animated_sprite_2d.position.x = 0
	if state != PlayerState.Dodging && state != PlayerState.Punching:
		animated_sprite_2d.flip_h = false
	if state != PlayerState.Defeated && state != PlayerState.Dodging:
		if Input.is_action_pressed("block"):
			change_state(PlayerState.Blocking)
		if Input.is_action_just_pressed("dodge_left"):
			change_state(PlayerState.Dodging, { "direction": Combat.Direction.Left })
		if Input.is_action_just_pressed("dodge_right"):
			change_state(PlayerState.Dodging, { "direction": Combat.Direction.Right })
		if Input.is_action_just_pressed("punch_left"):
			change_state(PlayerState.Punching, { "direction": Combat.Direction.Left })
		if Input.is_action_just_pressed("punch_right"):
			change_state(PlayerState.Punching, { "direction": Combat.Direction.Right })
		if Input.is_action_pressed("duck"):
			change_state(PlayerState.Ducking)


func _on_animated_sprite_2d_animation_finished() -> void:
	if PlayerState.Defeated == state:
		return
	if PlayerState.Dodging == state:
		return
	change_state(PlayerState.Idle)
	animated_sprite_2d.flip_h = false
