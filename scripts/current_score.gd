extends ColorRect

var current_score

signal increase_best(current_score)

func _ready():
	current_score = 0
	
func _on_grid_increase_score(points):
	current_score += points
	$current_score_container/current_score.text = str(current_score)

func _on_grid_game_over():
	emit_signal("increase_best", current_score)

func _on_game_content_reset_score():
	current_score = 0
	$current_score_container/current_score.text = str(0)
