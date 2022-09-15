extends VBoxContainer

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			if get_tree().paused:
				resume()
			else:
				pause()


func _on_button_continue_pressed():
	resume()


func _on_button_menu_pressed():
	resume()
	if get_tree().change_scene("res://StartMenu.tscn") != OK:
		print("Couldn't return to main scene")


func _on_button_quit_pressed():
	get_tree().quit()

func pause():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.show()
	get_tree().paused = true
	
func resume():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.hide()
	get_tree().paused = false
