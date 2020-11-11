extends Node

onready var animation: = $AnimationPlayer
var score
func _ready():
	if Settings.enable_music:
		$Music.play()
	$Player.start($StartPosition.position)
	randomize()

func _physics_process(delta):
	if Settings.victory:
		$Player.target = $Center.global_position
		animation.play("end")
		yield(animation,"animation_finished")
		Settings.victory = false
		Settings.score = 0
		get_tree().change_scene("res://src/gui/Screens.tscn")
