extends Camera2D


@onready var P1 = %Character
@onready var P2 = %Character2

var const_factor : float = 100.0
var damp_factor : float = 2.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.position = ( P1.position + P2.position ) / 2

