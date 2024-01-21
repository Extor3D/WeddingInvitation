extends Node2D

onready var transition = $Yohe/Camera2D/Transition
onready var timer = $Timer

func _ready():
	transition.open(2)

func _on_Exit_end_level():
	transition.close(2)
	timer.start()

func _on_Timer_timeout():
	var _error = get_tree().change_scene("res://World/Boss/BossLevel.tscn")
