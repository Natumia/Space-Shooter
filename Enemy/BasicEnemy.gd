extends Area2D

var explosion = preload("res://Mechanics/Explosion.tscn")

export var speed = 35
export var health = 3
export var gainedScore = 0
export var explosionSize = 2.0

export var canShoot = false
export(int, "Single_Shot", "Tri_Shot, Octa_Shot") var shotType
export var fireRate = 1.5
export var firePositionYAdjustment = 0

var velocity = Vector2.ZERO

onready var playerScore = $"/root/PlayerScore"
onready var shootCooldown = $ShootCooldown
export(PackedScene) var ammunition 

func _ready():
	speed = speed * rand_range(0.75, 1.35)

func _physics_process(delta):
	position += transform.y * speed * delta
	shoot()

func shoot():
	if canShoot == true and shootCooldown.time_left == 0:
		var rotationDegrees = 0
		if shotType == 0:
			rotationDegrees = 90
			bulletSpawn(rotationDegrees)
		if shotType == 1:
			rotationDegrees = 80
			for looping in 3:
				bulletSpawn(rotationDegrees)
				rotationDegrees += 10
		if shotType == 2:
			rotationDegrees = 0
			for looping in 8:
				bulletSpawn(rotationDegrees)
				rotationDegrees += 45
		shootCooldown.start(fireRate)

func bulletSpawn(direction):
	var bullet = ammunition.instance()
	get_parent().add_child(bullet)
	bullet.global_position = self.global_position
	bullet.set_rotation_degrees(direction)
	bullet.position.y += firePositionYAdjustment

func _on_HurtBox_area_entered(area):
	health -= area.damage
	if health == 0:
		createExplosion(explosionSize)
		playerScore.score_update(gainedScore)
		queue_free()

func _on_HurtBox_body_entered(_body):
	createExplosion(explosionSize)
	queue_free()

func playerDead():
	canShoot = false

func createExplosion(value):
	var createexplode = explosion.instance()
	get_parent().add_child(createexplode)
	createexplode.global_position = self.global_position
	createexplode.scale.x = value
	createexplode.scale.y = value
