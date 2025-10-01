extends Area2D

func _ready():
	body_entered.connect(on_body_entered)

func on_body_entered(_body):
	GameState.player_lost()
