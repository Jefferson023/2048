extends Control

export var grid_columns = 4
export var grid_rows = 4
export var margin = 10
var grid = []
var cell_height = 0
var cell_width = 0

const piece_scene = preload("res://scene/piece.tscn")

func _ready():
	update_cell_size()
	start_restart_grid()
	
func update_cell_size():
	var viewport = rect_size
	cell_height = (viewport.y-margin)/4 - margin
	cell_width = (viewport.x-margin)/4 - margin

func start_restart_grid():
	for row in range(0, grid_rows):
		var grid_row = []
		for column in range(0, grid_columns):
			var piece = piece_scene.instance()
			grid_row.append(piece)
			piece.update_size(cell_width, cell_height)
			piece.position = get_position_from_cell(column, row)
			add_child(piece)
		grid.append(grid_row)	
func get_position_from_cell(x, y):
	var horizontal_margin = (x+1)*margin
	var vertical_margin = (y+1)*margin
	var offset_horizontal = x*cell_width
	var offset_vertical = y *cell_height
	return Vector2(horizontal_margin + offset_horizontal, 
	vertical_margin+offset_vertical)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
