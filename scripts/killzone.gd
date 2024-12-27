extends Area2D

@export var death_time_scale: float = 0.5

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You died!");
	GameManager.die()
	Engine.time_scale = death_time_scale;
	body.get_node("CollisionShape2D").queue_free();
	timer.start();


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0;
	get_tree().reload_current_scene();
