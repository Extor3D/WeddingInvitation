extends Node2D

onready var cutscene_timer = $CutsceneTimer
onready var yohe_solo = $YoheSoloEnd
onready var ale_solo = $AleSoloEnd
onready var ale_yohe = $AleYohe
onready var kiki = $Kiki
onready var camera = $Camera2D
onready var transition = $Camera2D/Transition

onready var first_change_area = $FirstChangeArea
onready var second_change_area = $SecondChangeArea
onready var third_change_area = $ThirdChangeArea
onready var fourth_change_area = $FourthChangeArea
onready var ending_area = $EndingArea

onready var blockade = $Blockade

onready var music = $Music
onready var music_tween = $MusicTween

var cutscene = 0

func _ready():
	ale_yohe.stop_moving()
	transition.open(1.0, 0.25)

func _process(delta):
	if cutscene <= 4:
		camera.position = $FirstCameraPosition.position
		blockade.position = Vector2(0,0)
	else:
		blockade.position = Vector2(198 + (cutscene - 5) * 256, 54)
	
	if cutscene == 5:
		camera.position = $SecondCameraPosition.position
		
	if cutscene == 6:
		camera.position = $ThirdCameraPosition.position
		
	if cutscene == 7:
		camera.position = $FourthCameraPosition.position
		
	if cutscene == 8:
		camera.position = $FifthCameraPosition.position

func _on_CutsceneTimer_timeout():
	do_cutscene()
	
func do_cutscene():
	if cutscene == 0:
		yohe_solo.look()
		Engine.time_scale = 0.3
		cutscene_timer.start(0.45)
	
	if cutscene == 1:
		Engine.time_scale = 1
		yohe_solo.queue_free()
		ale_solo.queue_free()
		ale_yohe.grab()
		ale_yohe.show()
		cutscene_timer.start(1)
	
	if cutscene == 2:
		ale_yohe.spawn_heart()
		cutscene_timer.start(1)

	if cutscene == 3:
		ale_yohe.is_grabbing = false
		ale_yohe.stop = false
		music.play(0)
		
	if cutscene == 4:
		kiki.show()
		kiki.follow(ale_yohe)
	
	if cutscene == 5:
		ale_yohe.change()
		
	if cutscene == 6:
		kiki.change()
		ale_yohe.change()
		
	if cutscene == 7:
		kiki.change()
		ale_yohe.change()
		
	if cutscene == 8:
		cutscene_timer.start(2)
		ale_yohe.end()
		
	if cutscene == 9:
		transition.close(3.0)
		fade_out(music)
		cutscene_timer.start(3)
		
	if cutscene == 10:
		var _error = get_tree().change_scene("res://World/End/EndingSplash.tscn")
		
	cutscene += 1

func _on_MovementStopArea_start_cutscene():
	Engine.time_scale = 0.5
	cutscene_timer.start(1)
	

func _on_FirstChangeArea_body_entered(body):
	do_cutscene()
	first_change_area.queue_free()
	

func _on_SecondChangeArea_body_entered(body):
	do_cutscene()
	second_change_area.queue_free()


func _on_ThirdChangeArea_body_entered(body):
	do_cutscene()
	third_change_area.queue_free()


func _on_FourthChangeArea_body_entered(body):
	do_cutscene()
	fourth_change_area.queue_free()


func _on_EndingArea_body_entered(body):
	do_cutscene()
	ending_area.queue_free()

func fade_out(stream_player):
	# tween music volume down to 0
	music_tween.interpolate_property(stream_player, "volume_db", -10, -80, 3, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	music_tween.start()
	# when the tween ends, the music will be stopped

func _on_MusicTween_tween_completed(object, key):
	object.stop()
