extends Control

func _process(delta):
	$Score.text = "Score: " + str(GlobalVar.score)
	$ShieldBar.value = GlobalVar.shield_health
	$HealthBar.value = GlobalVar.health
