extends Enemy

func _ready() -> void:
	guns.append(get_node("GunBarrel1"))
	guns.append(get_node("GunBarrel2"))
	
	life = 7
	speed = 100
	attack_speed = 2
	velocity = Vector2(0,1)
