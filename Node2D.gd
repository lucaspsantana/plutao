extends Node2D

var bar_red: = preload("res://assets/images/barHorizontal_red.png")
var bar_green: = preload("res://assets/images/barHorizontal_green.png")
var bar_yellow: = preload("res://assets/images/barHorizontal_yellow.png")

onready var healthbar = $HealthBar

func _ready():
	if get_parent() and get_parent().get("max_health"):
		healthbar.max_value = get_parent().max_health
		
func _process(delta):
	global_rotation = 0

func update_healthBar(value):
	healthbar.texture_progress = bar_green
	if value < healthbar.max_value * 0.7:
		healthbar.texture_progress = bar_yellow
	if value < healthbar.max_value * 0.35:
		healthbar.texture_progress = bar_red
	healthbar.value = value
