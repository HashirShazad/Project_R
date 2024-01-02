extends CharacterBody2D


var speed = 10
var jump_velocity = 4
var friction = .1
var g_multiplier = 1.2

@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):

	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed
	move_and_slide()
	ani_player()

func ani_player():
	if velocity.y > 1:
		sprite.play("Down")
	elif velocity.y < -1:
		sprite.play("Up")
	elif velocity.x > 1:
		sprite.play("Right")
	elif velocity.x < -1:
		sprite.play("Left")
	
	


	
