extends Control

export var grid_columns = 4
export var grid_rows = 4
export var margin = 10
var grid = []
var cell_height = 0
var cell_width = 0

const piece_scene = preload("res://scene/piece.tscn")
var rng = RandomNumberGenerator.new()

signal increase_score(points)

func _ready():
	update_cell_size()
	start_restart_grid()
	
func update_cell_size():
	var viewport = rect_size
	cell_height = (viewport.y-margin)/4 - margin
	cell_width = (viewport.x-margin)/4 - margin

func start_restart_grid():
	grid = []
	for row in range(0, grid_rows):
		var grid_row = []
		for column in range(0, grid_columns):
			var piece = piece_scene.instance()
			grid_row.append(piece)
			piece.update_size(cell_width, cell_height)
			piece.position = get_position_from_cell(column, row)
			add_child(piece)
		grid.append(grid_row)	
		
func clean_grid():
	for row in range(0, grid_rows):
		for column in range(0, grid_columns): 
			var piece = grid[row][column]
			remove_child(piece)
			piece.queue_free()
			grid.erase(piece)		
			
func get_position_from_cell(x, y):
	var horizontal_margin = (x+1)*margin
	var vertical_margin = (y+1)*margin
	var offset_horizontal = x*cell_width
	var offset_vertical = y *cell_height
	return Vector2(horizontal_margin + offset_horizontal, 
	vertical_margin+offset_vertical)

func get_free_positions():
	var free_positions = []
	for row in range(grid_rows):
		for column in range(grid_columns):
			if (grid[row][column].piece_value == 0):
				free_positions.append([row, column])
	return free_positions	
		
func create_piece_at_random_position():
	rng.randomize()
	var free_positions = get_free_positions()
	if (free_positions.size() > 0):
		var piece_position = free_positions[rng.randi_range(0, 
		free_positions.size()-1)]
		grid[piece_position[0]][piece_position[1]].update_value(2)
	else:
		#game over
		pass
func _process(delta):
	if (Input.is_action_just_pressed("ui_up")):
		_move_up()
		create_piece_at_random_position()	
	elif (Input.is_action_just_pressed("ui_down")):
		_move_down()
		create_piece_at_random_position()	
	elif (Input.is_action_just_pressed("ui_left")):
		_move_left()
		create_piece_at_random_position()
	elif (Input.is_action_just_pressed("ui_right")):
		_move_right()	
		create_piece_at_random_position()		

func _move_up():
	var points = 0
	for column in range(grid_columns):
		#remove todos os espaços vazios e desloca pra cima
		for row in range(grid_rows):
			var piece = grid[row][column]
			for next_row in range(row+1, grid_rows):
				var next_piece = grid[next_row][column]
				if (piece.piece_value == 0) and (next_piece.piece_value != 0):
					piece.update_value(next_piece.piece_value)
					next_piece.update_value(0)
		#soma todos que pode somar			
		for row in range(grid_rows-1):
			var piece = grid[row][column]
			var next_piece = grid[row+1][column]
			if (piece.piece_value == next_piece.piece_value or piece.piece_value == 0):
				#incrementa os pontos
				if (piece.piece_value != 0):
					points += (piece.piece_value + next_piece.piece_value)	
				piece.update_value(piece.piece_value + next_piece.piece_value)
				#remove os espaços em branco criados	
				var last_piece = next_piece
				for next_row in range(row+1, grid_rows-1):
					next_piece = grid[next_row][column]
					last_piece.update_value(next_piece.piece_value)
					next_piece.update_value(0)
					last_piece = next_piece
	emit_signal("increase_score", points)
func _move_down():
	var points = 0
	for column in range(grid_columns):
		#remove todos os espaços vazios e desloca pra cima
		for row in range(grid_rows-1, -1, -1):
			var piece = grid[row][column]
			for next_row in range(row-1, -1, -1):
				var next_piece = grid[next_row][column]
				if (piece.piece_value == 0) and (next_piece.piece_value != 0):
					piece.update_value(next_piece.piece_value)
					next_piece.update_value(0)
		#soma todos que pode somar			
		for row in range(grid_rows-1, 0, -1):
			var piece = grid[row][column]
			var next_piece = grid[row-1][column]
			if (piece.piece_value == next_piece.piece_value or piece.piece_value == 0):
				#incrementa os pontos
				if (piece.piece_value != 0):
					points += (piece.piece_value + next_piece.piece_value)	
				piece.update_value(piece.piece_value + next_piece.piece_value)
				#remove os espaços em branco criados	
				var last_piece = next_piece
				for next_row in range(row-1, -1, -1):
					next_piece = grid[next_row][column]
					last_piece.update_value(next_piece.piece_value)
					next_piece.update_value(0)
					last_piece = next_piece
	emit_signal("increase_score", points)		
func _move_left():
	var points = 0
	for row in range(grid_rows):
		#remove todos os espaços vazios e desloca pra esquerda
		for column in range(grid_columns):
			var piece = grid[row][column]
			for next_column in range(column+1, grid_columns):
				var next_piece = grid[row][next_column]
				if (piece.piece_value == 0) and (next_piece.piece_value != 0):
					piece.update_value(next_piece.piece_value)
					next_piece.update_value(0)
			#soma todos que pode somar			
		for column in range(grid_columns-1):
			var piece = grid[row][column]
			var next_piece = grid[row][column+1]
			if (piece.piece_value == next_piece.piece_value or piece.piece_value == 0):
				#incrementa os pontos
				if (piece.piece_value != 0):
					points += (piece.piece_value + next_piece.piece_value)	
				piece.update_value(piece.piece_value + next_piece.piece_value)
				#remove os espaços em branco criados	
				var last_piece = next_piece
				for next_column in range(column+1, grid_columns-1):
					next_piece = grid[row][next_column]
					last_piece.update_value(next_piece.piece_value)
					next_piece.update_value(0)
					last_piece = next_piece
	emit_signal("increase_score", points)				
func _move_right():
	var points = 0
	for row in range(grid_rows):
		for column in range(grid_columns-1, -1, -1):
			var piece = grid[row][column]
			for next_column in range(column-1, -1, -1):
				var next_piece = grid[row][next_column]
				if (piece.piece_value == 0) and (next_piece.piece_value != 0):
					piece.update_value(next_piece.piece_value)
					next_piece.update_value(0)
		for column in range(grid_columns-1, 0, -1):
			var piece = grid[row][column]
			var next_piece = grid[row][column-1]
			if (piece.piece_value == next_piece.piece_value or piece.piece_value == 0):
				if (piece.piece_value != 0):
					points += (piece.piece_value + next_piece.piece_value)		
				piece.update_value(piece.piece_value + next_piece.piece_value)
				var last_piece = next_piece
				for next_column in range(column-1, 0, -1):
					next_piece = grid[row][next_column]
					last_piece.update_value(next_piece.piece_value)
					next_piece.update_value(0)
					last_piece = next_piece
	emit_signal("increase_score", points)				
