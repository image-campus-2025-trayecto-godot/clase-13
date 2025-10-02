extends OptionButton

const RESOLUTIONS = {
	"1920x1080": Vector2i(1920, 1080),
	"1280x720": Vector2i(1280, 720),
	"1152x648": Vector2i(1152, 648),
	"640x480": Vector2i(640, 480)
}

func _ready():
	clear()
	for resolution_name in RESOLUTIONS.keys():
		add_item(resolution_name)
		if get_window().size == RESOLUTIONS[resolution_name]:
			selected = item_count - 1
	item_selected.connect(on_resolution_item_selected)

func on_resolution_item_selected(index: int):
	var windows_size: Vector2i = RESOLUTIONS[get_item_text(index)]
	get_window().size = windows_size
	get_window().move_to_center()
