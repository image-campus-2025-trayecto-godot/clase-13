extends TextureRect

@export var action_name: StringName

func _process(_delta: float) -> void:
	modulate = Color.DIM_GRAY if Input.is_action_pressed(action_name) else Color.WHITE
