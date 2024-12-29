extends CharacterBody2D

# Variables
@export var ball : CharacterBody2D 
@onready var sprite = $Sprite2D

const SPEED := 350 # Slower since the AI works off of different movement
var screen_size # Used for bounds

# Runs once on the creation of the paddle
func _ready() -> void:
	# Sets the screen size to the size of the view
	screen_size = get_viewport_rect().size
	
	# If 1 set the paddle color to blue and set the color field to BLUE
	sprite.texture = load("res://Assets/Other/paddle_blue.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Checks if the ball is moving towards the AI
	if (ball.velocity.x > 0):
		
		# Variables 
		var velocity_y = ball.velocity.y # Stores the y velocity of the ball
		var delta_speed = SPEED * delta # SPEED * delta -> how much paddle should move a frame
		var pos_change = velocity_y * delta # Position change on the ball in a frame
		
		# AI only starts playing after the ball reaches the net (halfway point)
		if (ball.position.x > 576):
			
			# move_toward returns a float position.y + delta_speed in the direction of field 2
			# We set the new position to the float position returned by move_toward (moves paddle)
			
			# Ball moving up in the y direction, the velocity is negative
			if (velocity_y < 0):
				
				# Calls move towards and changes the position
				position.y = move_toward(position.y, ball.position.y - pos_change, delta_speed)
			
			# Ball moving down in the y direction, the velocity is positive
			elif (velocity_y > 0):
				
				# Calls move towards and changes the position
				position.y = move_toward(position.y, ball.position.y + pos_change, delta_speed)
	
	# Clamps the position of the paddles to the screen (its done by the middle of the paddle)
	position.y = clamp(position.y, 0, screen_size.y)

# Function that resets everything back to default
func start():
	# Revert to blue paddle start
	position = Vector2(1132,320)
