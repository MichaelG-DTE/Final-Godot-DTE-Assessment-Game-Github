extends Area2D

#speed of the collectable as it moves downscreen
@export var speed = 400

#when the collectable goes off screen, it is deleted from existance
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

#the y position of the object = speed * time, every second
func _process(delta):
	global_position.y += speed * delta

#when the player collides with the object, it adds two to the shield health, 
#and checks whether the GlobalVariable is below the max of 15. If it is 15, it does not add to the shield health
#after that, it deletes the object
func _on_body_entered(body):
	if body is Player:
		if GlobalVar.shield_health < 15:
			GlobalVar.shield_health += 2
		queue_free()
