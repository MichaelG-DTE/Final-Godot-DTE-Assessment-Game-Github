class_name Enemy3 extends Area2D

signal killed(score)

var bullet_scene =  preload("res://Scenes/enemy_laser.tscn")

@export var speed = 150
@export var hp = 3
@export var damage = 1
@export var points = 150

func _physics_process(delta):
	global_position.y += speed * delta

func die():
	queue_free()
	
func _on_shoot_timer_timeout():
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start($pewpPew.global_position)


func _on_body_entered(body):
	if body is Player:
		body.take_damage(damage)
		print("Enemy 3 Committed Die")
		queue_free()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	GlobalVar.score -= points / 2
	queue_free()
	
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
		await $AnimationPlayer.animation_finished
		$Explosion.visible = false
		set_deferred("monitoring", false)
		die()


