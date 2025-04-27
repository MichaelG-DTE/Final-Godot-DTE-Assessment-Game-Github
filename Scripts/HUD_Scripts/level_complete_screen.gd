extends Control

#handles the level changing
#gets the current levels level count, then changes the level to a new file based on that
func _on_next_level_pressed():
	if get_tree().current_scene.level == 1:
		print("Go to level 2")
		get_tree().change_scene_to_file("res://Scenes/Levels/level_two.tscn")
	elif get_tree().current_scene.level == 2:
		print("Go to level 3")
		get_tree().change_scene_to_file("res://Scenes/Levels/level_three.tscn")
	elif get_tree().current_scene.level == 3:
		get_tree().change_scene_to_file("res://Scenes/Levels/final_level.tscn")
	else:
		pass
#leave the game I guess
func _on_quit_game_pressed():
	GlobalVar.score = 0
	get_tree().change_scene_to_file("res://Scenes/Levels/main_menu.tscn")
	
#sets the current score
func set_score(score):
	$Panel/Score.text = "Score: " + str(GlobalVar.score)
