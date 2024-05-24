extends Area2D

var inside1 = false
var inside2 = false
var teleporter = 0
var guy
@onready var timer = $Timer
@onready var player = $"../Player"
@onready var player2 = $"../Player2"

#registerportals
func _ready():
	Manager.register_portal(self.global_position.x, self.global_position.y)
	

#enterportal
func _on_body_entered(body):
	if body == player:
		inside1 = true
	elif body == player2:
		inside2 = true
#exitportal
func _on_body_exited(body):
	if body == player:
		inside1 = false
	elif body == player2:
		inside2 = false

#if down pressed start timer play animation
func _physics_process(_delta):
	if inside1:
		if Input.is_action_just_pressed("down"):
			guy = player
			player.portalanimation()
			timer.start()
	if inside2:
		if Input.is_action_just_pressed("down2"):
			guy = player2
			player2.portalanimation()
			timer.start()

#after timer teleport
func _on_timer_timeout():
	Manager.teleport(self.global_position.x, guy)
