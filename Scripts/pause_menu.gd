extends Control

func _input(event):
	if event.is_action_pressed("Pause"):
		swap_pause_state()

func swap_pause_state():
	if not self.visible:
		self.visible = true
		get_tree().paused = true
	else:
		get_tree().paused = false
		self.visible = false


func _on_resume_pressed():
	get_tree().paused = false
	self.visible = false


func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
	
func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
