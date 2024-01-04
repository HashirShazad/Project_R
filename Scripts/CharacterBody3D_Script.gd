extends CharacterBody2D
class_name Player

const ROCK : PackedScene = preload("res://Projectiles/Rock.tscn")
const DAGGER : PackedScene = preload("res://Weapons/Dagger/dagger.tscn")
const ARROW : PackedScene = preload("res://Projectiles/Arrow.tscn")

@export var btn_up : StringName = "P1_Up"
@export var btn_down : StringName  = "P1_Down"
@export var btn_left : StringName = "P1_Left"
@export var btn_right : StringName = "P1_Right"
@export var btn_r_atk : StringName = "P1_R_Atk"
@export var btn_l_atk : StringName = "P1_L_Atk"

var is_stunned : bool = 0
var pixel_offset = 20
var walk_speed = 1.25
var ghost_speed = 1.5
var speed = 1.25
var friction = 12
var direction :Vector2 = Vector2(0, -1)
var max_mana : int = 30
var mana : float 
var max_health : int = 30
var health : float
var max_stamina : int = 30
var stamina : float
var is_dead : bool = 0

@onready var ani_tree = $AnimationTree
enum states {IDLE, WALKING, DAMAGED, DEAD}
var ani = ["parameters/conditions/is_idle",
 "parameters/conditions/is_walking",
 "parameters/conditions/is_damaged",
 "parameters/conditions/is_dead"]

func _ready():
	health = max_health
	stamina = max_stamina
	mana = max_mana
	ani_tree.active = true

func _process(delta):
	ani_player()
	
func _physics_process(_delta):
	if health < 0:
		is_dead = 1
	if is_stunned:
		pass
	else:
		get_input()
		if stamina < 30:
			stamina += _delta
		
		velocity.normalized()
		move_and_collide(velocity)
		
		
func get_input():
	if is_stunned:
		return
	var direction_x = Input.get_axis(btn_left, btn_right)
	var direction_y = Input.get_axis(btn_up, btn_down)
	
	if direction_x:
		direction.x = direction_x
		direction.y = direction_y
		velocity.x = direction_x * speed
		velocity.x = move_toward(0, velocity.x,100)
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
	
	
func ani_player():
	ani_tree["parameters/Idle/blend_position"] = direction
	ani_tree["parameters/Walk/blend_position"] = direction
	ani_tree["parameters/Dead/blend_position"] = direction
	if is_stunned:
		pass
	elif is_dead:
		set_para_ani(states.DEAD)
	elif velocity == Vector2(0,0):
		set_para_ani(states.IDLE)
	else:
		set_para_ani(states.WALKING)
		
func set_para_ani(state: states):
	match state:
		states.IDLE:
			ani_tree[ani[0]] = true
			ani_tree[ani[1]] = false
			ani_tree[ani[2]] = false
			ani_tree[ani[3]] = false
		states.WALKING:
			ani_tree[ani[0]] = false
			ani_tree[ani[1]] = true
			ani_tree[ani[2]] = false
			ani_tree[ani[3]] = false
		states.DAMAGED:
			ani_tree[ani[0]] = false
			ani_tree[ani[1]] = false
			ani_tree[ani[2]] = true
			ani_tree[ani[3]] = false
		states.DEAD:
			ani_tree[ani[0]] = false
			ani_tree[ani[1]] = false
			ani_tree[ani[2]] = false
			ani_tree[ani[3]] = true
			speed = ghost_speed
		
func take_damage(damage : int) -> void:
	health = health - damage

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
		velocity = knock_back
		move_and_collide(velocity)
		is_stunned = true
		set_para_ani(states.DAMAGED)
		await get_tree().create_timer(.3).timeout
		set_para_ani(states.IDLE)
		is_stunned = false
		
