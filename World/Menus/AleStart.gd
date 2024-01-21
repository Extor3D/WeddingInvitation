extends Node2D

onready var timer = $Timer
onready var load_timer = $LoadTimer
onready var transition = $Camera2D/Transition

func _ready():
	transition.open(1,0)

func _on_Timer_timeout():
	transition.close(1,0)
	load_timer.start()
	
func _on_LoadTimer_timeout():
	var _error = get_tree().change_scene("res://World/Street/StreetLevel.tscn")
