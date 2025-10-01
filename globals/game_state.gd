extends Node

signal score_changed(new_score)
signal level_won

var lost: bool = false
var won: bool = false
var score: int = 0

func _ready():
	LevelManager.level_changed.connect(func(_level): self.reset_state())

func add_score(amount: int) -> void:
	score += amount
	score_changed.emit(score)

func player_lost():
	lost = true

func _process(_delta: float) -> void:
	if lost:
		$LostSound.play()
		reset_level()

func reset_state():
	won = false
	lost = false

func reset_level():
	reset_state()
	LevelManager.reload_level()

func win():
	won = true
	level_won.emit()
