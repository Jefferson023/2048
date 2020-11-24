extends Node2D

var piece_value

func _ready():
	piece_value = 0

func update_value(value):
	piece_value = value
	$background/piece_value_label.text = str(piece_value)
	update_color()
	
func update_color():
	match piece_value:
		0:
			$background.color = Color("#cdc1b4")
			$background/piece_value_label.text = ""
			
		2:
			$background.color = Color("#eee4da")
		4:
			$background.color = Color("#eee1c9")
		8:
			$background.color = Color("#f3b27a")				
		16:
			$background.color = Color("#f69664")
		32:
			$background.color = Color("#f77c5f")
		64:	
			$background.color = Color("#f75f3b")
		_:
			$background.color = Color("#f75f3b")
					
func update_size(x, y):
	$background.rect_size.x = x
	$background.rect_size.y = y		
