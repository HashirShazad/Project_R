class_name HitBox
extends Area2D

@export var damage : float = 2
@export var knock_back_value : int = 10
@export var stun : float = .2
@export var offset : int = 20
var direction :Vector2 

func _init() -> void:
	collision_layer = 32
	collision_mask = 0



func _on_animation_player_animation_finished(anim_name):
	queue_free()
