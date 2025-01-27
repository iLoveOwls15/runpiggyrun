extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const COYOTE_TIME = 0.11 
var coyote_timer = 0.0 

const DASH_SPEED = 600
var dashing = false
var can_dash = true


func _physics_process(delta: float) -> void:
	# Add gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		#Start the coyote timer when the player leaves the ground
		coyote_timer += delta
	else:
		#Reset the coyote timer when on the ground
		coyote_timer = 0.0
	
	#Handle jump with coyote time
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or coyote_timer < COYOTE_TIME):
		velocity.y = JUMP_VELOCITY
		coyote_timer = COYOTE_TIME 
	
	#Handle dash input and start dash if conditions are met
	if Input.is_action_just_pressed("dash") and can_dash and not is_on_floor():
		dashing = true
		can_dash = false
		$dash_timer.start() 
		$dash_again_timer.start()  

	#Get the input direction and handle movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		#Handle dashing
		if dashing:
			velocity.x = direction * DASH_SPEED 
		else:
			velocity.x = direction * SPEED 
		
		$AnimatedSprite2D.flip_h = direction < 0
		if $AnimatedSprite2D.animation != "walk": 
			$AnimatedSprite2D.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if $AnimatedSprite2D.animation != "idle": 
			$AnimatedSprite2D.play("idle")

	move_and_slide()

#?????? 
#Stop dashing when the dash timer times out
func _on_dash_timer_timeout() -> void:
	dashing = false  # Stop dashing after timer expires

#Re-enable dash after cooldown timer expires
func _on_dash_again_timer_timeout() -> void:
	can_dash = true  # Allow the player to dash again after cooldown
