extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const COYOTE_TIME = 0.11 # The delay before you can jump again after leaving the floor
var coyote_timer = 0.0 # Tracks how much time has passed since leaving the floor

const DASH_SPEED = 600
var dashing = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		# Start the coyote timer when the player leaves the ground
		coyote_timer += delta
	else:
		# Reset the coyote timer when on the ground
		coyote_timer = 0.0
	
	# Handle jump with coyote time
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or coyote_timer < COYOTE_TIME):
		velocity.y = JUMP_VELOCITY
		coyote_timer = COYOTE_TIME # Prevent jumping again until the timer resets
	if Input.is_action_just_pressed("dash"):
		dashing = true

	# Get the input direction and handle the movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		#handle dashing
		if dashing:
			velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
			
		$AnimatedSprite2D.flip_h = direction < 0
		if $AnimatedSprite2D.animation != "walk": 
			$AnimatedSprite2D.play("walk")
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if $AnimatedSprite2D.animation != "idle": 
			$AnimatedSprite2D.play("idle")
			

	move_and_slide()
