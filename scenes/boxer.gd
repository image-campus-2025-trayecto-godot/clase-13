class_name Boxer
extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var health: int = 100 :
	set(new_value):
		health = new_value
		health_changed.emit(health)

signal punched_at(direction: Combat.Direction)
signal health_changed(new_health: int)

func reduce_health(amount):
	health -= amount

func receive_punch_at(_direction: Combat.Direction):
	if is_defeated():
		return
	reduce_health(5)
	animated_sprite_2d.play("hit")
	if health <= 0:
		defeat()
		animated_sprite_2d.play("defeated")

func is_defeated():
	assert(false, "Subclass should implement it")

func defeat():
	assert(false, "Subclass should implement it")
