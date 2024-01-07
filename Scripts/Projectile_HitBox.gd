extends HitBox
class_name ProjectileHitBox
@export var speed : int = 200
@export var piercing : bool = 1

func _process(delta):
	direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta
	$CollisionShape2D/Sprite2D.z_index = -1
	
func _init() -> void:
	collision_layer = 32
	collision_mask = 0

func destroy():
	if piercing:
		pass
	else:
		queue_free()


func _on_timer_timeout():
	queue_free()
