extends CharacterBody2D

# Variables
@onready var timer = $Timer 
@onready var audio_player = $AudioStreamPlayer2D

const SPEED = 300

# Called once when the node enters the tree
func _ready() -> void:
	# Calls start function
	start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# move_and_collide moves the ball based on the velocity * delta (so its smooth)
	# It also returns true/false if it collided or didnt collide onto a surface
	# It also for some reason has other fields????
	var collision = move_and_collide(velocity * delta)
	
	# Checks if a collision happened
	if (collision):
		# Plays the hit noise
		audio_player.play()
		
		# Bounces the normal vector of velocity? pretty much just gets the opposite direction
		var normal: Vector2 = velocity.bounce(collision.get_normal())
		
		# Makes the velocity faster and faster by 5% every time the ball hits something
		# Could clamp the speed to make it max out at a certain point
		velocity = normal * 1.05

# Resets the position of the ball to the starting position and starts timer
func start():
	# Position = Start Position
	position = Vector2(576,320)
	
	# Resets the velocity to no velocity
	velocity = Vector2(0,0)
	
	# Timer so game doesnt restart immediately
	timer.start(1)

# On the timeout of the 1 second timer ->
func _on_timer_timeout() -> void:
	# Makes an array of [-500,500]
	var nums = [SPEED * -1 , SPEED] 
	
	# Gets one of the two values (-500 or 500)
	var random_speed = nums[randi() % nums.size()]
	
	# Sets the velocity vector to a new  unit vector <(1/sqrt(2)), ((-1 or 1)/sqrt(2)> * 500 
	velocity = Vector2(100, randf_range(-100,100)).normalized() * random_speed
