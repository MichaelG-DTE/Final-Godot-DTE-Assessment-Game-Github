#puts the player into a class, so that it can be detected by the enemies and enemy lasers
class_name Player extends CharacterBody2D

#signals
signal laser_shot(laser_scene, location)
signal missile_shot(missile_scene, location)
signal killed

#variables speed, fire, screen, pew pew(the position where the lasers spawn), ms (where the missiles spawn)
@export var speed = 600
@export var rate_of_fire = 0.15
@export var missile_fire_rate = 1.5
@onready var screensize = get_viewport_rect().size
@onready var pew_pew = $PewPew
@onready var ms = $missileshooty

#preloading laser
var laser_scene = preload("res://Scenes/laser.tscn")
var missile_scene = preload("res://Scenes/missile.tscn")

#shoot and missile cooldown
var shoot_cd := false
var missile_cd := false

#if dead = false, then the player can move and shoot
var dead = false

#every second, the game checks for the input from the mouse or keyboard, and then assures whether the player is not dead, and the cooldown is true
#it then calls the func "shoot"
#after that, it creates a timer to cooldown, which then resets the shoot or missiles cooldown back to false, so the process repeats
func _process(delta):
	if Input.is_action_pressed("Shoot"):
		if !shoot_cd and !dead:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cd = false
	if Input.is_action_pressed("MissileShoot"):
		if !missile_cd and !dead:
			missile_cd = true
			shoot2()
			await get_tree().create_timer(missile_fire_rate).timeout
			missile_cd = false
	else:
		pass

#every second, the physics is processed, which allows for movement
#movement and banking left and right
#the animation for the player and the thrusters is determined on whether the player is moving up, left or right
func _physics_process(delta):
	if !dead:
		var direction = Input.get_vector("Left", "Right", "Up", "Down")
		if direction.x > 0:
			$Shiptexture.animation = "Ship_Right"
			$Shiptexture/ThrustersAnimation.play("RightThrusters")
			$Shiptexture/Thrusters_Right.visible = true
			$Shiptexture/Thrusters.visible = false
			$Shiptexture/Thrusters_Left.visible = false 
		elif direction.x < 0:
			$Shiptexture.animation = "Ship_Left"
			$Shiptexture/ThrustersAnimation.play("LeftThrusters")
			$Shiptexture/Thrusters_Left.visible = true
			$Shiptexture/Thrusters.visible = false
			$Shiptexture/Thrusters_Right.visible = false
		else: 
			$Shiptexture.animation = "Ship"
			$Shiptexture/Thrusters.visible = true
			$Shiptexture/Thrusters_Left.visible = false 
			$Shiptexture/Thrusters_Right.visible = false
		velocity = direction * speed
		move_and_slide()
	
#clamps the player into the scene, preventing leaving the camera sight
	global_position = global_position.clamp(Vector2(60, 60), screensize - Vector2(60, 60))
	
	#when the shoot function is called, the laser scene is instantiated in the level script at the position of the "pew pew"
func shoot():
	laser_shot.emit(laser_scene, pew_pew.global_position)
	
	#same with this one, except for the missile instead
func shoot2():
	missile_shot.emit(missile_scene, ms.global_position)
	
#when the player takes damage, it is minused from the GlobalVariable
#when it reaches zero, it plays the explosion animation, and makes the collision die and the texture invisible
#then the player is queue freed
func take_damage(amount):
	GlobalVar.health -= amount
	if GlobalVar.health <= 0:
		dead = true
		print("Player Killed")
		$CollisionShape2D.queue_free()
		$Shiptexture.visible = false
		$Explosion.visible = true
		$AnimationPlayer.play("Explosion")
		killed.emit()
		await $AnimationPlayer.animation_finished 
		$Explosion.visible = false
		queue_free()
