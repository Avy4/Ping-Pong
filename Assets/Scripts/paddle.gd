extends CharacterBody2D

# Variables
@export_enum("RED", "BLUE") var paddle_color : int  
@onready var sprite = $Sprite2D

const SPEED := 550
var color = ""
var screen_size

# Runs once on the creation of the paddle
func _ready() -> void:
	# Sets the screen size to the size of the view
	screen_size = get_viewport_rect().size
	
	# Checks if the enum is 0 or 1
	if (paddle_color == 0):
		
		# If 0 set the paddle color to red and set the color field to RED
		sprite.texture = load("res://Assets/Other/paddle_red.png")
		color = "RED"
	elif (paddle_color == 1):
		
		# If 1 set the paddle color to blue and set the color field to BLUE
		sprite.texture = load("res://Assets/Other/paddle_blue.png")
		color = "BLUE"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Actions were made as RED_up, BLUE_up, RED_down, BLUE_down
	# These statements change which paddle they effect based on the color specified by the enums
	
	# Checks if input is up
	if (Input.is_action_pressed(color + "_up")):
		
		# Up in Godot is negative so move it up every frame by SPEED
		position.y -= SPEED * delta
		
	# Checks if input is down
	elif (Input.is_action_pressed(color + "_down")):
		
		# Down in Godot is positive so move it down every frame by SPEED
		position.y += SPEED * delta
	
	# Clamps the position of the paddles to the screen (its done by the middle of the paddle)
	position.y = clamp(position.y, 0, screen_size.y)

# Function that resets everything back to default
func start():
	# Checks if the paddle is red
	if (paddle_color == 0):
		
		# Revert to red paddle start
		position = Vector2(20,320)
	
	# Checks if the paddle is blue
	elif (paddle_color == 1):
		
		# Revert to blue paddle start
		position = Vector2(1132,320)
