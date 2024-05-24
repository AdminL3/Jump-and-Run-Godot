extends Area2D


@export var level : int = 0


func _on_body_entered(body):
	if level == 0:
		Manager.isinscene = 0
		get_tree().change_scene_to_file("res://scenes/lobby.tscn")		
	elif level == 1:
		get_tree().change_scene_to_file("res://scenes/level1.tscn")
		Manager.isinscene = 1
	elif level == 2:
		get_tree().change_scene_to_file("res://scenes/level2.tscn")
		Manager.isinscene = 2
