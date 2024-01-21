extends Node2D

export (NodePath) var follow 

onready var follow_node = get_node(follow)

func _process(delta):
	if follow_node:
		self.position = follow_node.get_camera_screen_center() * 0.90
