extends Node

@onready var p1 = %Character
@onready var p2 = %Character2
@onready var inventory_interface = $UI/Inventory_Interface
@onready var p1_inv = $Node2D/Character/Inventory_Interface/P_Inv
@onready var p2_inv = $Node2D/Character2/Inventory_Interface/P_Inv


func _ready() -> void:
	inventory_interface.set_p1_inventory_data(p1.inventory_data)
	inventory_interface.set_p2_inventory_data(p2.inventory_data)
