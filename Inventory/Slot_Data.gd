extends Resource
class_name Slot_Data

const MAX_STACK_SIZE: int = 16
@export var item_data: Item_Data 
@export_range(1, MAX_STACK_SIZE) var quantity: int = 1: set = set_quantity

func can_fully_merge_with(other_slot_data: Slot_Data) -> bool:
	return item_data == other_slot_data.item_data \
			and item_data.stackable \
			and quantity + other_slot_data.quantity < MAX_STACK_SIZE
			
func fully_merge_with(other_slot_data: Slot_Data) -> void:
	quantity += other_slot_data.quantity
	
	
func set_quantity(value: int) -> void:
	quantity = value
	if quantity > 1 and not item_data.stackable:
		quantity = 1
		push_error("%s is not stackable, setting quantity to 1" % item_data.name)
