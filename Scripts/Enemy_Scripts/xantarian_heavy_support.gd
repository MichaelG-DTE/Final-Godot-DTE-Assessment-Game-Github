class_name Enemy3 extends Area2D

signal killed(score)

#variables
var bullet_scene = preload("res://Scenes/Enemy_Scenes/enemy_laser.tscn")
var health_scene = preload("res://Scenes/HealthAndShield_Scenes/health_collectable.tscn")
var shield_scene = preload("res://Scenes/HealthAndShield_Scenes/shield_collectable.tscn")

@export var speed = 150
@export var hp = 4
var health_max = 4
var health_min = 0
@export var damage = 1
@export var points = 150
@onready var explosion_sfx = $Explosion_SFX
@onready var shoot_sfx = $Shoot_SFX


#enemy moves down screen in the same way the fightercraft does
func _physics_process(delta):
	global_position.y += speed * delta

#drops collectable on death
func die():
	if randf() >= 0.85:
		if randf() >= 0.5:
			var h = health_scene.instantiate()
			get_tree().root.add_child(h)
			h.global_position = $".".global_position
		else:
			var s = shield_scene.instantiate()
			get_tree().root.add_child(s)
			s.global_position = $".".global_position
	set_deferred("monitoring", false)

#instantiates lasers and spawns them on the position of the 'gun' (pewpPew)
func _on_shoot_timer_timeout():
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start($pewpPew.global_position)
	shoot_sfx.play()
	
#collides with the player and explodes
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

#after leaving the screen, the enemy dies and half the points are lost
func _on_visible_on_screen_notifier_2d_screen_exited():
	GlobalVar.score -= points / 2
	queue_free()

#the enemy takes damage from the player projectiles
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
