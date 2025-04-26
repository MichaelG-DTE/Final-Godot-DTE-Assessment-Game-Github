class_name Boss extends Area2D

signal killed

var boss_laser = preload("res://Scenes/boss_laser.tscn")
var boss_missile = preload("res://Scenes/boss_missile_2.tscn")
var boss_shield = preload("res://Scenes/boss_shield.tscn")
var health_scene = preload("res://Scenes/health_collectable.tscn")
var shield_scene = preload("res://Scenes/shield_collectable.tscn")

@onready var laser_1_pewpew = $PEWPEW/Laser_1_PEWPEW
@onready var laser_1_pewpew_2 = $PEWPEW/Laser_1_PEWPEW2
@onready var laser_2_pewpew = $PEWPEW/Laser_2_PEWPEW
@onready var laser_2_pewpew_2 = $PEWPEW/Laser_2_PEWPEW2
@onready var laser_3_pewpew = $PEWPEW/Laser_3_PEWPEW
@onready var missile_pewpew = $PEWPEW/Missile_PEWPEW
@onready var missile_pewpew_2 = $PEWPEW/Missile_PEWPEW2
@onready var missile_pewpew_3 = $PEWPEW/Missile_PEWPEW3
@onready var missile_pewpew_4 = $PEWPEW/Missile_PEWPEW4
@onready var spawn_collectables = $PEWPEW/SpawnCollectables
@onready var shoot_sfx = $Shoot_SFX
@onready var missile_shoot_sfx = $Missile_Shoot_SFX
@onready var screensize = get_viewport_rect().size
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
	$TIMERS/Laser_1_shoot_timer.wait_time = 3.756
	$TIMERS/Laser_1_shoot_timer.start()

#Same here
func _on_laser_2_shoot_timer_timeout():
	shoot(laser_2_pewpew.global_position)
	shoot(laser_2_pewpew_2.global_position)
	$TIMERS/Laser_2_shoot_timer.wait_time = 5.52
	$TIMERS/Laser_2_shoot_timer.start()
	
#And here
func _on_laser_3_shoot_timer_timeout():
	shoot(laser_3_pewpew.global_position)
	$TIMERS/Laser_3_shoot_timer.wait_time = 2.72
	$TIMERS/Laser_3_shoot_timer.start()

#calls the Missile shoot func on the Missile pewpews global positions
func _on_missile_shoot_timer_timeout():
	shoot2(missile_pewpew.global_position)
	shoot2(missile_pewpew_2.global_position)
	shoot2(missile_pewpew_3.global_position)
	shoot2(missile_pewpew_4.global_position)
	$TIMERS/Missile_shoot_timer.wait_time = 8.24
	$TIMERS/Missile_shoot_timer.start()

#Instantiates the laser at the (location) which is replaced with the pewpew global position
func shoot(location):
	if !GlobalVar.is_in_cutscene: 
		var b = boss_laser.instantiate()
		get_tree().root.add_child(b)
		b.start(location)
		shoot_sfx.play()

#Instantiates the missile at the (location) which is replaced with the pewpew global position
func shoot2(location):
	if !GlobalVar.is_in_cutscene:
		var m = boss_missile.instantiate()
		get_tree().root.add_child(m)
		m.start(location)
		missile_shoot_sfx.play()

#Boss Moves left and right, keeping the battle spicy
func _physics_process(delta):
	global_position.x += speed * delta

#when boss takes damage, boss loses health and spawns collectables
func take_damage(amount):
	GlobalVar.score += 50
	if randf() >= 0.5:
		if randf() >= 0.5:
			if randf() >= 0.5:
				if randf() >= 0.5:
					var h = health_scene.instantiate()
					get_tree().root.add_child(h)
					h.global_position = spawn_collectables.global_position
				else:
					var s = shield_scene.instantiate()
					get_tree().root.add_child(s)
					s.global_position = spawn_collectables.global_position
	GlobalVar.xarkanthras_health_bar_one -= amount
	if GlobalVar.xarkanthras_health_bar_one <= 0:
		GlobalVar.xarkanthras_health_bar_two -= amount
		if GlobalVar.xarkanthras_health_bar_two <= 0:
			GlobalVar.is_in_cutscene = true
			$Explosions.visible = true
			$BossDeath.play("BossDeath")
			killed.emit()
			await $BossDeath.animation_finished
			queue_free()
			
#spawns shield when the timer runs out
func _on_shield_spawn_timer_timeout():
	if !GlobalVar.is_in_cutscene:
		var s = boss_shield.instantiate()
		self.add_child(s)
		s.global_position = $".".global_position
		$TIMERS/ShieldSpawnTimer.wait_time = randf_range(10, 20)
		$TIMERS/ShieldSpawnTimer.start()

#moves around to keep the battle spicy
func _on_move_timer_timeout():
	if !GlobalVar.is_in_cutscene: 
		if boss_direction == 1:
			speed -= 100
			boss_direction = 2
		elif boss_direction == 2:
			speed += 100
			boss_direction = 3
		elif boss_direction == 3:
			speed += 100
			boss_direction = 4
		elif boss_direction == 4:
			speed -= 100
			boss_direction = 1
		await get_tree().create_timer(2).timeout
		speed = 0


func _on_body_entered(body):
	if body is Player:
		body.take_damage(GlobalVar.health - 20)
		
