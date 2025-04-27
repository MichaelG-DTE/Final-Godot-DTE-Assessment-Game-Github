extends Area2D

@export var speed = 600
@export var damage = 3

#the starting position of the missile, later called for instantiating
func start(pos):
	position = pos

#uses physics and time to move forward
func _physics_process(delta):
	global_position.y += speed * delta
	
#collides with the player, causes damage
func _on_body_entered(body):
	if body is Player:
		body.take_damage(damage)
		queue_free()

#not on screen = deleted
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
