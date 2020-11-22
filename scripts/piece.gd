extends Node2D

var piece_value = 0

func _ready():
	pass # Replace with function body.

func update_value(value):
	piece_value = value
	update_color()
	
func update_color():
	match piece_value:
		0:
			pass

func update_size(x, y):
	$background.rect_size.x = x
	$background.rect_size.y = y		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
