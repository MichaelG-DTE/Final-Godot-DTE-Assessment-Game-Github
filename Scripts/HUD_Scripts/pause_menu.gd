extends Control

#pause button pressed
func _input(event):
	if event.is_action_pressed("Pause"):
		swap_pause_state()

#swaps between paused and unpaused
func swap_pause_state():
	if not self.visible:
		self.visible = true
		get_tree().paused = true
	else:
		get_tree().paused = false
		self.visible = false

#continues the game
func _on_resume_pressed():
	get_tree().paused = false
	self.visible = false

#leave the game yeah yeah i know
func _on_quit_pressed():
	GlobalVar.score = 0
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Levels/main_menu.tscn")

#restart the level? alright then
func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
