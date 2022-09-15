extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set mouse mode
	# Captured hides mouse and locks it to screen center
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Global.enable_music:
		Music.play_music()


func _on_NewGameButton_pressed():
	if Global.enable_music:
		$ButtonSound.play()
	Global.new_game()
	if get_tree().change_scene("res://Main.tscn") != OK:
		print("Error when switching to Main scene")


func _on_ContinueButton_pressed():
	if Global.enable_music:
		$ButtonSound.play()
	if get_tree().change_scene("res://Main.tscn") != OK:
		print("Error when switching to Main scene")
		
		
func _on_OptionsButton_pressed():
	if Global.enable_music:
		$ButtonSound.play()
	if get_tree().change_scene("res://OptionsMenu.tscn") != OK:
		print("Error when switching to OptionsMenu scene")


func _on_ExitButton_pressed():
	if Global.enable_music:
		$ButtonSound.play()  # doesn't work well here
	get_tree().quit()
