class_name Player
extends Node2D

var health: int = 100 :
	set(new_value):
		health = new_value
		health_changed.emit(health)

signal punched_at(direction: Combat.Direction)
signal health_changed(new_health: int)

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func receive_punch_at(_direction: Combat.Direction):
	pass

func _process(_delta: float) -> void:
	if Input.is_action_pressed("block"):
		animated_sprite_2d.position.x = 0
		animated_sprite_2d.play("block")
	if Input.is_action_pressed("dodge_left"):
		animated_sprite_2d.play("dodge")
		animated_sprite_2d.position.x = 0
		animated_sprite_2d.position.x = -50
		animated_sprite_2d.flip_h = true
	if Input.is_action_pressed("dodge_right"):
		animated_sprite_2d.play("dodge")
		animated_sprite_2d.position.x = 50
		animated_sprite_2d.flip_h = false
	if Input.is_action_just_pressed("punch_left"):
		animated_sprite_2d.play("punch")
		animated_sprite_2d.position.x = 0
		animated_sprite_2d.flip_h = true
		punched_at.emit(Combat.Direction.Left)
	if Input.is_action_just_pressed("punch_right"):
		animated_sprite_2d.play("punch")
		animated_sprite_2d.position.x = 0
		animated_sprite_2d.flip_h = false
		punched_at.emit(Combat.Direction.Right)
	if Input.is_action_pressed("duck"):
		animated_sprite_2d.play("duck")
		animated_sprite_2d.position.x = 0
		animated_sprite_2d.flip_h = false
