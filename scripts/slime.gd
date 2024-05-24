extends Node2D

const SPEED = 60

var direction = 1
@onready var ray_cast_l = $"RayCast L"
@onready var ray_cast_r = $"RayCast R"
@onready var animated_sprite = $AnimatedSprite2D
@onready var manager = %Manager

func _process(delta):
	if ray_cast_l.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_r.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta



func _on_area_2d_body_entered(body):
	manager.add_death()
	Manager.respawn(body)
	
