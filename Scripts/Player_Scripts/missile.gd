extends Area2D

@export var speed = -600
@export var damage = 2

#The missile travels up the screen by using physics and time to travel forward
func _physics_process(delta):
	global_position.y += speed * delta

#enemies take damage from the missile
func _on_area_entered(area):
	if area is Enemy or Enemy2 or Enemy3 or Boss:
		area.take_damage(damage)
		queue_free()

#the missile is removed after exiting the screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
