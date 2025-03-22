extends Control

@onready var level = 1

func _on_next_level_pressed():
	if level == 1:
		get_tree().change_scene_to_file("res://Scenes/level_two.tscn")
	elif level == 2:
			get_tree().change_scene_to_file("res://Scenes/level_three.tscn")
	else: 
		pass
		
func _on_quit_game_pressed():
	get_tree().quit()
	
func set_score(score):
	$Panel/Score.text = "Score: " + str(GlobalVar.score)
