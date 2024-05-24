extends Area2D

@onready var timer = $Timer
@onready var manager = %Manager



func _on_body_entered(body):
	Manager.respawn(body)
	print("died")
	manager.add_death()
