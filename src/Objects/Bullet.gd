extends Area2D

var speed: = 600
var velocity : = Vector2(0,-1)
var actor #Gambiarra pra evitar colisao com quem acabou de disparar a arma


func start(pos, dir, _actor):
	actor = _actor
	velocity = Vector2(0, dir)
	global_position = pos

func _physics_process(delta):
	velocity = velocity.normalized() * speed
	position += velocity * delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

