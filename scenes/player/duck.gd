extends PlayerState

func process(player, delta):
	super(player, delta)
	player.play_animation("duck")
