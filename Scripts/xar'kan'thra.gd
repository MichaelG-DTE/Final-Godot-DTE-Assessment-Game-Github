extends Area2D


var boss_laser = preload("res://Scenes/boss_laser.tscn")
var boss_missile = preload("res://Scenes/boss_missile.tscn")

@onready var laser_1_pewpew = $PEWPEW/Laser_1_PEWPEW
@onready var laser_1_pewpew_2 = $PEWPEW/Laser_1_PEWPEW2
@onready var laser_2_pewpew = $PEWPEW/Laser_2_PEWPEW
@onready var laser_2_pewpew_2 = $PEWPEW/Laser_2_PEWPEW2
@onready var laser_3_pewpew = $PEWPEW/Laser_3_PEWPEW
@onready var missile_pewpew = $PEWPEW/Missile_PEWPEW
@onready var missile_pewpew_2 = $PEWPEW/Missile_PEWPEW2
@export var boss_fire_rate = 1

func _ready():
	GlobalVar.is_in_cutscene = true

func _on_laser_1_shoot_timer_timeout():
	shoot(laser_1_pewpew.global_position)
	shoot(laser_1_pewpew_2.global_position)
	$Laser_1_shoot_timer.wait_time = 3
	$Laser_1_shoot_timer.start()

func _on_laser_2_shoot_timer_timeout():
	shoot(laser_2_pewpew.global_position)
	shoot(laser_2_pewpew_2.global_position)
	$Laser_2_shoot_timer.wait_time = 5
	$Laser_2_shoot_timer.start()
	
func _on_laser_3_shoot_timer_timeout():
	shoot(laser_3_pewpew.global_position)
	$Laser_3_shoot_timer.wait_time = 3
	$Laser_3_shoot_timer.start()
	
func _on_missile_shoot_timer_timeout():
	shoot2(missile_pewpew.global_position)
	shoot2(missile_pewpew_2.global_position)
	$Missile_shoot_timer.wait_time = 8
	$Missile_shoot_timer.start()

func shoot(location):
	if !GlobalVar.is_in_cutscene: 
		var b = boss_laser.instantiate()
		get_tree().root.add_child(b)
		b.start(location)

func shoot2(location):
	if !GlobalVar.is_in_cutscene:
		var m = boss_missile.instantiate()
		get_tree().root.add_child(m)
		m.start(location)





