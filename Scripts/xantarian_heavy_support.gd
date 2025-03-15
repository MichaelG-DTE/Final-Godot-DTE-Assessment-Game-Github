class_name Enemy3 extends Area2D

signal killed(score)

@export var speed = 150
@export var hp = 3
@export var points = 150

func _physics_process(delta):
	global_position.y += speed * delta

func die():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.die()
		print("Enemy Killed")
		queue_free()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func take_damage(amount):
	hp -= amount
	if hp <= 0:
		killed.emit(points)
		die()

func explode():
	speed = 0
	
