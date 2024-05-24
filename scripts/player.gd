extends CharacterBody2D

class_name Player

@onready var animated_sprite = $Ritter
@onready var animation = $"../Animation"
var teleporting = false
const SPEED = 130.0
var JUMP_VELOCITY = -200.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hacks = false
var Charakters = []
@export var ispause: bool = false
@onready var manager = %Manager
@onready var jump_sound = %JumpSound



func _ready():
	Manager.player_1 = self
	Charakters = [$Ritter, $Bunny, $Hoodie, $Owl, $Frog]
	change_character()
	

func _physics_process(delta):
	var ispaused = manager.ispaused
		
	if not is_on_floor():
		velocity.y += gravity * delta


	# Handle jump	
	if Input.is_action_just_pressed("hacks"):
		hacks = !hacks
	if !hacks:
		if Input.is_action_just_pressed("up") and is_on_floor() and not teleporting:
			jump_sound.play()
			velocity.y = JUMP_VELOCITY
			return  # Exit the function to prioritize jump animation
	else:
		if Input.is_action_just_pressed("up"):
			velocity.y = JUMP_VELOCITY
			jump_sound.play()
			return  # Exit the function to prioritize jump animation

	# Get the input direction and handle the movement/deceleration
	var direction = Input.get_axis("left", "right")
	
	if character_index != 4:
		animated_sprite = Charakters[character_index+1]
	else:
		animated_sprite = Charakters[0]
	if direction > 0:
		animated_sprite.flip_h = false
		animated_sprite.play("run")
	elif direction < 0:
		animated_sprite.flip_h = true
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
		
		
	if ispause:	
		if Input.is_action_just_pressed("left"):
			Manager._on_change_skin_l_pressed()
		if Input.is_action_just_pressed("right"):
			manager._on_change_skin_l_pressed()
	else:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
		
	#reset/restart
	if Input.is_action_just_pressed("reset"):
		Manager.respawn(self)
		
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if not teleporting and ispaused == 0 and !ispause:
		move_and_slide()


func die(x, y):
	set_global_position(Vector2(x, y))
	
func jump():
	velocity.y = -400

func portalanimation():
	teleporting = true
	animation.play("portal1")
func portalanimation2():
	animation.play("portal1_2")
	teleporting= false

var character_index = 1
func change_character():
	if character_index != 4:
		character_index += 1
	else:
		character_index = 0
	animated_sprite = Charakters[character_index]
	animated_sprite.hide()
	if character_index == 4:	
		Charakters[0].show()
	else:
		Charakters[character_index+1].show()

func dieanimation():
	Charakters[character_index+1].play("die")
