extends Control

var is_paused = false  # Track pause state

func _ready():
	hide()  # Ensure the pause menu starts hidden
	set_process_input(true)  # Ensure input is processed

func toggle_pause():
	is_paused = !is_paused  # Flip pause state
	get_tree().paused = is_paused  # Pause/unpause the game
	visible = is_paused  # Show/hide pause menu

	if is_paused:
		$Camera2D.make_current()  # Set the camera to focus on pause screen

	print("Game paused:", is_paused)  # Debug output

func _input(event):  # Use _input instead of _unhandled_input for reliability
	if event.is_action_pressed("pause"):
		print("Pause key pressed")  # Debugging output
		toggle_pause()
