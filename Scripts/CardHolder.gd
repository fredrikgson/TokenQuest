extends Node2D

### CARD HOLDER is the node that holds the current card as child

func _ready():
	
	## align to center of screen
	## to make sure card is vertically centered no matter the device dimension
	align_vertically(get_viewport_rect().size.y)


func align_vertically(window_height):
	self.position.y = window_height / 2
