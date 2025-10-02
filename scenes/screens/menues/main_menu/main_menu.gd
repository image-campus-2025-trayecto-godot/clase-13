extends PanelContainer

const LEVEL_SELECTOR = preload("res://scenes/screens/menues/level_selector/level_selector.tscn")
const SETTINGS = preload("res://scenes/screens/menues/settings/Settings.tscn")

@onready var start_button: Button = %StartButton
@onready var exit_button: Button = %ExitButton
@onready var select_level: Button = %SelectLevel
@onready var settings: Button = %Settings

func _ready():
	start_button.grab_focus()
	start_button.pressed.connect(start_game)
	exit_button.pressed.connect(exit_game)
	settings.pressed.connect(open_settings)
	select_level.pressed.connect(open_level_selector)

func start_game():
	LevelManager.go_to_initial_level()

func exit_game():
	get_tree().quit()

func open_settings():
	get_tree().change_scene_to_packed(SETTINGS)

func open_level_selector():
	get_tree().change_scene_to_packed(LEVEL_SELECTOR)
