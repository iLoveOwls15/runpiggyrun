extends Control

@onready var pause_menu = $ColorRect
@onready var resume_button = get_node_or_null("ColorRect/PanelContainer/VBoxContainer/Resume")
@onready var restart_button = get_node_or_null("ColorRect/PanelContainer/VBoxContainer/Restart")
@onready var quit_button = get_node_or_null("ColorRect/PanelContainer/VBoxContainer/Quit")

func _ready():
	if not resume_button or not restart_button or not quit_button:
		print("Error: One or more buttons not found!")

	if resume_button:
		resume_button.pressed.connect(_on_resume_pressed)
	if restart_button:
		restart_button.pressed.connect(_on_restart_pressed)
	if quit_button:
		quit_button.pressed.connect(_on_quit_pressed)

	pause_menu.visible = false
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("pause"):  # Now it listens for Escape and P
		toggle_pause()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	pause_menu.visible = get_tree().paused

func _on_resume_pressed():
	toggle_pause()

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()
