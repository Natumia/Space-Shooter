extends KinematicBody2D

var speed = 110
var velocity = Vector2.ZERO
var ammo = 3
var maxAmmo = 3

var ammunition = preload("res://Player/PlayerBullet.tscn")

onready var fireCooldown = $FireCooldown

func _physics_process(delta):
	ammo = clamp(ammo, 0, maxAmmo)
	movement_input(delta)
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

func shoot_input():
	if fireCooldown.time_left <= 0:
		if Input.is_action_pressed("ui_select"):
			if ammo != 0:
				ammo -= 1
				print(ammo)
				fireCooldown.start()
				fire_bullet()
			else:
				print("No ammo!")
				fireCooldown.start()

func fire_bullet():
	var bullet = ammunition.instance()
	get_parent().add_child(bullet)
	bullet.connect("bulletDestroyed", self, "reload_ammo")
	bullet.global_position = global_position

func reload_ammo():
	ammo += 1

