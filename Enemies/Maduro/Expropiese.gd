extends Area2D

export var speed = 50
export var steer_force = 5.0

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null

onready var sprite = $Sprite
onready var coll = $CollisionShape2D

var maduro = null

func start(_position, _rotation, _target):
	global_position = _position
	rotation = _rotation
	velocity = transform.x * speed
	target = _target
	connect("defeated", maduro, "queue_free")

func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func _physics_process(delta):
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()
	position += velocity * delta
	sprite.rotation = -self.rotation
	coll.rotation = -self.rotation + 51.2

func _on_Timer_timeout():
	queue_free()


func _on_Expropiese_body_entered(body):
	body.take_damage()
	queue_free()
