extends PlayerState

func process(player, delta):
	player.play_animation("defeated")

func animation_finished(player):
	pass
