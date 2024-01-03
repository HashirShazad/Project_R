extends CharacterBody2D

@export var ROCK : PackedScene = preload("res://Projectiles/Rock.tscn")
@export var btn_up : StringName = "P1_Up"
@export var btn_down : StringName  = "P1_Down"
@export var btn_left : StringName = "P1_Left"
@export var btn_right : StringName = "P1_Right"
@export var btn_atk : StringName = "P1_Atk"

var walk_speed = 200
var speed = 100
var friction = 16
var direction :Vector2 = Vector2(0, 0)
var max_mana : int = 30
var mana : float 
var max_health : int = 30
var health : float
var max_stamina : int = 30
var stamina : float
var is_dead : bool = 0
@onready var sprite = $AnimatedSprite2D

func _ready():
	health = max_health
	stamina = max_stamina
	mana = max_mana
func _physics_process(_delta):
	
	if health > 0:
		get_input()
		if stamina < 30:
			stamina += _delta
	
		move_and_slide()
		ani_player()
	else:
		is_dead = 1  
		

func get_input():
	
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
		
	if Input.is_action_just_pressed(btn_atk):
		var atk_direction = self.global_position.direction_to(self.global_position + (2 * direction))
		attack(atk_direction)
	
	
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
		
func take_damage(damage : int, knockback : int) -> void:
	health = health - damage
	print(health)

func attack(atk_direction):
	if ROCK:
		throw(atk_direction)
		

func throw(throw_direction):
	var rock = ROCK.instantiate()
	get_tree().current_scene.add_child(rock)
	rock.global_position = self.global_position + 12 * direction
	var rock_rotation = throw_direction.angle()
	rock.rotation = rock_rotation
