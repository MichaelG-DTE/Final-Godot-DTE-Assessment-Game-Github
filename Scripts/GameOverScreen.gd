extends Control

#like I said earlier, why, oh why would you leave such a good game?
func _on_quit_button_pressed():
	GlobalVar.score = 0
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

#try again!
func _on_restart_button_pressed():
	GlobalVar.dead = false
	GlobalVar.xarkanthras_health_bar_one = 800
	GlobalVar.xarkanthras_health_bar_two = 900
	get_tree().reload_current_scene()
	
#sets the current score to be displayed on the gameoverscreen
func set_score(score):
	$Panel/Score.text = "Score: " + str(GlobalVar.score)
