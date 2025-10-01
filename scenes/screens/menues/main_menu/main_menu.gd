extends PanelContainer

@onready var start_button: Button = %StartButton
@onready var exit_button: Button = %ExitButton

func _ready():
	start_button.pressed.connect(start_game)
	exit_button.pressed.connect(exit_game)

func start_game():
	LevelManager.go_to_initial_level()

func exit_game():
	get_tree().quit()
