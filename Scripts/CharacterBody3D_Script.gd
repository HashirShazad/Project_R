extends CharacterBody2D

const ROCK : PackedScene = preload("res://Projectiles/Rock.tscn")
const DAGGER : PackedScene = preload("res://Weapons/Dagger/dagger.tscn")
const ARROW : PackedScene = preload("res://Projectiles/Arrow.tscn")

@export var btn_up : StringName = "P1_Up"
@export var btn_down : StringName  = "P1_Down"
@export var btn_left : StringName = "P1_Left"
@export var btn_right : StringName = "P1_Right"
@export var btn_r_atk : StringName = "P1_R_Atk"
@export var btn_l_atk : StringName = "P1_L_Atk"

enum states {Idle , Walking}
var is_stunned : bool = 0
var pixel_offset = 20
var walk_speed = 200
var speed = 100
var friction = 16
var direction :Vector2 = Vector2(0, -1)
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
	
	if is_stunned:
		pass
	else:
		get_input()
		if stamina < 30:
			stamina += _delta
	
		move_and_slide()
		if velocity != Vector2(0, 0):
			ani_player(states.Walking)
		else:
			ani_player(states.Idle)
		
		
func get_input():
	if is_stunned:
		return
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
		
	if Input.is_action_just_pressed(btn_r_atk):
		var atk_direction = self.global_position.direction_to(self.global_position + (2 * direction))
		right_hand_attack(atk_direction)
		is_stunned = true
		await get_tree().create_timer(.1).timeout
		is_stunned = false
		
	if Input.is_action_just_pressed(btn_l_atk):
		var atk_direction = self.global_position.direction_to(self.global_position + (2 * direction))
		left_hand_attack(atk_direction)
		is_stunned = true
		await get_tree().create_timer(.2).timeout
		is_stunned = false
	
	
func ani_player(state : states):
	match state:
		states.Idle:
			if direction.y == 1:
				sprite.play("Idle_Down")
			elif direction.y == -1:
				sprite.play("Idle_Up")
			elif direction.x == 1:
				sprite.flip_h = 0
				sprite.play("Idle_Right")
			elif direction.x == -1:
				sprite.flip_h = 1
				sprite.play("Idle_Right")
		
		states.Walking:
			if direction.y == 1:
				sprite.play("Idle_Down")
			elif direction.y == -1:
				sprite.play("Idle_Up")
			elif direction.x == 1:
				sprite.flip_h = 0
				sprite.play("Walk_Right")
			elif direction.x == -1:
				sprite.flip_h = 1
				sprite.play("Walk_Right")

func take_damage(damage : int, knockback : int) -> void:
	health = health - damage
	print(health)

func right_hand_attack(atk_direction):
	if ROCK:
		atk(atk_direction, ROCK,  pixel_offset)

func left_hand_attack(atk_direction):
	if DAGGER:
		atk(atk_direction, DAGGER, 15)
	
func atk(throw_direction, item, offset):
	var throwable = item.instantiate()
	get_tree().current_scene.add_child(throwable)
	throwable.global_position = self.global_position + (offset * direction)
	var throwable_rotation = throw_direction.angle()
	throwable.rotation = throwable_rotation

func recieve_knock_back(damage_source_pos : Vector2, value : int):
	if value != 0:
		var knock_back_direction = damage_source_pos.direction_to(self.global_position)
		var knock_back = value * knock_back_direction
		global_position += knock_back
		
