extends Node

# Variables
@onready var pause_panel = %PausePanel
@onready var return_to_game = %ReturnToGame
@onready var return_to_menu = %BackToMenu
@onready var timer = $Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Var to store if game has been paused (esc hit?)
	var paused = Input.is_action_just_pressed("pause")
	
	# Checks if game was paused
	if (paused):
		# Pauses the game (stops everything in its tracks)
		get_tree().paused = true
		
		# Shows the pause panel
		pause_panel.show()

# When the return to game button is pressed (comes from signal)
func _on_return_to_game_pressed() -> void:
	# Starts timer so animation can play!
	timer.start()

# When the return to main menu button is pressed (comes from signal)
func _on_back_to_menu_pressed() -> void:
	# Starts timer so animation can play!
	timer.start()
	
	# Have to also unpause it here because if it quits to main menu before the timer times out
	# We are going to be stuck in paused in every scene
	get_tree().paused = false

# When the 1 second timer times out (comes from signal)
func _on_timer_timeout() -> void:
	# Hides the pause panel
	pause_panel.hide()
	
	# Unpauses the game
	get_tree().paused = false
