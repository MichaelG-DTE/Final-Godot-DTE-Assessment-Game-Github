extends Control

var second_stage = false

func _process(delta):
	$Score.text = "Score: " + str(GlobalVar.score)
	$Level.text = "Level: " + str(get_tree().current_scene.level)
	$ShieldBar.value = GlobalVar.shield_health
	$HealthBar.value = GlobalVar.health
	
	if get_tree().current_scene.level == 4:
		if !GlobalVar.is_in_cutscene:
			$BossHealthBarOne.visible = true
			$BossHealthBarOne.value = GlobalVar.xarkanthras_health_bar_one
			if GlobalVar.xarkanthras_health_bar_one == 0:
				$BossHealthBarOne.queue_free()
				second_stage = true
				$BossHealthBarTwo.visible = true
				$BossHealthBarTwo.value = GlobalVar.xarkanthras_health_bar_two
