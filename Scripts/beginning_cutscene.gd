extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVar.is_in_cutscene = true
	$GameStart.play("GameStart")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_one.tscn")
