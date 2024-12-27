extends CharacterBody2D

@export var movement_speed: float = 130.0
@export var sprint_speed_multiplier: float = 1.3
@export var jump_force: float = -300.0
@export var jump_slow_multiplier: float = 0.8
@export var coyote_time: float = 0.2
@export var jump_buffer_time: float = 0.1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

var was_on_floor: bool = false
var can_coyote_jump: bool = false
var jump_pressed: bool = false
var can_double_jump: bool = false
var jump_buffer_timer: Timer

func _ready() -> void:
	jump_buffer_timer = Timer.new()
	jump_buffer_timer.one_shot = true
	jump_buffer_timer.timeout.connect(func(): jump_pressed = false)
	add_child(jump_buffer_timer)
	

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		if was_on_floor and velocity.y >= 0:
			can_coyote_jump = true
			get_tree().create_timer(coyote_time).timeout.connect(func(): can_coyote_jump = false)
		elif was_on_floor and velocity.y < 0:
			can_double_jump = true
			
		velocity += get_gravity() * delta
	else:
		# Set can_double_jump to true when on the ground to avoid rolling off of
		# platforms after a double jump (and negating coyote time + double jump).
		can_double_jump = true
		if jump_pressed:
			velocity.y = jump_force
			jump_pressed = false
			jump_buffer_timer.stop()
			
			# Play jump sound
			jump_sound.play()
			

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or can_coyote_jump:
			velocity.y = jump_force
			
			can_coyote_jump = false
			
			# Play jump sound
			jump_sound.play()
		elif can_double_jump:
			velocity.y = jump_force
			
			can_double_jump = false
			
			# Play jump sound
			jump_sound.play()
		else:
			jump_pressed = true
			jump_buffer_timer.start(jump_buffer_time)
	
	if Input.is_action_just_released("jump"):
		velocity.y *= jump_slow_multiplier
		

	# Get the input direction and handle the movement/deceleration.
	var direction: float = Input.get_axis("move_left", "move_right")
	var is_sprinting: bool = Input.is_action_pressed("sprint")
	
	# Flip the sprite. Checking equality for a float is naughty, but in this
	# case the consequence of it being wrong is very low. It will just flip
	# the sprite to be forward facing when at rest. In practice, it doesn't
	# seem to ever happen anyway, since the 0.0 value is set from get_axis above.
	if direction != 0.0:
		animated_sprite.flip_h = (direction < 0);
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			if is_sprinting:
				animated_sprite.play("sprint")
			else:
				animated_sprite.play("run")
	elif not can_double_jump: # Has already double jumped
		animated_sprite.play("roll")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * movement_speed
		
		# If sprinting, add multiplier to speed
		if is_sprinting:
			velocity.x *= sprint_speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
	
	was_on_floor = is_on_floor();
	move_and_slide()
