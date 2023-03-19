extends Node

func _ready():
	pass
	
func game_over():
	$HUD.show_game_over()

	
func new_game():
	$numbers.start()
	$HUD.show_message("Dô")
