extends CanvasLayer

onready var transition = $Transition

var button_pressed = "Nothing"

func _ready():
	transition.open(1.0,0.25)
	
func _on_Play_button_down():
	if button_pressed == "Nothing":
		transition.close(1.0)
		$Load.start(1.0)
		button_pressed = "Play"

func _on_VerInvitacion_pressed():
	if button_pressed == "Nothing":
		transition.close(1.0)
		$Load.start(1.0)
		button_pressed = "Invitation"

func _on_Load_timeout():
	Global.reset_values()
	if button_pressed == "Play":
		var _error = get_tree().change_scene("res://World/Menus/DiffSelect.tscn")
	if button_pressed == "Invitation":
		var _error = get_tree().change_scene("res://World/Menus/Invitation.tscn")
