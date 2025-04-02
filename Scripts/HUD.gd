extends Control

var second_stage = false

func _process(delta):
	$Score.text = "Score: " + str(GlobalVar.score)
	$Level.text = "Level: " + str(get_tree().current_scene.level)
	$ShieldBar.value = GlobalVar.shield_health
	$HealthBar.value = GlobalVar.health
	
	if get_tree().current_scene.level == 4:
		if !GlobalVar.is_in_cutscene and get_tree().current_scene.level == 4:
			$BossHealthBar2.visible = true
			$BossHealthBar2.value = GlobalVar.xarkanthras_health_bar_one
			if $BossHealthBar2.value == 0 and second_stage == false:
				second_stage = true
				$BossHealthBar2.queue_free()
				print("second stage")
				$BossHealthBar.visible = true
				$BossHealthBar.value = GlobalVar.xarkanthras_health_bar_two
				print("playing ANIMATION")
				$BossHealthBarAnimation.play("HealthBarUp")
				await $BossHealthBarAnimation.animation_finished
				print("FINISHED ANIMATION")
