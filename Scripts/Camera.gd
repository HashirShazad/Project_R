extends Camera2D


@onready var P1 = %Character
@onready var P2 = %Character2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = (P1.position + P2.position)/2
	self.zoom.x =  (abs(P1.position.x - P2.position.x))
	self.zoom.y =  (abs(P1.position.y - P2.position.y))

