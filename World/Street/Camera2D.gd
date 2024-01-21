extends Camera2D

onready var particulas = $CPUParticles2D

export var scroll_speed = Vector2(100, 0)
var follow : Node2D = null

func _process(delta):
	if follow == null:
		position += scroll_speed * delta
	else:
		position = Vector2(follow.position.x, 0)

func hide_parts():
	particulas.hide()
