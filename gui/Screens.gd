extends Node

export var level: = "res://src/Levels/Main.tscn"

var current_screen

var sound_buttons = {true: preload("res://assets/images/buttons/audioOn.png"),
					false: preload("res://assets/images/buttons/audioOff.png")}
var music_buttons = {true: preload("res://assets/images/buttons/musicOn.png"),
					false: preload("res://assets/images/buttons/musicOff.png")}
					
func _ready():
	register_buttons()
	change_screen($TitleScreens)

func register_buttons():
	var buttons = get_tree().get_nodes_in_group("buttons")
	for button in buttons:
		button.connect("pressed", self, "_on_button_pressed", [button.name])

func _on_button_pressed(name):
	match name:
		"Home":
			change_screen($TitleScreens)
		"Play":
			change_screen(null)
			yield(get_tree().create_timer(0.5), "timeout")
			get_tree().change_scene(level)
		"Settings":
			change_screen($Settings)
		"Return":
			change_screen($TitleScreens)
		"Sound":
			Settings.enable_sound = !Settings.enable_sound
			get_node("Settings/MarginContainer/VBoxContainer/Buttons/Sound").texture_normal = sound_buttons[Settings.enable_sound]
		"Music":
			Settings.enable_music = !Settings.enable_music
			get_node("Settings/MarginContainer/VBoxContainer/Buttons/Music").texture_normal = music_buttons[Settings.enable_music]

func change_screen(new_screen):
	if current_screen:
		current_screen.disappear()
		yield(current_screen.tween, "tween_completed")
	current_screen = new_screen
	if new_screen:
		current_screen.appear()
		yield(current_screen.tween, "tween_completed")

func game_over():
	change_screen($GameOver)
