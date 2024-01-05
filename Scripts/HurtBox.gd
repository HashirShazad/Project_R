class_name HurtBox
extends Area2D


func _init() -> void:
	collision_layer = 0
	collision_mask = 32
	

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		return
	if owner == hitbox.to_ignore:
		return
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage, hitbox.hit_stop, hitbox.screw_state)
	if owner.has_method("recieve_knock_back"):
		owner.recieve_knock_back(hitbox.global_position, hitbox.knock_back_value, hitbox.direction)
	if hitbox.has_method("destroy"):
		hitbox.destroy()
	
func area_entered(area):
	_on_area_entered(area)
