extends PlayerState

func process(player, delta):
	super(player, delta)
	player.play_animation("block")

func receive_punch(player, direction):
	player.reduce_health(5)
