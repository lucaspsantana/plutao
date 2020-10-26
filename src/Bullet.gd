extends Area2D

var speed: = 600
var velocity : = Vector2(0,-1)

func _physics_process(delta):
	var velocity: = Vector2(0,-1)
	velocity = velocity.normalized() * speed
	position += velocity * delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
