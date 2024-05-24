
extends Area2D

@onready var player = %Player
@onready var player_2 = %Player2
@onready var manager = %Manager
@onready var coin_sound = %CoinSound



func _on_body_entered(body):
	if body == player || body == player_2:
		coin_sound.play()
		manager.add_point()
		queue_free()
