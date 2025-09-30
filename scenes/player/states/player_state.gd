class_name PlayerState
extends Node

signal changed_stated(new_state)

func change_state(new_state, data = {}):
	changed_stated.emit(new_state, data)

func process(player, delta):
	if Input.is_action_pressed("block"):
		change_state("Block")
	if Input.is_action_just_pressed("dodge_left"):
		change_state("Dodging", { "direction": Combat.Direction.Left })
	if Input.is_action_just_pressed("dodge_right"):
		change_state("Dodging", { "direction": Combat.Direction.Right })
	if Input.is_action_just_pressed("punch_left"):
		change_state("Punching", { "direction": Combat.Direction.Left })
	if Input.is_action_just_pressed("punch_right"):
		change_state("Punching", { "direction": Combat.Direction.Right })
	if Input.is_action_pressed("duck"):
		change_state("Ducking")

func enter(player, data):
	pass

func exit(player):
	pass

func receive_punch(player, direction):
	pass

func animation_finished(player):
	change_state("Idle")
