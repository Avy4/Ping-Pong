extends Node

# Variables
@onready var global_vars = get_node("/root/GlobalVars")
@onready var play_again_button : Button = $CanvasLayer/HBoxContainer/PlayAgain
@onready var winner_label : Label = $CanvasLayer/WinnerLabel

var winner_color : int
var scene_from : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Sets the winner color (int) to either 0 or 1 based on who won
	winner_color = global_vars.winner
	
	# Gets the scene_from (String) which is either the ai_vs_player or two_player scene
	scene_from = global_vars.current_scene
	
	# Sets the play_again_button to scene_from (so it can go back)
	play_again_button.scene_path = scene_from
	
	# Runs init which creates the correct text and colors
	init()

# Intitialization Function
func init():
	# If the winner was RED (0)
	if (winner_color == 0):
		# Sets the color to red
		winner_label.modulate = Color(0.648, 0.023, 0.023)
		
		# Changes the text to Player RED Won
		winner_label.text = "Player RED Won!"
		
	# If the winner was BLUE (1)
	elif (winner_color == 1):
		# Sets the color to blue
		winner_label.modulate = Color(0.151, 0.385, 1)
		
		# Changes the text to Player Blue Won
		winner_label.text = "Player Blue Won!"
	
	
