extends AudioStreamPlayer2D

@export var min_shift : float = 0.9;
@export var max_shift : float = 1.1;

func _ready() -> void:
	update_pitch();

func _on_finished() -> void:
	update_pitch();

func update_pitch() -> void:
	pitch_scale = randf_range(min_shift, max_shift);
