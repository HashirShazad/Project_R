extends CharacterBody2D
class_name Player

var WEAPONS = {
	rock  = preload("res://Projectiles/Rock.tscn"),
	arrow = preload("res://Projectiles/Arrow.tscn"),
	dagger_1 = preload("res://Weapons/Dagger/dagger_1.tscn"),
	dagger_2 = preload("res://Weapons/Dagger/dagger_2.tscn")
}

@export var btn_up : StringName = "P1_Up"
@export var btn_down : StringName  = "P1_Down"
@export var btn_left : StringName = "P1_Left"
@export var btn_right : StringName = "P1_Right"
@export var btn_r_atk : StringName = "P1_R_Atk"
@export var btn_l_atk : StringName = "P1_L_Atk"
@export var btn_swap : StringName = "P1_Swap"

var is_dead : bool = 0
var is_dagger: bool = 0
var is_stunned : bool = 0
var is_invulnerable : bool = 0

var pixel_offset = 20
var walk_speed = 1.25
var ghost_speed = 1.5
var dagger_speed = .25
var speed = 1.25
var friction = 12
var direction :Vector2 = Vector2(0, -1)
var max_mana : int = 30
var mana : float 
var max_health : int = 30
var health : float
var max_stamina : int = 30
var stamina : float


@onready var ani_tree = $AnimationTree
enum states {IDLE, WALKING, DAMAGED, DEAD, DAGGER}
var ani = {
	idle = "parameters/conditions/is_idle",
	walking = "parameters/conditions/is_walking",
	damaged =  "parameters/conditions/is_damaged",
	dead =  "parameters/conditions/is_dead"
}

var left_weapon = WEAPONS.dagger_1
var right_weapon = WEAPONS.arrow
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
		speed = ghost_speed
	if is_stunned:
		return
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
		
	if Input.is_action_just_pressed(btn_l_atk):
		var atk_direction = self.global_position.direction_to(self.global_position + (2 * direction))
		left_hand_attack(atk_direction)
	
	if Input.is_action_just_pressed(btn_swap):
		swap_weapon()
	
func swap_weapon():
	if left_weapon == WEAPONS.dagger_1:
		left_weapon = WEAPONS.rock
		return
	if left_weapon == WEAPONS.dagger_2:
		left_weapon = WEAPONS.rock
		return
	if left_weapon ==  WEAPONS.rock:
		left_weapon =  WEAPONS.arrow
		return
	if left_weapon ==  WEAPONS.arrow:
		left_weapon =  WEAPONS.dagger_1
		return
	
func ani_player():
	ani_tree["parameters/Idle/blend_position"] = direction
	ani_tree["parameters/Walk/blend_position"] = direction
	ani_tree["parameters/Dead/blend_position"] = direction
	if is_stunned:
		return
	elif is_dead:
		set_para_ani(states.DEAD)
	elif velocity == Vector2(0,0):
		set_para_ani(states.IDLE)
	else:
		set_para_ani(states.WALKING)
		
func set_para_ani(state: states):
	ani_tree[ani.idle] = false # Idle
	ani_tree[ani.walking] = false # Walk
	ani_tree[ani.damaged] = false # Damaged
	ani_tree[ani.dead] = false
	%CollisionShape2D.disabled = false
	match state:
		states.IDLE:
			ani_tree[ani.idle] = true # Idle
		states.WALKING:
			ani_tree[ani.walking] = true
		states.DAMAGED:
			ani_tree[ani.damaged] = true 
		states.DEAD:
			ani_tree[ani.dead] = true
			ani_tree[ani.idle] = false # Idle
			ani_tree[ani.walking] = false # Walk
			ani_tree[ani.damaged] = false # Damaged
			%CollisionShape2D.disabled = true
			speed = ghost_speed
		
func take_damage(damage : int, hit_stop: float, screw_state : float) -> void:
	hit_stop(0.05, hit_stop)
	health = health - damage
	$Hit_VFX.emitting = 1
	%CollisionShape2D.disabled = 1
	$Sprite2D.self_modulate = Color(1.5, 1.5, 1.5)
	await get_tree().create_timer(screw_state).timeout
	%CollisionShape2D.disabled = 0
	$Sprite2D.self_modulate =  Color(1, 1, 1)
	
func right_hand_attack(atk_direction):
	if is_dead:
		return
	throw(atk_direction, right_weapon,  pixel_offset)

func left_hand_attack(atk_direction):
	if is_dead:
		return
	throw(atk_direction, left_weapon, 10)
	if left_weapon == WEAPONS.dagger_1:
		left_weapon = WEAPONS.dagger_2
	elif left_weapon == WEAPONS.dagger_2:
		left_weapon = WEAPONS.dagger_1
	
func throw(throw_direction, item, offset):
	var throwable = item.instantiate()
	throwable.to_ignore = self
	get_tree().current_scene.add_child(throwable)
	throwable.global_position = self.global_position + (0 * direction)
	var throwable_rotation = throw_direction.angle()
	throwable.rotation = throwable_rotation
	is_stunned = true
	await get_tree().create_timer(throwable.self_stun).timeout
	is_stunned = false

func recieve_knock_back(damage_source_pos : Vector2, value : int, dir : Vector2):
	if is_invulnerable:
		return
	if value != 0:
		var knock_back_direction = dir
		var knock_back = value * knock_back_direction
		velocity = knock_back
		move_and_collide(velocity)
		is_stunned = true
		await get_tree().create_timer(.4).timeout
		set_para_ani(states.IDLE)
		is_stunned = false
		
func hit_stop(timescale, duration):
	Engine.time_scale = timescale
	await get_tree().create_timer(duration * timescale).timeout
	Engine.time_scale = 1

