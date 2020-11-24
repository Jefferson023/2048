extends Node2D

var piece_value

func _ready():
	piece_value = 0

func update_value(value):
	piece_value = value
	$background/piece_value_label.text = str(piece_value)
	
func update_color():
	match piece_value:
		0:
			$background.color = Color("#cdc1b4")
			$background/piece_value_label.text = ""
			
		2:
			$background.color = Color(1, 0, 0, 1)	

func update_size(x, y):
	$background.rect_size.x = x
	$background.rect_size.y = y		

func _process(delta):
	update_color()
