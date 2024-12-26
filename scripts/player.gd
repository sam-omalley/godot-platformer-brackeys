extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

@export var coyote_time: float = 0.2
@export var jump_buffer_time: float = 0.1

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
			velocity.y = JUMP_VELOCITY
			jump_pressed = false
			jump_buffer_timer.stop()
			
			# Play jump sound
			jump_sound.play()
			

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or can_coyote_jump:
			velocity.y = JUMP_VELOCITY
			
			can_coyote_jump = false
			
			# Play jump sound
			jump_sound.play()
		elif can_double_jump:
			velocity.y = JUMP_VELOCITY
			
			can_double_jump = false
			
			# Play jump sound
			jump_sound.play()
		else:
			jump_pressed = true
			jump_buffer_timer.start(jump_buffer_time)
			
		

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction != 0:
		animated_sprite.flip_h = (direction < 0);
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	elif not can_double_jump: # Has already double jumped
		animated_sprite.play("roll")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	was_on_floor = is_on_floor();
	move_and_slide()
