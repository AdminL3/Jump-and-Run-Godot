extends Label

var startTime = 0
var elapsedTime = 0
var isTimerRunning = false
@onready var time = $"."

func _ready():
	# Start the timer when the game starts
	startTimer()

func _process(_delta):
	if isTimerRunning:
		# Calculate the elapsed time since the timer started
		var currentTime = Time.get_ticks_msec()
		elapsedTime = currentTime - startTime
		if time != null:
			settime(elapsedTime)
		else:
			print("Error: Time node not found.")

func startTimer():
	# Start or resume the timer
	startTime = Time.get_ticks_msec() - elapsedTime
	isTimerRunning = true

func stopTimer():
	# Pause the timer
	isTimerRunning = false

func settime(time2):
	var totalSeconds = time2 / 1000
	var minutes = int(totalSeconds / 60)
	var seconds = int(totalSeconds % 60)
	var formattedTime = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
	text = formattedTime
