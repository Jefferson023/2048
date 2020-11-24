extends ColorRect

const SAVE_DIR = "user://2048/"
const SAVE_PATH = SAVE_DIR + "2048_save.dat"
var best_score = 0

func _ready():
	var directory = Directory.new()
	var file = File.new()
	
	if not (directory.dir_exists(SAVE_DIR)):
		directory.make_dir_recursive(SAVE_DIR)
		
	if not (file.file_exists(SAVE_PATH)):
		var error = file.open_encrypted_with_pass(SAVE_PATH, File.WRITE, OS.get_unique_id())	
		if (error == OK):
			file.store_32(best_score)
	else:
		var error = file.open_encrypted_with_pass(SAVE_PATH, File.READ, OS.get_unique_id())			
		if (error == OK):
			best_score = file.get_32()
	file.close()				
	$best_score_container/best_score.text = str(best_score)		

func save_best_score(score):
	best_score = score
	$best_score_container/best_score.text = str(best_score)
	var directory = Directory.new()
	var file = File.new()
	
	if not (directory.dir_exists(SAVE_DIR)):
		directory.make_dir_recursive(SAVE_DIR)
	var error = file.open_encrypted_with_pass(SAVE_PATH, File.WRITE, OS.get_unique_id())	
	if (error == OK):
		file.store_32(best_score)
	file.close()	
	
func _on_current_score_background_increase_best(current_score):
	if (current_score > best_score):
		save_best_score(current_score)	
