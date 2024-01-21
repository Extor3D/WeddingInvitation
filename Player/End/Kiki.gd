extends KinematicBody2D

var target = null
var speed = 30
var t_range = 50

onready var timer = $ActionTimer
onready var anim = $AnimatedSprite

enum ACTIONS {Left, Right, Idle}
var action = ACTIONS.Idle

var animation_change = 1

func change():
	animation_change += 1
	if animation_change > 2:
		queue_free()

func _process(delta):
	anim.playing = true
	anim.speed_scale = 1
	if action == ACTIONS.Idle:
		anim.animation = "idle" + str(animation_change)
	elif action == ACTIONS.Left:
		anim.flip_h = true
		anim.animation = "walk" + str(animation_change)
	elif action == ACTIONS.Right:
		anim.flip_h = false
		anim.animation = "walk" + str(animation_change)
	


func _physics_process(delta):
	if target != null:
		if action == ACTIONS.Left:
			move_and_slide(Vector2(-speed, 0), Vector2(0,-1))
		elif action == ACTIONS.Right:
			move_and_slide(Vector2(speed, 0), Vector2(0,-1))
		var dist = target.position.x - position.x
		if dist > t_range:
			action = ACTIONS.Right
			timer.start(3)
		if dist < -t_range:
			action = ACTIONS.Left
			timer.start(3)

func follow(a):
	target = a
		
func _on_ActionTimer_timeout():
	action = randi() % ACTIONS.size()
	timer.start(2)
