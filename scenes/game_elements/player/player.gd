class_name Player
extends CharacterBody2D

@export_range(0.0, 500.0) var speed = 300.0
@export var jump_velocity = -400.0
## It is the time in seconds that the player can still jump
## when it's falling off a cliff.
@export_range(0.0, 2.0, 0.05) var coyote_time: float = 0.25
var coyote_time_left: float = coyote_time
@export var gravity_multiplier_when_falling_fast: float = 3.0
var falling_fast: bool = false

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

#region NODE_LIFECYCLE
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if falling_fast:
			velocity += get_gravity() * gravity_multiplier_when_falling_fast * delta
		else:
			velocity += get_gravity() * delta
		coyote_time_left = move_toward(coyote_time_left, 0.0, delta)
	else:
		coyote_time_left = coyote_time
		falling_fast = false

	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_time_left > 0.0):
		$JumpSound.play()
		coyote_time_left = 0.0
		velocity.y = jump_velocity
	
	if Input.is_action_just_released("jump"):
		falling_fast = true

	velocity.x = speed
	
	if GameState.won:
		velocity = Vector2.ZERO

	move_and_slide()

func _process(_delta: float) -> void:
	if velocity.is_zero_approx():
		sprite_2d.play("idle")
	elif is_on_floor():
		sprite_2d.play("running")
	elif velocity.y < 0:
		sprite_2d.play("jumping")
	elif velocity.y > 0:
		sprite_2d.play("falling")
#endregion
