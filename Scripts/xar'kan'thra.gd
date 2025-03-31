extends Area2D


var boss_laser = preload("res://Scenes/boss_laser.tscn")


@onready var laser_1_pewpew = $PEWPEW/Laser_1_PEWPEW
@onready var laser_1_pewpew_2 = $PEWPEW/Laser_1_PEWPEW2
@onready var laser_2_pewpew = $PEWPEW/Laser_2_PEWPEW
@onready var laser_2_pewpew_2 = $PEWPEW/Laser_2_PEWPEW2
@onready var laser_3_pewpew = $PEWPEW/Laser_3_PEWPEW
@onready var missile_pewpew = $PEWPEW/Missile_PEWPEW
@onready var missile_pewpew_2 = $PEWPEW/Missile_PEWPEW2
@export var boss_fire_rate = 1

func _ready():
	boss_fire_rate = randf_range(1, 20)

func _on_laser_1_shoot_timer_timeout():
	shoot(laser_1_pewpew.global_position)
	shoot(laser_1_pewpew_2.global_position)
	$Laser_1_shoot_timer.wait_time = randf_range(1, 20)
	$Laser_1_shoot_timer.start()

func shoot(location):
	pass
