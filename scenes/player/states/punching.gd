extends PlayerState

func process(player, delta):
	super(player, delta)
	player.play_animation("punch")

func enter(player, data):
	var animated_sprite_2d = player.get_node("AnimatedSprite2D")
	player.punched_at.emit(data.direction)
	animated_sprite_2d.flip_h = data.direction == Combat.Direction.Left

func receive_punch(player, delta):
	player.reduce_health(5)
	change_state("Hurt")
