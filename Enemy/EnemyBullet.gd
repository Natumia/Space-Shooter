extends Area2D

var target = Vector2.ZERO
var rotate = rotation_degrees
var speed = 70

onready var findPlayer = $FindPlayer
onready var polygon = $Polygon2D

func _process(delta):
	polygon.rotate(0.1)
	position += transform.x * speed * delta

func _on_HitBox_area_entered(_area):
	queue_free()

func _on_PlayerBullet_body_entered(_body):
	queue_free()

func _on_FindPlayer_body_entered(body):
	target = body.global_position
	rotate = look_at(target)

func _on_FindTimer_timeout():
	findPlayer.monitoring = false
