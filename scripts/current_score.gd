extends ColorRect

var current_score

func _ready():
	current_score = 0

func reset_score():
	current_score = 0
	$current_score_container/current_score.text = 0
	
func _on_grid_increase_score(points):
	current_score += points
	$current_score_container/current_score.text = str(current_score)
