extends Enemy

onready var animation: = $ExplosionEnemy
func _ready() -> void:
	guns.append(get_node("GunBarrel"))
	
	life = 3
	speed = 100
	attack_speed = 3
	velocity = Vector2(0,1)

func _on_Enemy1_death():
	$"rocket-ship".visible = false
	$BulletDetector/CollisionShape2D.disabled = true
	animation.play("explosion")
	yield(animation, "animation_finished")
	queue_free()
