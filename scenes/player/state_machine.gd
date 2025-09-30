extends Node2D

@export var state: Node
@export var player: Node

func _ready():
	for state in get_children():
		state.changed_stated.connect(self.change_state)

func process_state(delta):
	state.process(player, delta)

func change_state(state_name, data = {}):
	state.exit(player)
	state = get_node(state_name)
	state.enter(player, data)

func receive_punch_at(direction):
	state.receive_punch(player, direction)

func animation_finished():
	state.animation_finished(player)
