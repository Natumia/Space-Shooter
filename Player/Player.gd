extends KinematicBody2D

var maxSpeed = 100
var speed = 100
var velocity = Vector2.ZERO
var maxShots = 3

var ammunition = preload("res://Player/PlayerBullet.tscn")

onready var fireCooldown = $FireCooldown

signal playerDied

func _physics_process(delta):
	movement_input(delta)
	slow_movement()
	shoot_input()

func movement_input(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	velocity = velocity.move_toward(input_vector * speed, speed + delta)
	
	movement()

func movement():
	velocity = move_and_slide(velocity)

func slow_movement():
	if Input.is_action_just_pressed("GoSlow"):
		speed = speed / 2
	elif Input.is_action_just_released("GoSlow"):
		speed = maxSpeed

func shoot_input():
	if fireCooldown.time_left <= 0:
		var allBullets = get_tree().get_nodes_in_group("player_bullets")
		if Input.is_action_pressed("ui_select") and len(allBullets) < maxShots:
			fire_bullet()
			fireCooldown.start()
 
func fire_bullet():
	var bullet = ammunition.instance()
	get_parent().add_child(bullet)
	bullet.global_position = global_position

func _on_HurtBox_area_entered(_area):
	emit_signal("playerDied")
	queue_free()
