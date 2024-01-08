extends Control
@onready var p_inv = $P_Inv

func set_player_inventory_data(inventory_data: Inventory_Data) -> void:
	p_inv.set_inventory_data(inventory_data)

