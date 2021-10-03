extends Area2D

var speed = 220
signal bulletDestroyed

func _process(delta):
	position -= transform.y * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("bulletDestroyed")
	queue_free()
