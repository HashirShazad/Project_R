extends Resource
class_name  Inventory_Data

@export var slot_datas: Array[Slot_Data]

signal inventory_interact(inventory_data: Inventory_Data,index: int, button: int)
signal inventory_updated(inventory_data: Inventory_Data)

func on_slot_clicked(index: int, button: int) -> void:
	inventory_interact.emit(self, index, button)

func grab_slot_data(index: int):
	var slot_data = slot_datas[index]
	if slot_data:
		slot_datas[index] = null
		inventory_updated.emit(self)
		return slot_data
	else:
		return null

func drop_slot_data(grabbed_slot_data : Slot_Data, index: int):
	var slot_data = slot_datas[index]
	var return_slot_data: Slot_Data
	if slot_data and slot_data.can_fully_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data)
