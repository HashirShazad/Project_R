extends CharacterBody2D

@export var btn_up : StringName = "P1_Up"
@export var btn_down : StringName  = "P1_Down"
@export var btn_left : StringName = "P1_Left"
@export var btn_right : StringName = "P1_Right"

var walk_speed = 200
var speed = 150
var jump_velocity = 4
var friction = 10
var g_multiplier = 1.2
var direction :Vector2 = Vector2(0, 0)
var mana : int = 30
var health : int = 30
var stamina : int = 30

@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	
	var direction_x = Input.get_axis(btn_left, btn_right)
	var direction_y = Input.get_axis(btn_up, btn_down)
	
	if direction_x:
		direction.x = direction_x
		direction.y = direction_y
		velocity.x = direction_x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
	if direction_y:
		direction.y = direction_y
		direction.x = direction_x
		velocity.y = direction_y * speed
	else:
		velocity.y = move_toward(velocity.y, 0, friction)
	
	
	move_and_slide()
	ani_player()

func ani_player():
	if direction.y == 1:
		sprite.play("Idle_Down")
		
	elif direction.y == -1:
		sprite.play("Idle_Up")
		
	elif direction.x == 1:
		sprite.flip_h = 0
		
		if velocity.x > 20:
			sprite.play("Walk_Right")
		else:
			sprite.play("Idle_Right")
		
	elif direction.x == -1:
		sprite.flip_h = 1
		
		if velocity.x < -1:
			sprite.play("Walk_Right")
		else:
			sprite.play("Idle_Right")
		
	


	
