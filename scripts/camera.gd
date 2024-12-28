extends Camera2D

@export var horizontal_tiles: float = 30
@export var tile_width: float = 16

func _ready() -> void:
	get_viewport().connect("size_changed", _on_viewport_resize)
	_on_viewport_resize()

func _on_viewport_resize() -> void:
	var optimal_zoom: float = get_window().size.x / horizontal_tiles / tile_width
	zoom = Vector2.ONE * optimal_zoom
