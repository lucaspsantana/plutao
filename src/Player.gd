extends KinematicBody2D

export var speed: = 500
signal hit
var target: = Vector2()

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	$Timer.start()

func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		target = event.position
	if event is InputEventScreenDrag:
		target = event.position
		#speed = event.get_speed()

func _physics_process(delta):
	var velocity: = Vector2()
	if position.distance_to(target) > 5:
		velocity = target - position
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


	
func start(pos):
	position = pos
	target = pos
	show()
	$CollisionShape2D.disabled = false

func _on_EnemyDetector_body_entered(body):
	if body.name != "Player":
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled", true)
		$EnemyDetector/CollisionShape2D.set_deferred("disabled", true)
		print(body.name)
		hide()

func shoot():
	var bullet: = preload("res://src/Bullet.tscn")
	var bulletNode: = bullet.instance()
	bulletNode.global_position = $BulletPosition.global_position
	get_parent().add_child(bulletNode)

func limit_shoots():
	if get_tree().get_nodes_in_group("bullet").size() < 50:
		shoot()


func _on_Timer_timeout():
	limit_shoots()
