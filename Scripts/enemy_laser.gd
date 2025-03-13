extends Area2D

#speeedy laser gonna killa player
@export var speed = 550
@export var damage = 1

func _physics_process(delta):
	global_position.y = speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
 
