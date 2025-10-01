extends AudioStreamPlayer2D

func _ready():
	finished.connect(self.queue_free)
