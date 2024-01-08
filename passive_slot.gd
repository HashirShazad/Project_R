extends Slot
class_name Passive_Slot


# Called when the node enters the scene tree for the first time.
func _can_drop_data(at_position, data):
	return data is TextureRect and data.slot_type == slot_type
