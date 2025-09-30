class_name Dodging
extends PlayerState

var dodge_direction: Combat.Direction 

func process(player, delta):
	super(player, delta)
	player.play_animation("dodge")

func enter(player, data):
	dodge_direction = data.direction
	var animated_sprite_2d = player.get_node("AnimatedSprite2D")
	animated_sprite_2d.flip_h = data.direction == Combat.Direction.Left
	animated_sprite_2d.position.x = -50 if Combat.Direction.Left == data.direction else 50

func exit(player):
	var animated_sprite_2d = player.get_node("AnimatedSprite2D")
	animated_sprite_2d.position.x = 0
	animated_sprite_2d.flip_h = false

func receive_punch(player, direction):
	if dodge_direction == direction:
		player.reduce_health(5)
		change_state("Hurt")

func animation_finished(player):
	pass
