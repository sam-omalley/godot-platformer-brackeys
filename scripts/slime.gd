extends Node2D

const SPEED : float = 60.0;

var direction : int = 1;

@onready var ray_cast_right: RayCast2D = $RayCastRight;
@onready var ray_cast_left: RayCast2D = $RayCastLeft;
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1;
		sprite.flip_h = true;

	if ray_cast_left.is_colliding():
		direction = 1;
		sprite.flip_h = false;

	position.x += direction * SPEED * delta;
