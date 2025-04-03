extends Control

var second_stage = false

func _process(delta):
	$Score.text = "Score: " + str(GlobalVar.score)
	$Level.text = "Level: " + str(get_tree().current_scene.level)
	$ShieldBar.value = GlobalVar.shield_health
	$HealthBar.value = GlobalVar.health
	
	if get_tree().current_scene.level == 4:
		if !GlobalVar.is_in_cutscene:
			if get_node_or_null("BossHealthBarOne") != null:
				$BossHealthBarOne.visible = true
				$BossHealthBarOne.value = GlobalVar.xarkanthras_health_bar_one
			if GlobalVar.xarkanthras_health_bar_one <= 0:
				$BossHealthBarOne.visible = false
				$BossHealthBarTwo.value = GlobalVar.xarkanthras_health_bar_two
				$BossHealthBarTwo.visible = true
				if second_stage == false:
					$BossHealthUp.play("HealthUp")
					await $BossHealthUp.animation_finished
					second_stage = true
					if GlobalVar.xarkanthras_health_bar_two <= 0:
						$BossHealthBarTwo.visible = false
