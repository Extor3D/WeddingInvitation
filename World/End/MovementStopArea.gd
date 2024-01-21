extends Area2D

signal start_cutscene

func _on_MovementStopArea_body_entered(body):
	if body.has_method("is_player"):
		emit_signal("start_cutscene")
		body.stop_moving()
