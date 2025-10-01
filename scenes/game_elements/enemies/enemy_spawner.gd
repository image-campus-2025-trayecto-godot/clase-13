extends Node2D

const SLIME = preload("res://scenes/game_elements/enemies/enemy_spawner.gd")
const BEE = preload("res://scenes/game_elements/enemies/enemy_spawner.gd")
const ENEMY_THAT_FOLLOWS_PATH = preload("res://scenes/game_elements/enemies/enemy_spawner.gd")

@export var time_between_spawns: float = 1.0
@export var distance_from_player: float = 1000.0
@export var player: Player

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time = time_between_spawns
	timer.timeout.connect(on_timer_timeout)

func spawn_random_enemy():
	var possible_enemy_scenes = [SLIME, BEE, ENEMY_THAT_FOLLOWS_PATH]
	var chosen_enemy_scene = possible_enemy_scenes.pick_random()
	var my_enemy: Node2D = chosen_enemy_scene.instantiate()
	add_child(my_enemy)
	my_enemy.global_position.x = player.global_position.x + distance_from_player

func on_timer_timeout():
	spawn_random_enemy()
