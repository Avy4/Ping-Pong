extends Button

# Variables
@export var scene_path :  String
@export_enum("SCENECHANGE", "RETURNTOGAME") var change_type : int  
@onready var animation_player = $AnimationPlayer

# Runs when the button has been pressed (from a signal)
func _on_pressed() -> void:
	# Plays the beautiful animation I made
	animation_player.play("button_click")

# Runs when the animation finished (from a signal)
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	# Checks if the button is supposed to change to a different scene (0 = diff scene)
	if (change_type == 0):
		# Changes the scene to the scene in scene_path
		get_tree().change_scene_to_file(scene_path)
	
	# Checks if the button is supposed to return to the game from the main menu (1 = main menu ret)
	elif (change_type == 1):
		# Does nothing cause it's handled in pause_menu.gd 
		pass
