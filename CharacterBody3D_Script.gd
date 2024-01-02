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
var player_direction :Vector2 = Vector2(0, 0)
@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	
	var direction_x = Input.get_axis(btn_left, btn_right)
	if direction_x:
		velocity.x = direction_x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
		
	var direction_y = Input.get_axis(btn_up, btn_down)
	if direction_y:
		velocity.y = direction_y * speed
	else:
		velocity.y = move_toward(velocity.y, 0, friction)
	
	player_direction = Vector2(direction_x,direction_y)
	
	move_and_slide()
	ani_player()

func ani_player():
	if player_direction.y == 1:
		sprite.play("Down")
	elif player_direction.y == -1:
		sprite.play("Up")
	elif player_direction.x == 1:
		sprite.play("Right")
	elif player_direction.x == -1:
		sprite.play("Left")
	print(player_direction)
	
	


	
