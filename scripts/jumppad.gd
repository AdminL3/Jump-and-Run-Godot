extends Area2D
@onready var player = %Player
@onready var player2 = %Player2

func _on_body_entered(body):
	if body == player:
		player.jump()
	elif body == player2:
		player2.jump()
