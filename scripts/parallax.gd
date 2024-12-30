extends Node

@export var parallax_scales : Array[float] = []
@export var layers : Array[Node2D] = []
@export var smoothing: float = 1.0

var previous_camera_position : Vector2

func _ready() -> void:
	assert(len(parallax_scales) == len(layers), "Parallax Scales and Layers must be same length")
	previous_camera_position = get_viewport().get_camera_2d().get_screen_center_position()

func _process(delta: float) -> void:
	for i: int in range(len(layers)):
		var parallax: Vector2 = (get_viewport().get_camera_2d().get_screen_center_position() - previous_camera_position) * parallax_scales[i]
		var layer_target_pos: Vector2 = layers[i].position + parallax
		layers[i].position = lerp(layers[i].position, layer_target_pos, smoothing * delta)

	previous_camera_position = get_viewport().get_camera_2d().get_screen_center_position()
