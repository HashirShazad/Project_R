extends PanelContainer

const SLOT = preload("res://Inventory/Slot_POYO_REAL.tscn")

@onready var item_grid: GridContainer = $MarginContainer/Item_Grid

func set_inventory_data(inventory_data: Inventory_Data) -> void:
	populate_item_grid(inventory_data.slot_datas)
	
func populate_item_grid(slot_datas: Array[Slot_Data]) -> void:
	for child in item_grid.get_children():
		child.queue_free()
	
	for slot_data in slot_datas:
		var slot = SLOT.instantiate()
		item_grid.add_child(slot)
		
		if slot_data:
			slot.set_slot_data(slot_data)
