extends Area2D

var dir = 1

func _process(delta):
	translate(Vector2(150 * delta * dir, 0))


func _on_Timer_timeout():
	queue_free()
