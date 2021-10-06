extends Node2D

onready var playerScore = $"/root/PlayerScore"
onready var pauseScreen = $WorldInstance/PauseScreen
onready var pauseLabel = $WorldInstance/PauseScreen/CenterContainer/Label

var died = false

func _process(_delta):
	if Input.is_action_just_pressed("Restart"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
		playerScore.score = 0
		get_tree().paused=false
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused and died == false:
			get_tree().paused = false
			pauseScreen.hide()
		elif died == false:
			pauseLabel.text = "Paused."
			get_tree().paused = true
			pauseScreen.show()

func _on_Player_playerDied():
	died = true
	pauseLabel.text = "You Lost.           Press 'R' to restart."
	pauseScreen.show()
	get_tree().paused = true

