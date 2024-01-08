extends PanelContainer
class_name Slot
@onready var texture = $TextureRect
@export_enum("NONE: 0", "LEFT_HAND: 1", "RIGHT_HAND: 2") var slot_type: int	

func _get_drag_data(at_position):
	set_drag_preview(get_preview())
	return texture

func _can_drop_data(at_position, data):
	return data is Texture

func _drop_data(at_position, data):
	var temp = texture.texture
	texture.texture = data.texture
	data.texture = temp
	
func get_preview():
	var preview = TextureRect.new()
	
	preview.texture = texture.texture
	preview.size = Vector2(30, 30)
	
	return preview
