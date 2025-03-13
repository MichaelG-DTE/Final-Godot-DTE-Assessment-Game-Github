class_name Player extends CharacterBody2D

signal laser_shot(laser_scene, location)
signal killed

@export var speed = 450
@export var rate_of_fire = 0.20

@onready var screensize = get_viewport_rect().size
@onready var pew_pew = $PewPew

var laser_scene = preload("res://Scenes/laser.tscn")

var shoot_cd := false

func _process(delta):
	if Input.is_action_pressed("Shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cd = false
			
func _physics_process(delta):
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
	
	global_position = global_position.clamp(Vector2(60, 60), screensize - Vector2(60, 60))
	
func shoot():
	laser_shot.emit(laser_scene, pew_pew.global_position)

func die():
	killed.emit()
	queue_free()
