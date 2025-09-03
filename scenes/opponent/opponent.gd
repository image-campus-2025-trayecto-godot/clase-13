class_name Opponent
extends Node2D

var health: int = 100 :
	set(new_value):
		health = new_value
		health_changed.emit(health)

signal punched_at(_direction: Combat.Direction)
signal health_changed(new_health: int)

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var defeated: bool = false

func _ready():
	animated_sprite_2d.animation_finished.connect(on_animation_finished)

func receive_punch_at(_direction: Combat.Direction):
	if defeated:
		return
	health -= 5
	animated_sprite_2d.play("hit")
	if health <= 0:
		defeated = true
		animated_sprite_2d.play("defeated")

func on_animation_finished():
	if not defeated:
		animated_sprite_2d.play("idle")
