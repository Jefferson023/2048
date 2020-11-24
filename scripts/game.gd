extends MarginContainer

signal reset_score()

func _ready():
	pass

func _on_new_game_button_down():
	var grid = $vertical_grid_menu_container/grid
	grid.clean_grid()
	grid.start_restart_grid()
	grid.create_piece_at_random_position()
	grid.create_piece_at_random_position()
	grid.has_started = true
	emit_signal("reset_score")
