extends PathFollow2D

## Move speed in pixels per second
@export var move_speed: float = 200

var direction: float = 1.0

func _process(delta: float) -> void:
	progress += direction * move_speed * delta
	
	if(progress_ratio >= 1.0 || progress_ratio <= 0.0):
		direction *= -1
