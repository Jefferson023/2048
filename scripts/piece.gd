extends Node2D

var piece_value = 0

func _ready():
	pass # Replace with function body.

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
			$background.color = Color(1, 0, 0, 1)	

func update_size(x, y):
	$background.rect_size.x = x
	$background.rect_size.y = y		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
