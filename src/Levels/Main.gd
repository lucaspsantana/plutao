extends Node

var score
func _ready():
	$Player.start($StartPosition.position)
	randomize()
