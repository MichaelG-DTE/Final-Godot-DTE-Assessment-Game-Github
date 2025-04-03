class_name bossshield extends Area2D

#boss shield takes damage what else
func take_damage(amount):
	GlobalVar.xarkanthras_shield -= amount
	if GlobalVar.xarkanthras_shield == 0:
		GlobalVar.xarkanthras_shield += 50 
		queue_free()
