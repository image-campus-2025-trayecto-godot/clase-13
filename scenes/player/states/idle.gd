extends PlayerState

func process(player, delta):
	super(player, delta)
	player.play_animation("idle")

func receive_punch(player, delta):
	player.reduce_health(5)
	change_state("Hurt")
