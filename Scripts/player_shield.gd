class_name Shield extends Area2D

func take_damage(amount):
	GlobalVar.shield_health -= amount

func _process(delta):
	if GlobalVar.shield_health <= 0:
		set_deferred("monitorable", false)
		set_deferred("monitoring", false)
		$".".visible = false
		$CollisionShape2D.disabled = true
	else:
		if GlobalVar.shield_health >= 1:
			set_deferred("monitorable", true)
			set_deferred("monitoring", true)
			$".".visible= true
			$CollisionShape2D.disabled = false
