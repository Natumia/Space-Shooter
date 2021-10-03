extends Node

var score = 0 setget clamp_max_score
var lives = 3

signal scoreChanged

func score_update(value):
	score += value
	emit_signal("scoreChanged", score)

func clamp_max_score(value):
	score = clamp(value, 0, 9999999)
