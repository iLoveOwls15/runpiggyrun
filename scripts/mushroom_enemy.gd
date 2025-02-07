extends CharacterBody2D

@export var speed: float = 40.0  
@export var detection_range: float = 150.0  

@onready var player = get_node_or_null("/root/root/player")
@onready var animated_sprite = $AnimatedSprite2D  

func _physics_process(delta):
	if player and is_instance_valid(player):  
		var distance_to_player = global_position.distance_to(player.global_position)

		if distance_to_player < detection_range:
			follow_player()
		else:
			velocity = Vector2.ZERO  #Stop moving if out of range
			animated_sprite.play("mushroom_idle")
		
	move_and_slide()

func follow_player():
	var direction = (player.global_position - global_position).normalized()
	velocity.x = direction.x * speed

	animated_sprite.flip_h = direction.x < 0



	if abs(velocity.x) != 0:
		animated_sprite.play("mushroom_attack")
	else:
		animated_sprite.play("mushroom_idle")
		
