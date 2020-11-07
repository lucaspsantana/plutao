extends Node

var dir: = Vector2(1,1)


var pos: = ["Position2D1","Position2D2", "Position2D3", "Position2D4", "Position2D5"]

func _on_Timer_timeout():
	create_asteroids()

func _ready():
	create_asteroids()
	$Timer.start()
	
	
func create_asteroids():
	var index: = randi()%4+0
	var asteroid: = preload("res://src/Objects/Asteroid.tscn")
	var Scene: = asteroid.instance()
	Scene.position = get_node(pos[index]).position
	get_parent().add_child(Scene)
	if index < 2:
		Scene.randon_x *= -1
	elif index == 2:
		Scene.randon_x =  0.1

