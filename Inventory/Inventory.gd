extends PanelContainer

const SLOT = preload("res://Inventory/Slot_POYO_REAL.tscn")

@onready var item_grid: GridContainer = $MarginContainer/Item_Grid


func _ready():
	var inv_data = 
	populate_item_grid()
	
	
func populate_item_grid(slot_datas: Array[Slot_Data]) -> void:
	for child in item_grid.get_children():
		child.queue_free()
	
	for slot_data in slot_datas:
		var slot = SLOT.instantiate()
		item_grid.add_child(slot)
