extends Control
@onready var p1_inv = $P1_Inv
@onready var p2_inv = $P2_Inv

func set_p1_inventory_data(inventory_data: Inventory_Data) -> void:
	p1_inv.set_inventory_data(inventory_data)

func set_p2_inventory_data(inventory_data: Inventory_Data) -> void:
	p2_inv.set_inventory_data(inventory_data)
