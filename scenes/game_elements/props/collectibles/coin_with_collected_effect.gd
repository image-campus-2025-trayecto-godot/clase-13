extends Area2D

const COIN_COLLECTED_EFFECT = preload("res://scenes/game_elements/props/collectibles/coin_collected_effect.tscn")

func _ready() -> void:
	body_entered.connect(self.on_collected)

func on_collected(_body) -> void:
	var coin_collected_effect = COIN_COLLECTED_EFFECT.instantiate()
	get_parent().add_child(coin_collected_effect)
	coin_collected_effect.global_position = global_position
	GameState.add_score(1)
	queue_free()
