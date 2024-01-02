extends CharacterBody2D


var speed = 10
var jump_velocity = 4
var friction = .1
var g_multiplier = 1.2

@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	# sprite flip
	if velocity.x > 1:
		sprite.flip_h = 0
	elif velocity.x < -1:
		sprite.flip_h = 1
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed
	move_and_slide()


	
