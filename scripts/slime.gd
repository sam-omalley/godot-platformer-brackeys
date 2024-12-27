extends Node2D

@export var speed: float = 60.0
@export var y_offset: int = -7

var direction : int = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		sprite.flip_h = true

	if ray_cast_left.is_colliding():
		direction = 1
		sprite.flip_h = false
		
	if ray_cast_down.is_colliding():
		var collision = ray_cast_down.get_collision_point()
		position.y = collision.y + y_offset


	position.x += direction * speed * delta;
