extends Enemy

func _ready() -> void:
	guns.append(get_node("GunBarrel"))
	
	life = 5
	speed = 100
	attack_speed = 2
	velocity = Vector2(0,1)
