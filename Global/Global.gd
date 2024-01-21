extends Node

signal blocks_switched

var max_coins = 0
var current_coins = 0
var max_life = 3
var life = max_life

var text_box = ""

enum DIFF {Easy, Hard}
var difficulty = DIFF.Easy

var block_switch = true

func _unhandled_input(_event):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

func init_coin():
	max_coins += 1

func collect_coin():
	current_coins += 1

func switch_blocks():
	block_switch = !block_switch
	emit_signal("blocks_switched")
	
func take_damage():
	if Global.difficulty == Global.DIFF.Hard:
		life -= 1

func restart_game():
	reset_values()
	var _error = get_tree().reload_current_scene()
	
func reset_values():
	max_coins = 0
	current_coins = 0
	life = max_life
	block_switch = true
	text_box = ""
