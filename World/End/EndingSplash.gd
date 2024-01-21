extends Node2D

onready var transition = $Camera2D/Transition
onready var tween = $CutsceneTween
onready var thanks_label = $ThanksLabel
onready var cutscene_timer = $CutsceneTimer
onready var invitacion_button = $VerInvitacion

var cutscene = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	transition.open(2, 0.25)

func do_cutscene():
	if cutscene == 0:
		tween.interpolate_property(thanks_label, "modulate:a", 0, 1, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		cutscene_timer.start(2)
	
	if cutscene == 1:
		tween.interpolate_property(invitacion_button, "modulate:a", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		invitacion_button.show()
		
	if cutscene == 2:
		var _error = get_tree().change_scene("res://World/Menus/Invitation.tscn")
		
	cutscene += 1
		

func _on_CutsceneTimer_timeout():
	do_cutscene()


func _on_VerInvitacion_pressed():
	transition.close(1.0)
	cutscene_timer.start(2.0)
