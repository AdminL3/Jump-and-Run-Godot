extends Area2D

class_name Checkpoint
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player = $"../../../Player"


var activated = false


func activate():
	Manager.current_checkpoint = self
	activated = true
	animated_sprite_2d.play("green")

func _on_body_entered(body):
		activate()
	
