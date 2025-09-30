class_name Combat
extends Node2D

enum Direction {
	Left,
	Right
}

@export var player: Boxer
@export var opponent: Opponent

func _ready():
	player.punched_at.connect(opponent.receive_punch_at)
	opponent.punched_at.connect(player.receive_punch_at)
