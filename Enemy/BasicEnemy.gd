extends KinematicBody2D

export var speed = 35
export var health = 3
export var gainedScore = 0
var velocity = Vector2.ZERO

onready var playerScore = $"/root/PlayerScore"

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2(0, 1) * speed, speed + delta)
	
	move_and_slide(velocity)

func _on_HurtBox_area_entered(area):
	print("Hit!")
	health -= area.damage
	if health == 0:
		playerScore.score_update(gainedScore)
		queue_free()

func _on_HurtBox_body_entered(body):
	queue_free()
