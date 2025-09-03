@tool
extends AnimatedSprite2D

@export var animation_offset: Dictionary[StringName, Vector2]

func _ready() -> void:
	animation_changed.connect(on_animation_changed)

func on_animation_changed():
	offset = animation_offset.get(animation, Vector2.ZERO)
