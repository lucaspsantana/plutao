extends Enemy

func _ready() -> void:
	guns.append(get_node("GunBarrel"))
	
	life = 3
	speed = 100
	attack_speed = 3
	velocity = Vector2(0,1)



