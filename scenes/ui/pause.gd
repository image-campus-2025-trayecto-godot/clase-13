extends Control

func _ready():
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		visible = !visible
		get_tree().paused = !get_tree().paused
