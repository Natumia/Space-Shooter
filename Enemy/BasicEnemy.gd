extends KinematicBody2D

onready var playerScore = $"/root/PlayerScore"

func _ready():
	pass # Replace with function body.

func _on_HurtBox_area_entered(area):
	print("Hit!")
	
