extends Node

export var level: = "res://src/Levels/Level.tscn"

var current_screen

var sound_buttons = {true: preload("res://assets/images/buttons/audioOn.png"),
					false: preload("res://assets/images/buttons/audioOff.png")}
var music_buttons = {true: preload("res://assets/images/buttons/musicOn.png"),
					false: preload("res://assets/images/buttons/musicOff.png")}
					
func _ready():
	if Settings.enable_sound:
		$Music.play()
	register_buttons()
	if Settings.death:
		game_over()
		return
	if Settings.victory:
		$End/MarginContainer/VBoxContainer/Message.text += "\n \n %s" % Settings.score
		change_screen($End)
	else:
		change_screen($TitleScreens)
	

func register_buttons():
	var buttons = get_tree().get_nodes_in_group("buttons")
	for button in buttons:
		button.connect("pressed", self, "_on_button_pressed", [button.name])

func _on_button_pressed(name):
	match name:
		"Home":
			if Settings.enable_sound:
				$Sound.play()
			change_screen($TitleScreens)
		"Play":
			if Settings.enable_sound:
				$Sound.play()
			change_screen(null)
			yield(get_tree().create_timer(0.5), "timeout")
			get_tree().change_scene(level)
		"Settings":
			if Settings.enable_sound:
				$Sound.play()
			change_screen($Settings)
		"Return":
			if Settings.enable_sound:
				$Sound.play()
			change_screen($TitleScreens)
		"Sound":
			if Settings.enable_sound:
				$Sound.play()
			Settings.enable_sound = !Settings.enable_sound
			get_node("Settings/MarginContainer/VBoxContainer/Buttons/Sound").texture_normal = sound_buttons[Settings.enable_sound]
		"Music":
			if Settings.enable_sound:
				$Sound.play()
			Settings.enable_music = !Settings.enable_music
			get_node("Settings/MarginContainer/VBoxContainer/Buttons/Music").texture_normal = music_buttons[Settings.enable_music]
			if Settings.enable_music:
				$Music.play()
			else:
				$Music.stop()

func change_screen(new_screen):
	if current_screen:
		current_screen.disappear()
		yield(current_screen.tween, "tween_completed")
	current_screen = new_screen
	if new_screen:
		current_screen.appear()
		yield(current_screen.tween, "tween_completed")

func game_over():
	print(Settings.enable_sound)
	if Settings.enable_sound:
		$Music.play()
	change_screen($GameOver)
