extends Button

onready var tween = $Tween
var ori_scale

func _ready():
	ori_scale = rect_scale
	rect_pivot_offset = rect_size / 2

func _on_AnimatedButton_mouse_entered():
	$AudioSelect.play()
	tween.remove_all()
	tween.interpolate_property(self,"rect_scale",null,ori_scale * 1.5,1.5,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	tween.start()

func _on_AnimatedButton_mouse_exited():
	$AudioUnselect.play()
	tween.remove_all()
	tween.interpolate_property(self,"rect_scale",null,ori_scale,1.5,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	tween.start()
