extends Panel
var item_class = preload("res://Legacy/item.tscn")# Changed
var item = null
# Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 2 == 0:
		item = item_class.instantiate()
		add_child(item)

func pick_from_slot():
	remove_child(item)
	var inventory_node = find_parent("Inventory")
	inventory_node.add_child(item)
	item = null
	
func put_into_slot(new_item):
	item  = new_item
	item.position = Vector2(0, 0)
	var inventory_node = find_parent("Inventory")
	inventory_node.remove_child(item)
	add_child(item)
	
func _get_drag_data(at_postition):
	return 
