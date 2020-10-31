extends KinematicBody2D

export var speed: = 500
var target: = Vector2()
onready var anim_Player: AnimationPlayer = get_node("animation") 
var life: = 20

var screen_size

func _on_Timer_timeout():
	print("shoot")
	limit_shoots()

func _on_EnemyDetector_area_entered(area):
	if area.name != "Player":
		life -=1
		if life <= 0:
			$CollisionShape2D.set_deferred("disabled", true)
			$EnemyDetector/CollisionShape2D.set_deferred("disabled", true)
			Settings.death = true
			anim_Player.play("explosion")
			yield(anim_Player, "animation_finished")
			get_tree().change_scene("res://src/gui/Screens.tscn")
			queue_free()
			
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
	$Life.text = str(life)

func start(pos):
	position = pos
	target = pos
	show()
	$CollisionShape2D.disabled = false

func shoot():
	anim_Player.play("shoot")
	var bullet: = preload("res://src/Objects/Bullet.tscn")
	var bulletNode: = bullet.instance()
	bulletNode.start($BulletPosition.global_position, -1, self)
	get_parent().add_child(bulletNode)

func limit_shoots():
	if get_tree().get_nodes_in_group("bullet").size() < 50:
		shoot()


