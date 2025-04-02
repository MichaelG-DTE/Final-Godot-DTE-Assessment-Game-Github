class_name Boss extends Area2D


var boss_laser = preload("res://Scenes/boss_laser.tscn")
var boss_missile = preload("res://Scenes/boss_missile.tscn")
var boss_shield = preload("res://Scenes/boss_shield.tscn")

@onready var laser_1_pewpew = $PEWPEW/Laser_1_PEWPEW
@onready var laser_1_pewpew_2 = $PEWPEW/Laser_1_PEWPEW2
@onready var laser_2_pewpew = $PEWPEW/Laser_2_PEWPEW
@onready var laser_2_pewpew_2 = $PEWPEW/Laser_2_PEWPEW2
@onready var laser_3_pewpew = $PEWPEW/Laser_3_PEWPEW
@onready var missile_pewpew = $PEWPEW/Missile_PEWPEW
@onready var missile_pewpew_2 = $PEWPEW/Missile_PEWPEW2
@export var boss_fire_rate = 1
@export var speed = 0
var boss_direction = 1

func _ready():
	GlobalVar.is_in_cutscene = true

#The shoot func time out for the bosses first set of lasers
#Calls the shoot func on the position of the pewpews
func _on_laser_1_shoot_timer_timeout():
	shoot(laser_1_pewpew.global_position)
	shoot(laser_1_pewpew_2.global_position)
	$Laser_1_shoot_timer.wait_time = 3.7567
	$Laser_1_shoot_timer.start()

#Same here
func _on_laser_2_shoot_timer_timeout():
	shoot(laser_2_pewpew.global_position)
	shoot(laser_2_pewpew_2.global_position)
	$Laser_2_shoot_timer.wait_time = 5.5224
	$Laser_2_shoot_timer.start()
	
#And here
func _on_laser_3_shoot_timer_timeout():
	shoot(laser_3_pewpew.global_position)
	$Laser_3_shoot_timer.wait_time = 2.245
	$Laser_3_shoot_timer.start()

#calls the Missile shoot func on the Missile pewpews global positions
func _on_missile_shoot_timer_timeout():
	shoot2(missile_pewpew.global_position)
	shoot2(missile_pewpew_2.global_position)
	$Missile_shoot_timer.wait_time = 7.5324
	$Missile_shoot_timer.start()

#Instantiates the laser at the (location) which is replaced with the pewpew global position
func shoot(location):
	if !GlobalVar.is_in_cutscene: 
		var b = boss_laser.instantiate()
		get_tree().root.add_child(b)
		b.start(location)

#Instantiates the missile at the (location) which is replaced with the pewpew global position
func shoot2(location):
	if !GlobalVar.is_in_cutscene:
		var m = boss_missile.instantiate()
		get_tree().root.add_child(m)
		m.start(location)

#Boss Moves left and right, keeping the battle spicy
func _physics_process(delta):
	global_position.x += speed * delta

func take_damage(amount):
	GlobalVar.score += 50
	GlobalVar.xarkanthras_health_bar_one -= amount
	if GlobalVar.xarkanthras_health_bar_one == 0:
		GlobalVar.xarkanthras_health_bar_two -= amount
		if GlobalVar.xarkanthras_health_bar_two == 0:
			queue_free()


func _on_shield_spawn_timer_timeout():
	if !GlobalVar.is_in_cutscene:
		var s = boss_shield.instantiate()
		get_tree().root.add_child(s)
		s.global_position = $".".global_position
		$ShieldSpawnTimer.wait_time = randf_range(10, 20)
		$ShieldSpawnTimer.start()

func _on_move_timer_timeout():
	if !GlobalVar.is_in_cutscene: 
		if boss_direction == 1:
			if randf() >= 0.5:
				boss_direction = 0
				global_position.x -= 150
				boss_direction = 1
			else:
				boss_direction = 2
				global_position.x += 150
				boss_direction = 1
		await get_tree().create_timer(2).timeout
		speed = 0
