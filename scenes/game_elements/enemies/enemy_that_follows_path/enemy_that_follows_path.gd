extends Path2D

const DEFAULT_SPRITE_FRAMES = preload("res://scenes/game_elements/enemies/spikes_sprite_frames.tres")

@export var move_speed: float = 300
@export var sprite_frames: SpriteFrames = DEFAULT_SPRITE_FRAMES

@onready var path_follow_2d: PathFollow2D = $PathFollow2D
@onready var animated_sprite_2d: AnimatedSprite2D = $PathFollow2D/AnimatedSprite2D

func _ready():
	path_follow_2d.move_speed = move_speed
	animated_sprite_2d.sprite_frames = sprite_frames
	animated_sprite_2d.play("default")
