extends Node2D

export(Array, PackedScene) var enemies
var difficulty = 2.0

onready var spawnCooldown = $SpawnCooldown
onready var difficultyTimer = $DifficultyTimer

func _ready():
	spawnCooldown.start(difficulty)
	randomize()

func _on_SpawnCooldown_timeout():
	var spawnPosition = Vector2(rand_range(76, 180), -16)
	var enemyNumber = round(rand_range(0, enemies.size() - 1))
	var spawnEnemy = enemies[enemyNumber].instance()
	get_parent().add_child(spawnEnemy)
	spawnEnemy.global_position = spawnPosition
	spawnCooldown.start(difficulty)

func _on_DifficultyTimer_timeout():
	difficulty -= 0.2
	difficulty = clamp(difficulty, 0.3, 2)
	if difficultyTimer != 0.3:
		difficultyTimer.start(30)
