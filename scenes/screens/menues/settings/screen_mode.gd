extends OptionButton

func _ready():
	item_selected.connect(on_screen_mode_selected)
	match get_window().mode:
		Window.MODE_FULLSCREEN:
			selected = 0
		Window.MODE_WINDOWED:
			selected = 1

func on_screen_mode_selected(index: int):
	match index:
		0:
			get_window().mode = Window.MODE_FULLSCREEN
		1:
			get_window().mode = Window.MODE_WINDOWED
