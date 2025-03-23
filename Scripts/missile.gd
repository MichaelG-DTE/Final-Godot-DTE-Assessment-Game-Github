extends Area2D

@export var speed = -850
@export var damage = 2

#The missile knows where it is, because it knows where it isn't
func _physics_process(delta):
	global_position.y += speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area is Enemy or Enemy2 or Enemy3:
		area.take_damage(damage)
		queue_free()

