extends Node

var currentLevel
var startPosition
var levelliste = [
	"res://Levels/Splash_Screens/Splash_Screen_Controlls.tscn",
	"res://Levels/Tutorial/tutorial0.tscn",
	"res://Levels/Splash_Screens/Splash_Story1.tscn",
	"res://Levels/Tutorial/tutorial2.tscn",
	"res://Levels/Splash_Screens/Splash_Story2.tscn",
	"res://Levels/Splash_Screens/Splash_Story3.tscn",
	"res://Levels/Tutorial/tutorial3.tscn",
	"res://Levels/Splash_Screens/Splash_Story4.tscn",
	"res://Levels/Tutorial/tutorial4.tscn",
	"res://Levels/Splash_Screens/Splash_Story5.tscn",
	"res://Levels/Splash_Screens/Splash_Story6.tscn",
	"res://Levels/Level1.tscn",
	"res://Levels/Level2.tscn",
	"res://Levels/Level3.tscn",
	"res://Levels/Splash_Screens/Splash_Story7.tscn",
	"res://Levels/Level4.tscn",
	"res://Levels/Level41.tscn",
	"res://Levels/Level6.tscn",
	"res://Levels/Level61.tscn",
	"res://Levels/Splash_Screens/Splash_Story8.tscn",
	"res://Levels/Level7.tscn",
	"res://Levels/Level8.tscn",
	"res://Levels/Level5.tscn",
	"res://win.tscn"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set mouse mode
	# Captured hides mouse and locks it to screen center
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# Load a level
	# levelliste[x] corresponds to level x-1
	loadLevel(levelliste[Global.current_level])
	
	if Global.enable_music:
		Music.play_music()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
			$player.reset(startPosition)

# handle player signal collision. This gets emited if the player hits a wall
func _on_player_collision():
	resetPlayer()

# handle player signal win. This gets emited if the player reaches the goal
func _on_player_win():
	Global.inc_level()
	remove_child(currentLevel)
	loadLevel(levelliste[Global.current_level])
	
	
func loadLevel(levelName):
	var levelResource = load(levelName)
	var level = levelResource.instance()
	# get start node
	var startNode = level.get_node_or_null("Start")
	if startNode != null:
		# Level is playable
		# set level parameters
		currentLevel = level
		startPosition = startNode.position
		# load level into scene tree
		add_child(level)
		# reset player
		resetPlayer()
	else:
		if get_tree().change_scene(levelName) != OK:
			print("Couldn't load 'meta' level")


func resetPlayer():
	$player.reset(startPosition)
