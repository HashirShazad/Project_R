extends HitBox
class_name WeaponHitBox

func _process(delta):
	$CollisionShape2D.disabled = 0
	direction = Vector2.RIGHT.rotated(rotation)
	
func _init() -> void:
	collision_layer = 32
	collision_mask = 0


func destroy():
	
	queue_free()




func _on_timer_timeout():
	destroy()
