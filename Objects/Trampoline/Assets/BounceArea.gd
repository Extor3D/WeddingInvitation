extends Area2D

signal on_body_bounced

var multiplier = 1.0

func _process(_delta):
	for body in get_overlapping_bodies():
		if body.has_method("force_jump"):
			if body.force_jump(multiplier):
				emit_signal("on_body_bounced")

func _on_BounceArea_body_entered(body):
	if body.has_method("force_jump"):
		if body.force_jump(multiplier):
			emit_signal("on_body_bounced")
