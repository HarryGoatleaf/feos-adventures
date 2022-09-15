extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.enable_music:
		Music.play_music()
	$VBoxContainer/HBoxContainer/CheckBox.pressed = Global.enable_music

# Back Button
func _on_Button_pressed():
	if Global.enable_music:
		$ButtonSound.play()
	if get_tree().change_scene("res://StartMenu.tscn") != OK:
		print("Error when switching to StartMenu scene")

# Music Checkbox
func _on_CheckBox_toggled(new_state):
	Global.enable_music = new_state
	Global.save_data()

	if Global.enable_music:
		$ButtonSound.play()
		Music.play_music()
	else:
		Music.stop_music()
