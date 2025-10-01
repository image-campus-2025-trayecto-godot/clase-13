extends Area2D



@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
var was_collected: bool = false

func _ready() -> void:
	body_entered.connect(self.on_collected)

func on_collected(body) -> void:
	if was_collected:
		return
	was_collected = true
	hide()
	audio_stream_player_2d.play()
	GameState.add_score(1)
	audio_stream_player_2d.finished.connect(self.queue_free)
