extends Area2D

var speed: = 100
var velocity = Vector2()
var randon_x = 0.3 #randi()%5-5
var randon_y = 1
var life: = 0

onready var explosion_anim: AnimationPlayer = $explosion_anim

func _ready():
	velocity.x = randon_x
	velocity.y = randon_y
	

func _physics_process(delta):
	velocity = velocity.normalized() * speed
	position += velocity * delta

func _on_Visibility_screen_exited():
	queue_free() # Replace with function body.

func _on_Asteroid_area_entered(area):
	life += 1
	
	if(!area.name == "EnemyDetector"):
		area.queue_free()
	
	if life == 5 or area.name == "EnemyDetector":
		Settings.score += 20
		explosion_anim.play("explosion")
		yield(explosion_anim, "animation_finished")
		queue_free()
		
