extends Node

# Variables
@onready var red_points_label = $HBoxContainer/RedPoints
@onready var blue_points_label = $HBoxContainer/BluePoints
@onready var ball = %Ball
@onready var paddle_red = %RedPaddle
@onready var paddle_blue = %BluePaddle
@onready var audio_player = $AudioStreamPlayer2D
@onready var global_vars = get_node("/root/GlobalVars")

var red_points := 0
var blue_points := 0

# Runs once on creation of the game_manager
func _ready():
	# Gets the current scene and saves it to global_vars
	global_vars.current_scene = get_tree().current_scene.scene_file_path

# Runs once every frame
func _process(delta: float) -> void:
	# Checks if red has gotten to 5 points
	if (red_points == 5):
		
		# If red has gotten to 5 points sets the winner in global_vars to RED (0)
		global_vars.winner = 0
		
		# Changes the scene to the winner screen
		get_tree().change_scene_to_file("res://Assets/Scenes/winner_screen.tscn")
		
	# Checks if blue has gotten to 5 points
	elif (blue_points == 5):
		
		# If blue has gotten to 5 points sets the winner in global_vars to BLUE (1)
		global_vars.winner = 1
		
		# Changes the scene to the winner screen
		get_tree().change_scene_to_file("res://Assets/Scenes/winner_screen.tscn")

# Calls the reset on the paddles and the ball + plays victory noise
func reset():
	# Plays the victory noise
	audio_player.play()
	
	# Calls start (reset) on the ball
	ball.start()
	
	# Calls start (reset) on both paddles
	paddle_red.start()
	paddle_blue.start()

# Called if the ball enters the right scoring zone (point for red)
func _on_scoring_boundaries_right_body_entered(body: Node2D) -> void:
	# Checks to make sure the body entered was infact the ball
	if (body.name == "Ball"):
		
		# Adds a point
		red_points += 1
		
		# Changes the scoreboard to reflect point changes
		red_points_label.text = str(red_points)
		
		# Calls the reset function above
		reset()

# Called if the ball enters the left scoring zone (point for blue)
func _on_scoring_boundaries_left_body_entered(body: Node2D) -> void:
	# Checks to make sure the body entered was infact the ball
	if (body.name == "Ball"):
		
		# Adds a point
		blue_points += 1
		
		# Changes the scoreboard to reflect point changes
		blue_points_label.text = str(blue_points)
		
		# Calls the reset function above
		reset()
