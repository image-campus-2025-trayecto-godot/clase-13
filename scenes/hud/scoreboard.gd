extends Label

func _ready():
	GameState.score_changed.connect(on_score_changed)

func on_score_changed(new_score: int):
	text = "Puntaje: %s" % new_score
