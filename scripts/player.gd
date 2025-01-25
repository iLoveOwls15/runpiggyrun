extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0


var coyote_timer = 0.11
var can_jump = false

func _physics_process(delta: float) -> void:
	#Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	

	#Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Get the input direction and handle the movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		$AnimatedSprite2D.flip_h = direction < 0
		if $AnimatedSprite2D.animation != "walk": # Play only if not already playing "walk"
			$AnimatedSprite2D.play("walk")
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if $AnimatedSprite2D.animation != "idle": # Play only if not already playing "idle"
			$AnimatedSprite2D.play("idle")

	move_and_slide()
