extends Node

var score : int = 0;

@onready var score_label: Label = $ScoreLabel

func add_point():
	score += 1;
	if score == 1:
		score_label.text = "You collected 1 coin."
	else:
		score_label.text = "You collected %s coins." % score;
