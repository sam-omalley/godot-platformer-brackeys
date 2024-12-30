extends Node

@onready var score_label: Label = $ScoreLabel

func _ready() -> void:
	GameManager.score_changed.connect(update_score)

func update_score(score: int) -> void:
	if score == 1:
		score_label.text = "You collected 1 coin."
	else:
		score_label.text = "You collected %s coins." % score;
