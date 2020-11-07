extends Area2D

var timer = 3

func start(pos):
	position = Vector2(0,0)

func _process(delta: float) -> void:
	timer -= delta
	if(timer <= 1.0):
		$Preview.visible = false
		$Normal.visible = true
		$CollisionShape2D.disabled = false
	if(timer <= 0):
		queue_free()

func _on_Laser_body_entered(body: Node) -> void:
	if(body.name == "Player"):
		body.life -= 5
	
