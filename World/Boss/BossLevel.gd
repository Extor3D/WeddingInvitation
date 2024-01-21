extends Node2D

onready var timer = $EndingTimer
onready var transition = $Yohe/Camera2D/Transition

var next = "Nothing"

func _ready():
	Global.life = 3
	transition.open(1)

func _on_Maduro_defeated():
	transition.close(3)
	timer.start()
	next = "Ale"

func _on_EndingTimer_timeout():
	if next == "Ale":
		var _error = get_tree().change_scene("res://World/Menus/AleStart.tscn")
	if next == "Restart":
		var _error = get_tree().change_scene("res://World/Boss/BossLevel.tscn")


func _on_Yohe_defeated():
	transition.close(3)
	timer.start()
	next = "Restart"
