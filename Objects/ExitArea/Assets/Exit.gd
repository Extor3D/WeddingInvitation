extends Area2D

signal end_level

func _on_Exit_body_entered(body):
	if body.has_method("is_player") and Global.current_coins == Global.max_coins:
		emit_signal("end_level")
		
