extends KinematicBody2D

var move_speed = 150
var move_direction = 0

onready var HP = $HP
onready var animation: = $ExplosionEnemy

var Phase = 1

var onscreen = false

var B_AttackSpeed = 3
var B_Cooldown = 0

var L_AttackSpeed = 5
var L_Cooldown = 0

onready var path_follow: PathFollow2D = get_parent()

func _physics_process(delta: float) -> void:
	if(!onscreen):
		return
	
	MovementLoop(delta)
	
	if(HP.value > 300):
		Phase = 1
	elif(HP.value <= 300 && HP.value > 200):
		Phase = 2
	else:
		Phase = 3
	
	if (Phase == 1):
		Phase1(delta)
	elif(Phase == 2):
		Phase2(delta)
	elif(Phase == 3):
		Phase3(delta)

func MovementLoop(delta):
	var prepos = path_follow.get_global_position()
	path_follow.set_offset(path_follow.get_offset() + move_speed * delta)
	var pos = path_follow.get_global_position()
	move_direction = (pos.angle_to_point(prepos) / 3.14) * 150

func Phase1(delta):
	B_Cooldown -= delta
	
	if(B_Cooldown <= 0):
		ShootBullet($GunBarrel.global_position)
		ShootBullet($GunBarrel2.global_position)
		
		B_Cooldown = B_AttackSpeed

func Phase2(delta):
	L_Cooldown -= delta
	
	if(L_Cooldown <= 0):
		ShootLaser()
		L_Cooldown = L_AttackSpeed

func Phase3(delta):
	Phase1(delta)
	Phase2(delta)

func ShootBullet(gp):
	var bullet = load("res://src/Objects/Bullet.tscn").instance()
	bullet.start(gp, 1, self)
	get_parent().get_parent().get_parent().add_child(bullet)

func ShootLaser():
	var Laser = load("res://src/Objects/Laser.tscn").instance()
	Laser.start($LaserBarrel.global_position)
	$LaserBarrel.add_child(Laser)


func _on_Area2D_area_entered(area: Area2D) -> void:
	if(area.actor == self):
		return
	
	area.queue_free()
	HP.value -= 1.5
	
	if(HP.value <= 0):
		$spriteBoss.visible = false
		$BulletDetector/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true 
		animation.play("explosion")
		yield(animation, "animation_finished")
		Settings.victory = true
		get_tree().change_scene("res://src/gui/Screens.tscn")
		queue_free()
		
