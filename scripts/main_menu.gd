extends Control
class_name main_menu


@onready var button_play: Button = $MarginContainer/HBoxContainer/VBoxContainer/button_options/button_play as Button
@onready var button_options: Button = $MarginContainer/HBoxContainer/VBoxContainer/button_options as Button
@onready var button_quit: Button = $MarginContainer/HBoxContainer/VBoxContainer/button_options/button_play/button_quit as Button
@onready var root = preload("res://root.tscn") as PackedScene



#Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_play.button_down.connect(on_start_pressed)
	button_quit.button_down.connect(on_exit_pressed)
	pass # Replace with function body.
	
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(root)
	pass
	
func on_exit_pressed() -> void:
	get_tree().quit()
	pass
