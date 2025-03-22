extends Control

func _process(delta):
	$Score.text = "Score: " + str(GlobalVar.score)

func shield_depletion(Shield):
	pass
