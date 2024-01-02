extends Camera2D


@onready var P1 = %Character
@onready var P2 = %Character2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = (P1.position + P2.position)/2

