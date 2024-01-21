extends Node2D

onready var transition = $Camera2D/Transition

var next = "BACK"

func _ready():
	transition.open(2, 0.25)

func change_screen():
	if next == "BACK":
		var _error = get_tree().change_scene("res://UI/Menu.tscn")
	else:
		var _error = get_tree().change_scene("res://World/Menus/YoheStart.tscn")

func _on_Volver_pressed():
	next = "BACK"
	transition.close(1)
	$Timer.start(1)

func _on_Timer_timeout():
	change_screen()

func _on_Facil_pressed():
	Global.difficulty = Global.DIFF.Easy
	next = "START"
	transition.close(1)
	$Timer.start(1)

func _on_Dificil_pressed():
	Global.difficulty = Global.DIFF.Hard
	next = "START"
	transition.close(1)
	$Timer.start(1)
