extends Node2D

onready var transition = $Camera2D/Transition
onready var ale = $AleYYohe/Ale
onready var conf_ale = $AleYYohe/ConfettiAle
onready var yohe = $AleYYohe/Yohe
onready var conf_yohe = $AleYYohe/ConfettiYohe

func _ready():
	transition.open(2, 0.25)

func _process(delta):
	if ale.frame == 0:
		conf_ale.set_emitting(true)
	if yohe.frame == 1:
		conf_yohe.set_emitting(true)


func _on_Link_pressed():
	OS.shell_open("https://www.casamientos.com.ar/web/yoheli-and-alejandro/confirmatuasistencia-3")

func volver():
	var _error = get_tree().change_scene("res://UI/Menu.tscn")

func _on_Volver_pressed():
	transition.close(1)
	$Timer.start(1)

func _on_Timer_timeout():
	volver()
