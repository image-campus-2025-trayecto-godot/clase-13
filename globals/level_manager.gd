extends Node

@export_file("*.tscn") var level_paths: Array[String]
var current_level_path: String

signal level_changed(new_level_path)

func go_to_initial_level():
	go_to_level(level_paths.front())

func go_to_next_level():
	var level_idx = level_paths.find(current_level_path)
	if level_idx >= level_paths.size():
		return
	var next_level_path = level_paths.get(level_idx + 1)
	go_to_level(next_level_path)

func go_to_level(level_path):
	current_level_path = level_path
	get_tree().change_scene_to_file(current_level_path)
	level_changed.emit(current_level_path)

func reload_level():
	get_tree().reload_current_scene()
