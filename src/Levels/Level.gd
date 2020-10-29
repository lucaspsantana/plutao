extends Node

var score
func _ready():
	if Settings.enable_music:
		$Music.play()
	$Player.start($StartPosition.position)
	randomize()
