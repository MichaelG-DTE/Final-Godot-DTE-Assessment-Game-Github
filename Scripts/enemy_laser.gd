extends Area2D

#speeedy laser gonna killa player
@export var speed = 1000
@export var damage = 1

func start(pos):
	position = pos

func _physics_process(delta):
	global_position.y += speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.take_damage(damage)
		print("you got shot lol")
		queue_free()
