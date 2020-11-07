extends Path2D

var onscreen = false

func _process(delta: float) -> void:
	if(!onscreen):
		position.y += 100 * delta
		return
	
	$PathFollow2D/Boss.onscreen = true


func _on_VisibilityNotifier2D_viewport_entered(viewport: Viewport) -> void:
	onscreen = true


func _on_VisibilityNotifier2D_screen_entered() -> void:
	onscreen = true
