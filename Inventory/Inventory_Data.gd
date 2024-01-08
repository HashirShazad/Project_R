extends Resource
class_name  Inventory_Data

@export var slot_datas: Array[Slot_Data]
func on_slot_clicked(index: int, button: int) -> void:
	print("poyo")
