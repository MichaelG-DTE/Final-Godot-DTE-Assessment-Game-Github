class_name Enemy extends Area2D

signal killed(score)

#variables
var bullet_scene = preload("res://Scenes/Enemy_Scenes/enemy_laser.tscn")
var health_scene = preload("res://Scenes/HealthAndShield_Scenes/health_collectable.tscn")
var shield_scene = preload("res://Scenes/HealthAndShield_Scenes/shield_collectable.tscn")

@export var speed = 350
@export var hp = 3
var health_max = 3
var health_min = 0
@export var damage = 1
@export var points = 100
@onready var explosion_sfx = $Explosion_SFX
@onready var shoot_sfx = $Shoot_SFX


#enemy go down in the same way the projectiles move, by multiplying physics and time
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
	
#enemy dies if it collides with the player
func _on_body_entered(body):
	if body is Player:
		body.take_damage(damage)
		$Explosion.visible = true
		$Ship.visible = false
		$EnemyThrusters.visible = false
		$CollisionShape2D.queue_free()
		$ShootTimer.queue_free()
		$AnimationPlayer.play("Explosion")
		explosion_sfx.play()
		killed.emit(points)
		die()
		await $AnimationPlayer.animation_finished
		$Explosion.visible = false
		queue_free()

#instaniates laser after timer runs out 
func _on_shoot_timer_timeout():
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start($PEwpEw.global_position)
	shoot_sfx.play()

#leave screen, the enemy is destroyed, and you lose half the points the enemy is worth
func _on_visible_on_screen_notifier_2d_screen_exited():
	GlobalVar.score -= points / 2
	queue_free()

#takes damage from player projectiles
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
		explosion_sfx.play()
		killed.emit(points)
		die()
		await $AnimationPlayer.animation_finished
		$Explosion.visible = false
		queue_free()


