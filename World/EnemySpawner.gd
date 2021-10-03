extends Node2D

export(Array, PackedScene) var enemies

func _ready():
	randomize()

func _on_SpawnCoolDown_timeout():
	var spawnPosition = Vector2(rand_range(72, 184), rand_range(-64, -16))
	var enemyNumber = round(rand_range(0, enemies.size() - 1))
	var spawnEnemy = enemies[enemyNumber].instance()
	get_parent().add_child(spawnEnemy)
	spawnEnemy.global_position = spawnPosition
