extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
			Global.inc_level()
			if get_tree().change_scene("res://Main.tscn") != OK:
				print("Couldn't return to main scene")
				
	#if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
	#	if get_tree().change_scene("res://Main.tscn") != OK:
	#		print("Couldn't return to main scene")
