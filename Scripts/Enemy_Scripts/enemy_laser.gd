extends Area2D

#speeedy laser gonna killa player
@export var speed = 1000
@export var damage = 1

#starting pos of the laser
func start(pos):
	position = pos

#the global position added to speed (1000), then multiplied by time/ frames (delta), every second
func _physics_process(delta):
	global_position.y += speed * delta

#laser goes off screen and disappears
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

#Entering the player causes damage 
func _on_body_entered(body):
	if body is Player:
		body.take_damage(damage)
		print("you got shot lol")
		queue_free()

#Entering the shield causes damage 
func _on_area_entered(area):
	if area is Shield:
		area.take_damage(damage)
		queue_free()
