extends Node


var current_level = 0
var max_level = 23
var enable_music = true

func _ready():
	load_data()

# increments the level counter
func inc_level():
	if Global.current_level < Global.max_level:
		Global.current_level += 1
		save_data()
	else:
		Global.current_level = 0;
		save_data()
		
func new_game():
	Global.current_level = 0
	save_data()

func save_data():
	var save_file = File.new()
	save_file.open("user://save.json", File.WRITE)
	var data = {
		"current_level": current_level,
		"enable_music": enable_music
	}
	save_file.store_line(to_json(data))
	save_file.close()
	
func load_data():
	var save_file = File.new()
	if save_file.file_exists("user://save.json"):
		save_file.open("user://save.json", File.READ)
		var data = parse_json(save_file.get_line())
		if data.has("current_level"):
			current_level = data.get("current_level")
		else:
			print("Found save file but without last level. This weird :|")
		if data.has("enable_music"):
			enable_music = data.get("enable_music")
		else:
			print("Found save file but no music preference")
	else:
		print("No save file found. Assuming this is a new player.")
