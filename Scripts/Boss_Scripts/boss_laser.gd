extends Area2D

#laser SPEEDY
@export var speed = 1000
@export var damage = 3

func start(pos):
	position = pos

#laser uses physics and time to change position, moving constantly downscreen
func _physics_process(delta):
	global_position.y += speed * delta

#When laser go off screen, it will be deleted
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

#Entering the player causes damage 
func _on_body_entered(body):
	if body is Player:
		body.take_damage(damage)
		queue_free()
		
#Entering the shield causes damage
func _on_shield_area_entered(area):
	if area is Shield:
		area.take_damage(damage)
		queue_free()
