extends Node

var slidecount


func _ready():
	slidecount = $slides.frames.get_frame_count("default")

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
			next_slide()
				
	if (event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed==true):
			next_slide()
				
func next_slide():
	var curSlide = $slides.frame
	if(curSlide < slidecount-1):
		$slides.frame = curSlide+1
	else:
		next_level()
				
func next_level():
	Global.inc_level()
	if get_tree().change_scene("res://Main.tscn") != OK:
		print("Couldn't return to main scene")
