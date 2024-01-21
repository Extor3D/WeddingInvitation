extends Area2D

signal defeated

export var shootWaitTime = 3
export var shootingTime = 0.5
export var health = 10

onready var shootTimer = $ShootTimer
onready var sprite = $AnimatedSprite
onready var anim = $AnimationPlayer
onready var hurt_audio = $HurtPlayer
onready var defeat_audio = $DefeatPlayer

var bullets = []

var shooting = false

const bullet_scene = preload("res://Enemies/Maduro/Expropiese.tscn")

func _on_ShootTimer_timeout():
	if health > 0:
		if shooting:
			shooting = false
			shootTimer.start(shootWaitTime)
			sprite.set_animation("idle")
		else:
			shooting = true
			shootTimer.start(shootingTime)
			sprite.set_animation("shoot")
			create_bullet()

func create_bullet():
	var bullet = bullet_scene.instance()
	bullet.start(self.global_position, PI, get_tree().get_nodes_in_group("Player")[0])
	bullet.maduro = self
	bullets.append(bullet)
	get_parent().add_child(bullet)
	
func lose_health(amount):
	health -= amount
	hurt_audio.play()
	anim.play("Damage")
	if health == 0:
		defeat_audio.play()
		sprite.set_animation("defeat") 
		emit_signal("defeated")

func _on_Maduro_area_entered(area):
	area.queue_free()
	lose_health(1)
	
func end_level():
	var _error = get_tree().change_scene("res://World/Street/StreetLevel.tscn")
