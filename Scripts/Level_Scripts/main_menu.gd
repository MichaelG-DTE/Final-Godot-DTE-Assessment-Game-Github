extends Control

#play the game
func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/beginning_cutscene.tscn")
	
#no dont leave pls
func _on_quit_button_pressed():
	get_tree().quit()
