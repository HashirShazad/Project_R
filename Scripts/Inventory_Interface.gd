extends Control
@onready var p_inv = $P_Inv
@onready var grabbed_slot = $Grabbed_Slot

var grabbed_slot_data: Slot_Data


func _physics_process(delta):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5, 5)
		
		
func set_player_inventory_data(inventory_data: Inventory_Data) -> void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	p_inv.set_inventory_data(inventory_data)

func on_inventory_interact(inventory_data: Inventory_Data,index: int, button: int)-> void:
	match [grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
	update_grabbed_slot()


func update_grabbed_slot() -> void:
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()
