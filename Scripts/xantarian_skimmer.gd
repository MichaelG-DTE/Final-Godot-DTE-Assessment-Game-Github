class_name Enemy2 extends Area2D

signal killed(score)

#VARIABLES 

var bullet_scene = preload("res://Scenes/enemy_laser.tscn")
var health_scene = preload("res://Scenes/health_collectable.tscn")
var shield_scene = preload("res://Scenes/shield_collectable.tscn")

@export var speed = 500
@export var hp = 1
var health_max = 1
var health_min = 0
@export var damage = 1
@export var points = 50
@export var rate_of_fire = 1
@onready var pewpew_1 = $pewpew1
@onready var pewpew_2 = $pewpew2

func _ready():
	rate_of_fire = randf_range(1, 20)

#enemy moves down screen
func _physics_process(delta):
	global_position.y += speed * delta

#enemy dies youve heard it already
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

#enter player, die
func _on_body_entered(body):
	if body is Player:
		body.take_damage(damage)
		print("Enemy Committed Die")
		queue_free()

#shoots, instantiates, shoots, etc
func _on_shoot_timer_timeout():
	shoot(pewpew_1.global_position)
	shoot(pewpew_2.global_position)
	$ShootTimer.wait_time = randf_range(1, 20)
	$ShootTimer.start()

func shoot(location):
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(location)

#no im not doing this again
func _on_visible_on_screen_notifier_2d_screen_exited():
	GlobalVar.score -= points / 2
	queue_free()

#take damage off you go bye
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
		queue_free()
