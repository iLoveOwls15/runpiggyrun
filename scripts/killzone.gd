extends Area2D

@onready var timer: Timer = $Timer
@onready var player = $Player  




func _on_body_entered(body):
		print("you died")
		timer.start()  #timer start

func _on_timer_timeout():
	
	print("Reloading scene...")
	get_tree().reload_current_scene()  #Reload the current scene
	
