extends PanelContainer
@onready var quantity_label = $"Quantity Label"
@onready var texture_rect = $MarginContainer/TextureRect

func set_slot_data(slot_data: Slot_Data) -> void:
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
	tooltip_text = "%s\n%s" % [item_data.name, item_data.description]
	
	if slot_data.quantity > 1 :
		quantity_label.text = "x%s" %slot_data.quantity
		quantity_label.show()
