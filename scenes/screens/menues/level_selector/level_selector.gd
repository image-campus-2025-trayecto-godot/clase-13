extends PanelContainer

const SELECT_LEVEL_BUTTON = preload("res://scenes/screens/menues/level_selector/select_level_button.tscn")
@onready var levels_container: GridContainer = %LevelsContainer

func _ready() -> void:
	var level_number: int = 1
	for button in levels_container.get_children():
		button.queue_free()
	for level_path in LevelManager.level_paths:
		var button = SELECT_LEVEL_BUTTON.instantiate()
		button.text = str(level_number)
		levels_container.add_child(button)
		button.pressed.connect(func():
			LevelManager.go_to_level(level_path)
		)
		if level_number == 1:
			button.grab_focus()
		level_number += 1
