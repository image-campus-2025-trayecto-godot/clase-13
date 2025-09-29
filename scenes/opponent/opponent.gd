class_name Opponent
extends Boxer

var defeated: bool = false

func _ready():
	animated_sprite_2d.animation_finished.connect(on_animation_finished)

func is_defeated():
	return defeated
	
func defeat():
	defeated = true

func on_animation_finished():
	if not defeated:
		if animated_sprite_2d.animation == "anticipate_punch":
			punch()
		else:
			animated_sprite_2d.play("idle")

func punch():
	punched_at.emit(Combat.Direction.Left)
	animated_sprite_2d.play("punch")

func _on_timer_timeout() -> void:
	if not defeated:
		animated_sprite_2d.play("anticipate_punch")
