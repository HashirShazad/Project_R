class_name HurtBox
extends Area2D


func _init() -> void:
	collision_layer = 0
	collision_mask = 32
	
func _ready() -> void:
	pass
	#connect("area_entered", self, "_on_area_entered")

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		return
	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage, hitbox.knock_back_value)

func area_entered(area):
	_on_area_entered(area)
