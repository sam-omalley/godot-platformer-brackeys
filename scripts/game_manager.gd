extends Node

var score : int = 0;

signal score_changed(score: int)
signal dead()

func add_point() -> void:
	score += 1
	score_changed.emit(score)

func reset_score() -> void:
	score = 0
	score_changed.emit(score)

func die() -> void:
	reset_score()
	dead.emit()
