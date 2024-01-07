extends HitBox
class_name WeaponHitBox

func _process(delta):
	
	$CollisionShape2D.disabled = 0
	$CollisionShape2D/Sprite2D.z_index  = -1
	direction = Vector2.RIGHT.rotated(rotation)
	to_ignore.speed = player_speed
	
func _init() -> void:
	collision_layer = 32
	collision_mask = 0
	
	

func destroy():
	to_ignore.speed = to_ignore.walk_speed
	queue_free()




func _on_timer_timeout():
	destroy()
