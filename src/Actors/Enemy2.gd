extends Enemy

onready var animation: = $ExplosionEnemy

func _ready() -> void:
	guns.append(get_node("GunBarrel1"))
	guns.append(get_node("GunBarrel2"))
	
	life = 7
	speed = 100
	attack_speed = 2
	velocity = Vector2(0,1)


func _on_Enemy2_death():
	$"rocket-ship".visible = false
	$BulletDetector/CollisionShape2D.disabled = true
	animation.play("explosion")
	yield(animation, "animation_finished")
	queue_free()
