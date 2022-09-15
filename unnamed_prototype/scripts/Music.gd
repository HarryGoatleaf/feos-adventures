extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_music():
	$BackgroundMusic.play()

func stop_music():
	$BackgroundMusic.stop()
