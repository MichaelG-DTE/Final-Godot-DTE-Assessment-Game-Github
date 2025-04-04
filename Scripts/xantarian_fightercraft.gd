class_name Enemy extends Area2D

signal killed(score)

#variables
var bullet_scene =  preload("res://Scenes/enemy_laser.tscn")
var health_scene = preload("res://Scenes/health_collectable.tscn")
var shield_scene = preload("res://Scenes/shield_collectable.tscn")

@export var speed = 350
@export var hp = 3
var health_max = 3
var health_min = 0
@export var damage = 1
@export var points = 100

#enemy go down because math
func _physics_process(delta):
	global_position.y += speed * delta

#random chance to drop either health or shield collectable
func die():
	if randf() >= 0.75:
		if randf() >= 0.5:
			var h = health_scene.instantiate()
			get_tree().root.add_child(h)
			h.global_position = $".".global_position
		else:
			var s = shield_scene.instantiate()
			get_tree().root.add_child(s)
			s.global_position = $".".global_position
	set_deferred("monitoring", false)
	
#enemy dies if enters the player
func _on_body_entered(body):
	if body is Player:
		body.take_damage(damage)
		print("Enemy 2 Committed Die")
		queue_free()

#shoots laser 
func _on_shoot_timer_timeout():
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start($PEwpEw.global_position)

#leave screen, lose points
func _on_visible_on_screen_notifier_2d_screen_exited():
	GlobalVar.score -= points / 2
	queue_free()

#takes damage from player
func take_damage(amount):
	hp -= amount
	if hp <= 0:
		speed = 0
		$Explosion.visible = true
		$Ship.visible = false
		$EnemyThrusters.visible = false
		$CollisionShape2D.queue_free()
		$ShootTimer.queue_free()
		$AnimationPlayer.play("Explosion")
		killed.emit(points)
		die()
		await $AnimationPlayer.animation_finished
		$Explosion.visible = false
		set_deferred("monitoring", false)
		queue_free()


