class_name bossshield extends Area2D

func take_damage(amount):
	GlobalVar.xarkanthras_shield -= amount
	if GlobalVar.xarkanthras_shield == 0:
		GlobalVar.xarkanthras_shield += 15
		queue_free()
