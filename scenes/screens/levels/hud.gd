extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	GameState.level_won.connect(func():
		animation_player.play("level_finished")
	)
