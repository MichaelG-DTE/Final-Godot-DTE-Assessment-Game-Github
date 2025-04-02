extends Area2D

@export var speed = 600
@export var damage = 2

func start(pos):
	position = pos

#The missile knows where it is, because it knows where it isn't
func _physics_process(delta):
	global_position.y += speed * delta
	
func _on_body_entered(body):
	if body is Player:
		body.take_damage(damage)
		queue_free()
		
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
