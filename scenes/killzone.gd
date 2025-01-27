extends Area2D

@onready var timer: Timer = $Timer
@onready var player = $Player  # Replace with your actual player node




func _on_body_entered(body):
		print("you died")
		timer.start()  # Start the timer to reload the scene after a short delay

func _on_timer_timeout():
	# Optionally, you can trigger a death animation here if needed
	print("Reloading scene...")
	get_tree().reload_current_scene()  # Reload the current scene
	
