extends Node2D

onready var playerScore = $"/root/PlayerScore"

func _process(_delta):
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()
		playerScore.score = 0
