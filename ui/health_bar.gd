extends TextureProgressBar

@export var boxer: Node2D

func _ready():
	max_value = boxer.health
	value = boxer.health
	boxer.health_changed.connect(on_health_changed)

func on_health_changed(new_health):
	value = new_health
	print(value)
