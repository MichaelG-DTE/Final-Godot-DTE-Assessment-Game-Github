class_name Enemy2 extends Area2D

signal killed(score)

#VARIABLES 

var bullet_scene = preload("res://Scenes/Enemy_Scenes/enemy_laser.tscn")
var health_scene = preload("res://Scenes/HealthAndShield_Scenes/health_collectable.tscn")
var shield_scene = preload("res://Scenes/HealthAndShield_Scenes/shield_collectable.tscn")

@export var speed = 500
@export var hp = 1
var health_max = 1
var health_min = 0
@export var damage = 1
@export var points = 50
@export var rate_of_fire = 1
@onready var pewpew_1 = $pewpew1
@onready var pewpew_2 = $pewpew2
@onready var explosion_sfx = $Explosion_SFX
@onready var shoot_sfx = $Shoot_SFX


func _ready():
	rate_of_fire = randf_range(1, 20)

#enemy moves down screen using physics x time
func _physics_process(delta):
	global_position.y += speed * delta

#enemy dies and drops collectables
func die():
	if randf() >= 0.5:
		if randf() >= 0.5:
			var h = health_scene.instantiate()
			get_tree().root.add_child(h)
			h.global_position = $".".global_position
		else:
			var s = shield_scene.instantiate()
			get_tree().root.add_child(s)
			s.global_position = $".".global_position
	set_deferred("monitoring", false)

#colliding with the player causes the enemy to explode
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

#instantiates the laser on the two guns (pewpew_1, pewpew_2), and then waits a random time before firing again
func _on_shoot_timer_timeout():
	shoot(pewpew_1.global_position)
	shoot(pewpew_2.global_position)
	$ShootTimer.wait_time = randf_range(1, 20)
	$ShootTimer.start()

#the instantiate function
func shoot(location):
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(location)
	shoot_sfx.play()

#leave screen, lose points, dies
func _on_visible_on_screen_notifier_2d_screen_exited():
	GlobalVar.score -= points / 2
	queue_free()

#takes damage, then explodes after health = 0
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
