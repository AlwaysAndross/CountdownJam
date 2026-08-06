extends Node

signal update_score_count(value)
signal increase_damage(value)
signal increase_firerate(value)

var ball_damage = 1
var firerate = 0.8

@export var score_count : int:
	get = get_score_count, set = set_score_count

func get_score_count():
	return score_count
func set_score_count(value):
	score_count += value
	update_score_count.emit(score_count)
