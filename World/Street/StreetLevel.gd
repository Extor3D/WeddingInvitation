extends Node2D

onready var camera = $Camera2D
onready var transition = $Camera2D/Transition
onready var cutscene_timer = $CutsceneTimer

onready var ale = $Ale
onready var ale_sit = $AleSit

var cutscene = 0

func _ready():
	transition.open(2)
	if Global.difficulty == Global.DIFF.Easy:
		camera.follow = ale

func do_cutscene():
	if cutscene == 0:
		camera.follow = ale
		camera.hide_parts()
		cutscene_timer.start(3)
		ale.move_forward()
	if cutscene == 1:
		ale_sit.show()
		ale.hide()
		ale.stop()
		cutscene_timer.start(2)
	if cutscene == 2:
		transition.close(2)
		cutscene_timer.start(2)
	if cutscene == 3:
		load_next()
	if cutscene == 99:
		cutscene_timer.start(1)
		transition.close(1)
	if cutscene == 100:
		reload()
	
	cutscene += 1

func _on_Finish_body_entered(body):
	if body.has_method("is_player"):
		if cutscene == 0:
			do_cutscene()
		
func load_next():
	var _error = get_tree().change_scene("res://World/End/Ending.tscn")

func reload():
	var _error = get_tree().change_scene("res://World/Street/StreetLevel.tscn")

func _on_CutsceneTimer_timeout():
	do_cutscene()


func _on_KillArea_body_entered(body):
	if body.has_method("is_player"):
		cutscene = 99
		do_cutscene()

