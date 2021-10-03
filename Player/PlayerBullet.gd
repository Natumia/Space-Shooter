extends Area2D

var speed = 220

onready var playerScore = $"/root/PlayerScore"

func _process(delta):
	position -= transform.y * speed * delta

func _on_HitBox_area_entered(_area):
	playerScore.score_update(1)
	queue_free()

func _on_PlayerBullet_body_entered(_body):
	queue_free()
