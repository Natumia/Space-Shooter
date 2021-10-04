extends KinematicBody2D

export var speed = 35
export var health = 3
export var gainedScore = 0
export var fireRate = 1.5

export var canShoot = false

var velocity = Vector2.ZERO

onready var playerScore = $"/root/PlayerScore"
onready var shootCooldown = $ShootCooldown
var ammunition = preload("res://Enemy/Enemybullet.tscn")

func _ready():
	speed = speed * rand_range(0.75, 1.35)

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2(0, 1) * speed, speed + delta)
	shoot()
	movement()

func movement():
	velocity = move_and_slide(velocity)

func shoot():
	if canShoot == true and shootCooldown.time_left == 0:
		var bullet = ammunition.instance()
		get_parent().add_child(bullet)
		bullet.global_position = global_position
		bullet.position.y += 3
		shootCooldown.start(fireRate)

func _on_HurtBox_area_entered(area):
	health -= area.damage
	if health == 0:
		playerScore.score_update(gainedScore)
		queue_free()

func _on_HurtBox_body_entered(_body):
	queue_free()

func playerDead():
	canShoot = false
