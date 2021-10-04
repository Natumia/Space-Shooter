extends Particles2D

func _ready():
	emitting = true
	yield(get_tree().create_timer(0.50), "timeout")
	queue_free()
