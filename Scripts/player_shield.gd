class_name Shield extends Area2D

@export var shield_health = 7

func take_damage(amount):
	GlobalVar.shield_health -= 1
	if GlobalVar.shield_health <= 0:
		set_deferred("monitorable", false)
		set_deferred("monitoring", false)
		$".".visible = false
		$CollisionShape2D.disabled = true
