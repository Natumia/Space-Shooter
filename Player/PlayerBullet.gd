extends Area2D

var particleEffect = preload("res://Player/PlayerHitEffect.tscn")

var speed = 220

onready var playerScore = $"/root/PlayerScore"

func _process(delta):
	position -= transform.y * speed * delta

func _on_HitBox_area_entered(_area):
	var hitEffect = particleEffect.instance()
	get_parent().add_child(hitEffect)
	hitEffect.global_position = global_position
	playerScore.score_update(3)
	queue_free()

func _on_PlayerBullet_body_entered(_body):
	queue_free()
