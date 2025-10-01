extends CharacterBody2D

@export var jump_velocity: float = -600.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = jump_velocity

	move_and_slide()
