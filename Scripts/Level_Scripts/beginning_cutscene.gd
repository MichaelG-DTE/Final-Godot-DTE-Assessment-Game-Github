extends Node2D


#starts the player in the cutscene, playing the cutscene
func _ready():
	GlobalVar.is_in_cutscene = true
	$GameStart.play("GameStart")

#after button pressed, changes to the first level
func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_one.tscn")
