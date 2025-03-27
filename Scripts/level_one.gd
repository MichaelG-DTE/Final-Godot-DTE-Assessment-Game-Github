extends Node2D

@export var wave1: Array[PackedScene] = []
@export var wave2: Array[PackedScene] = []
@export var wave3: Array[PackedScene] = []

@onready var player_spawn_pos = $PlayerSpawnPos
@onready var laser_container = $laser_container
@onready var enemy_container = $enemy_container
@onready var missile_container = $missile_container
@onready var hud = $UI_Layer/HUD
@onready var gos = $UI_Layer/GameOverScreen
@onready var lcs = $UI_Layer/LevelCompleteScreen
@onready var screensize = get_viewport_rect().size
@export var level = 1
@export var waves = 3
@export var wave_warning_timer = 7

var player = null

#spawn da playa, and put him on his spawn pos
func _ready():
	player = get_tree().get_first_node_in_group("players")
	assert(player!=null)
	GlobalVar.shield_health = 15
	GlobalVar.health = 20
	player.global_position = Vector2(screensize.x / 2, player_spawn_pos.global_position.y)
	player.laser_shot.connect(_on_player_laser_shot)
	player.missile_shot.connect(_on_player_missile_shot)
	player.killed.connect(_on_player_killed)
	$EnemySpawnTimer.stop()
	if waves == 3:
		$UI_Layer/HUD/WaveWarning.visible = true
		$UI_Layer/HUD/Wave1.visible = true
		$UI_Layer/HUD/WaveFlashing.play("WarningFlashing")
		await get_tree().create_timer(wave_warning_timer).timeout
		await $UI_Layer/HUD/WaveFlashing.animation_finished
		$UI_Layer/HUD/WaveWarning.visible = false
		$UI_Layer/HUD/Wave1.visible = false
		$EnemySpawnTimer.start()
	
func _process(_delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()

#shootin lasars in dis house
func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	
func _on_player_missile_shot(missile_scene, location):
	var missile = missile_scene.instantiate()
	missile.global_position = location
	missile_container.add_child(missile)

#spawnin enemias in dis house
func _on_enemy_spawn_timer_timeout():
	if waves == 3:
		var e = wave1.pick_random().instantiate()
		e.global_position = Vector2(randf_range(50, screensize.x - 50), -50)
		e.killed.connect(_on_enemy_killed)
		enemy_container.add_child(e)
	elif waves == 2:
		var e = wave2.pick_random().instantiate()
		e.global_position = Vector2(randf_range(50, screensize.x - 50), -50)
		e.killed.connect(_on_enemy_killed)
		enemy_container.add_child(e)
	elif waves == 1:
		var e = wave3.pick_random().instantiate()
		e.global_position = Vector2(randf_range(50, screensize.x - 50), -50)
		e.killed.connect(_on_enemy_killed)
		enemy_container.add_child(e)
	elif waves == 0:
			print("level finished")
			lcs.set_score(GlobalVar.score)
			await get_tree().create_timer(2.25).timeout
			lcs.visible = true

#kill da enemy, get da points
func _on_enemy_killed(points):
	GlobalVar.score += points

#womp womp you died
func _on_player_killed():
	print("game over")
	gos.set_score(GlobalVar.score)
	await get_tree().create_timer(2.25).timeout
	gos.visible = true

func _on_end_of_wave_timeout():
	waves -= 1
	print("wave finished")
	$EnemySpawnTimer.stop()
	await get_tree().create_timer(1).timeout
	if waves == 2:
		$UI_Layer/HUD/WaveWarning.visible = true
		$UI_Layer/HUD/Wave2.visible = true
		$UI_Layer/HUD/WaveFlashing.play("WarningFlashing")
		await get_tree().create_timer(wave_warning_timer).timeout
		await $UI_Layer/HUD/WaveFlashing.animation_finished
		$UI_Layer/HUD/WaveWarning.visible = false
		$UI_Layer/HUD/Wave2.visible = false
		$EnemySpawnTimer.start()
	elif waves == 1:
		$UI_Layer/HUD/WaveWarning.visible = true
		$UI_Layer/HUD/Wave3.visible = true
		$UI_Layer/HUD/WaveFlashing.play("WarningFlashing")
		await get_tree().create_timer(wave_warning_timer).timeout
		await $UI_Layer/HUD/WaveFlashing.animation_finished
		$UI_Layer/HUD/WaveWarning.visible = false
		$UI_Layer/HUD/Wave3.visible = false
		$EnemySpawnTimer.start()
	else:
		if waves == 0:
			print("level finished")
			level += 1
			lcs.set_score(GlobalVar.score)
			await get_tree().create_timer(3.25).timeout
			lcs.visible = true
