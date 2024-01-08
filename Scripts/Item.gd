extends Node2D

const SLOT_CLASS = preload("res://Scripts/Slot.gd")
@onready var inventory_slots = $TextureRect/GridContainer
var holding_item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 2 == 0:
		$TextureRect.texture = load("res://Inventory/Iron Sword.png")
	else:
		$TextureRect.texture = load("res://Inventory/Tree Branch.png")
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", self.slot_gui_input, [inv_slot])

func slot_gui_input(event: InputEvent, slot: SLOT_CLASS):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if holding_item != null:
				slot.put_into_slot(holding_item)
				holding_item = null
			else:
				var temp_item = slot.item
				slot.pick_from_slot()
				temp_item.global_position = event.global_position
				slot.put_into_slot(holding_item)
				holding_item = temp_item
		elif slot.item:
			holding_item = slot.item
			slot.pick_from_slot()
			holding_item.global_position = get_global_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
		

