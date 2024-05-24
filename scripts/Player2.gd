extends CharacterBody2D

class_name Player2

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation = $"../Animation"
var teleporting = false
const SPEED = 130.0
var JUMP_VELOCITY = -200.0
const IDLE_TIME = 1.0  # 1 second
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var idle_timer = 0.0
var hacks = false
var Charakters = []
@onready var manager = %Manager
@export var ispause: bool = false
@onready var jump_sound = %JumpSound


func _ready():
	
	Manager.player_2 = self
	Charakters = [$Turtle, $VR, $Dart, $Pink, $Mushroom]
	change_character()
	
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta

	#veloci
	if Input.is_action_just_pressed("hacks"):
		print(hacks)
		hacks = !hacks
		print(hacks)
	if !hacks:
		if Input.is_action_just_pressed("up2") and is_on_floor() and not teleporting:
			velocity.y = JUMP_VELOCITY
			jump_sound.play()
			return  # Exit the function to prioritize jump animation
	else:
		if Input.is_action_just_pressed("up2"):
			velocity.y = JUMP_VELOCITY
			jump_sound.play()
			return  # Exit the function to prioritize jump animation

	# Get the input direction and handle the movement/deceleration
	var direction = Input.get_axis("left2", "right2")
	if character_index != 4:
		animated_sprite = Charakters[character_index+1]
	else:
		animated_sprite = Charakters[0]
		
		
	if direction > 0:
		if character_index==3:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
		animated_sprite.play("run")
	elif direction < 0:
		if character_index==3:
			animated_sprite.flip_h = false
		else:
			animated_sprite.flip_h = true
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
		
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
		
	if Input.is_action_just_pressed("change_charakter2"):
		change_character()
		
	#reset/restart
	if Input.is_action_just_pressed("reset2"):
		Manager.respawn(self)
		
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
	if not teleporting  and !ispause and ismulti:
		move_and_slide()
#die/teleport
func die(x, y):
	set_global_position(Vector2(x, y))
	
	#bouncepad
func jump():
	velocity.y = -400

#animation
func portalanimation():
	teleporting = true
	animation.play("portal2")
func portalanimation2():
	animation.play("portal2_2")
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


@onready var private_cam = %PrivateCam
@onready var group_cam = %GroupCam


#multiplayer
var ismulti = false
func _on_multi_pressed():
	ismulti = !ismulti
	if ismulti:
		print("now multiplayer")
		print(private_cam.enabled)
		print(group_cam.enabled)
		private_cam.enabled=false
		group_cam.enabled = true
		print(private_cam.enabled)
		print(group_cam.enabled)
	else:
		print("now singleplayer")
		Manager.respawn(self)
		private_cam.enabled=true
		group_cam.enabled = false
		

