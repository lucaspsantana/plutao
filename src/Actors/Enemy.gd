extends KinematicBody2D
class_name Enemy

var speed
var life
var attack_speed
var cd = 0
var guns = []

var velocity

func _physics_process(delta: float) -> void:
	ShootTimer(delta)
	move_and_slide(velocity * speed)


func TakeDamage():
	life -= 1
	
	if(life == 0):
		queue_free()

func ShootTimer(delta):
	cd -= delta
	
	if(cd <= 0):
		for gun in guns:
			Shoot(gun.global_position)
		
		cd = attack_speed

func Shoot(Gun_Global_Position):
	var bullet = load("res://src/Bullet.tscn").instance()
	bullet.start(Gun_Global_Position, 1, self)
	get_parent().add_child(bullet)

func _on_BulletDetector_area_entered(area: Area2D) -> void:
	if(area.actor == self):
		return
	
	print("Tomou dano - " + String(area.actor.name))
	TakeDamage()