extends Control

var second_stage = false

#processes the current health and shield of the player, based on the global variable, then assigns it to the labels and bars
func _process(delta):
	$Score.text = "Score: " + str(GlobalVar.score)
	$Level.text = "Level: " + str(get_tree().current_scene.level)
	$ShieldBar.value = GlobalVar.shield_health
	$HealthBar.value = GlobalVar.health
	
	#Handles the boss health bar spawning after the cutscene, and changing health bars in the animation, in the second stage
	if get_tree().current_scene.level == 4:
		if !GlobalVar.is_in_cutscene:
			#to ensure the bar exists
			if get_node_or_null("BossHealthBarOne") != null:
				$BossHealthBarOne.visible = true
				#assigns the value of the boss health bar to the global variable
				$BossHealthBarOne.value = GlobalVar.xarkanthras_health_bar_one
			if GlobalVar.xarkanthras_health_bar_one <= 0:
				$BossHealthBarOne.visible = false
				#assigns the value of the second boss health bar to the global variable
				$BossHealthBarTwo.value = GlobalVar.xarkanthras_health_bar_two
				$BossHealthBarTwo.visible = true
				if second_stage == false:
					$BossHealthUp.play("HealthUp")
					await $BossHealthUp.animation_finished
					second_stage = true
					if GlobalVar.xarkanthras_health_bar_two <= 0:
						$BossHealthBarTwo.visible = false
