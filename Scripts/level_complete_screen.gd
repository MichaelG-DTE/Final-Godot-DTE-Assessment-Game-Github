extends Control

func _on_next_level_pressed():
	if get_tree().current_scene.level == 1:
		print("Go to level 2")
		get_tree().change_scene_to_file("res://Scenes/level_two.tscn")
	elif get_tree().current_scene.level == 2:
		print("Go to level 3")
		get_tree().change_scene_to_file("res://Scenes/level_three.tscn")
	else: 
		pass

func _on_quit_game_pressed():
	get_tree().quit()
	
func set_score(score):
	$Panel/Score.text = "Score: " + str(GlobalVar.score)
