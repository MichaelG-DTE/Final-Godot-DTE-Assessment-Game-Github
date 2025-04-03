extends Area2D

#laser SPEEDY
@export var speed = -1000
@export var damage = 1

#laser go up screen and kill enemies
func _physics_process(delta):
	global_position.y += speed * delta

#When laser go off screen, it will be sent to the shadow realm
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

#enemies take damage etc
func _on_area_entered(area):
	if area is Enemy or Enemy2 or Enemy3 or Boss:
		area.take_damage(damage)
		queue_free()

#enemy shields take damage
func _on_shield_area_entered(area):
	if area is EnemyShield or bossshield:
		area.take_damage(damage)
		queue_free()
