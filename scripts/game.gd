extends MarginContainer

func _ready():
	pass

func _on_new_game_button_down():
	var grid = $vertical_grid_menu_container/grid
	grid.clean_grid()
	grid.start_restart_grid()
	grid.create_piece_at_random_position()
	grid.create_piece_at_random_position()
