extends Control

func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_restart_button_pressed():
	GlobalVar.score = 0
	get_tree().reload_current_scene()
	
func set_score(score):
	$Panel/Score.text = "Score: " + str(GlobalVar.score)
