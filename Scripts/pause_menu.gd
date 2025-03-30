extends Control


func _on_resume_pressed():
	Input.action_press("Pause")

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
func _on_restart_pressed():
	get_tree().reload_current_scene()
