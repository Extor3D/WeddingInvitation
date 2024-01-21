extends Control

var completed = false
var current_life = 0
export (PackedScene) var life_scene

func _ready():
	update_life()

func _process(_delta):
	update_life()

func update_life():
	if Global.life != current_life:
		current_life = Global.life
		for n in $LifePosition.get_children():
			$LifePosition.remove_child(n)
			n.queue_free()
		for i in current_life:
			var l = life_scene.instance()
			l.position.x = i * 34
			$LifePosition.add_child(l)
