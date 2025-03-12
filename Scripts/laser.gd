extends Area2D
#laser SPEEDY
@export var speed = -550
#laser go up screen and kill enemies
func _physics_process(delta):
	global_position.y += speed * delta

#When laser go off screen, it will be sent to the shadow realm
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
