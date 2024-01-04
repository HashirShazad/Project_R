class_name HurtBox
extends Area2D


func _init() -> void:
	collision_layer = 0
	collision_mask = 32
	

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		return
	
	if hitbox.has_method("destroy"):
		hitbox.destroy()
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage, hitbox.hit_stop)
	if owner.has_method("recieve_knock_back"):
		owner.recieve_knock_back(hitbox.global_position, hitbox.knock_back_value)

func area_entered(area):
	_on_area_entered(area)
