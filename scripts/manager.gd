extends Node


var current_checkpoint : Checkpoint
var scorex = 0
var deaths = 0

@onready var player_1 = %Player
@onready var player_2 = %Player2
@onready var player1 = $CanvasLayer/Pause/Control/Player
@onready var player2 = $CanvasLayer/Pause/Control2/Player2


@onready var score = $Score
@onready var board = $Board
@onready var animation = $"../Animation"
@onready var timer = $CanvasLayer/Time
var isinscene = 0



#respawn at checkpoint
func respawn(body):
	if current_checkpoint != null:
		var x = current_checkpoint.global_position.x
		var y = current_checkpoint.global_position.y
		y = y - 30
		body.die(x, y)
	else:
		print(isinscene)
		if isinscene==0:
			if body == player_1:
				body.die(313, -411)
			elif body == player_2:
				body.die(360, -411)
		elif isinscene==1:
			if body == player_1:
				body.die(-455, -500)
			elif body == player_2:
				body.die(-408, -507)
		elif isinscene==2:
			if body == player_1:
				body.die(137, -857)
			elif body == player_2:
				body.die(183, -858)
				
				
		#get_tree().reload_current_scene() 


func add_point():
	scorex += 1	
func add_death():
	deaths += 1
	
	
func _on_area_2d_body_entered(_body):
	score.text = "You collected " + str(scorex) + " coins and died " + str(deaths) + " times!"
	var time = timer.get_text()
	var timeArray: Array = time.split(":")
	var minutes: int = int(timeArray[0])
	var seconds: int = int(timeArray[1])
	if minutes > 1:
		board.text = "All in a time of "+ str(minutes) + " Minutes and " + str(seconds) + " Seconds!"
	else:
		board.text = "All in a time of "+ str(minutes) + " Minute and " + str(seconds) + " Seconds!"



#teleportation

#step1
var target
func teleport(positionx, guy):
	guy.portalanimation2()
	for i in xportals.size():
		if positionx == xportals[i]:
			var odd = i % 2
			if odd == 1:
				target = i-1
			else:
				target=i+1
			guy.die(xportals[target],yportals[target])

	
	
var xportals = []
var yportals = []
var length = 0
func register_portal(positionx, positiony):
	xportals.append(positionx)
	yportals.append(positiony)
	length = length + 1





@onready var pausesprite = $CanvasLayer/PauseButton/pausesprite
@onready var pause = $CanvasLayer/Pause
var ispaused = 0
func makepause():
	timer.stopTimer()
	if ispaused == 0:
		timer.stopTimer()
		print("was not paused, now is paused,, stopped timer")
		ispaused = 1
		pausesprite.play("play")
		pause.show()
	elif ispaused == 1:
		timer.startTimer()
		print("was paused, now not paused, timer started")
		ispaused=0
		pausesprite.play("pause")
		pause.hide()
	print(ispaused)


func _on_pause_button_pressed():
	makepause()




func _on_change_skin_l_pressed():
	print(ispaused)
	if ispaused ==1 :
		player1.change_character()
		player_1.change_character()

func _on_change_skin_r_pressed():
	print(ispaused)
	if ispaused == 1:
		player2.change_character()
		player_2.change_character()




func _on_music_value_changed(value):
	var percent = value / 100
	var newvalue = percent * 9 -3
	var bus_index = AudioServer.get_bus_index("Master")
	if percent < 0.1:
		newvalue=-70
	AudioServer.set_bus_volume_db(bus_index, newvalue)


