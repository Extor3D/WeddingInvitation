extends Node2D

func _on_Area2D_area_entered(area):
	area.queue_free()
	queue_free()