extends Node2D

#wave arrays
@export var wave1: Array[PackedScene] = []
@export var wave2: Array[PackedScene] = []
@export var wave3: Array[PackedScene] = []

#variables
@onready var player_spawn_pos = $PlayerSpawnPos
@onready var laser_container = $laser_container
@onready var enemy_container = $enemy_container
@onready var missile_container = $missile_container
@onready var hud = $UI_Layer/HUD
@onready var gos = $UI_Layer/GameOverScreen
@onready var lcs = $UI_Layer/LevelCompleteScreen
@onready var pause_menu = $UI_Layer/PauseMenu
@onready var timer_bar = $UI_Layer/TimerBar
@onready var screensize = get_viewport_rect().size
@export var level = 1
@export var waves = 3
@export var wave_warning_timer = 7

var player = null

#spawn da playa, and put him on his spawn pos
func _ready():
	#get the player from its group
	player = get_tree().get_first_node_in_group("players")
	#make sure the player exists at the start of the game
	assert(player!=null)
	#set the players health and shield health
	GlobalVar.shield_health = 15
	GlobalVar.health = 20
	#player position at the start of the game
	player.global_position = Vector2(screensize.x / 2, player_spawn_pos.global_position.y)
	#connecting signals from the player to the game script
	player.laser_shot.connect(_on_player_laser_shot)
	player.missile_shot.connect(_on_player_missile_shot)
	player.killed.connect(_on_player_killed)
	$EnemySpawnTimer.stop()
	if waves == 3:
		#makes the first wave warning symbol appear, then plays an animation
		$UI_Layer/HUD/WaveWarning.visible = true
		$UI_Layer/HUD/Wave1.visible = true
		$UI_Layer/HUD/WaveFlashing.play("WarningFlashing")
		#creates a timer that determines the break between waves
		await get_tree().create_timer(wave_warning_timer).timeout
		#waits for the animtion to be finished
		await $UI_Layer/HUD/WaveFlashing.animation_finished
		#makes the flashing invisible
		$UI_Layer/HUD/WaveWarning.visible = false
		$UI_Layer/HUD/Wave1.visible = false
		#starts the enemy spawn timer at the beginning of the wave
		$EnemySpawnTimer.start()
	
func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	$UI_Layer/TimerBar.max_value = $EndOfWave.wait_time
	$UI_Layer/TimerBar.value = $EndOfWave.time_left
	

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
		#looks in the wave one array and picks a random enemy
		var e = wave1.pick_random().instantiate()
		#spawns the enemy in a random spot depending on the width of screen, minus 50 pixels on either side, so no enemies spawn offscreen
		e.global_position = Vector2(randf_range(50, screensize.x - 50), -50)
		#connect to the enemy killed signal
		e.killed.connect(_on_enemy_killed)
		#add the enemies to a node container, to keep everything orderly
		enemy_container.add_child(e)
	elif waves == 2:
		#looks in the wave two array and picks a random enemy
		var e = wave2.pick_random().instantiate()
		e.global_position = Vector2(randf_range(50, screensize.x - 50), -50)
		e.killed.connect(_on_enemy_killed)
		enemy_container.add_child(e)
	elif waves == 1:
		#looks in the wave three array and picks a random enemy
		var e = wave3.pick_random().instantiate()
		e.global_position = Vector2(randf_range(50, screensize.x - 50), -50)
		e.killed.connect(_on_enemy_killed)
		enemy_container.add_child(e)
	elif waves == 0:
			print("level finished")
			#set the score in the Level Complete Screen
			lcs.set_score(GlobalVar.score)
			#short break
			await get_tree().create_timer(2.25).timeout
			#poof its visible 
			lcs.visible = true

#kill da enemy, get da points
func _on_enemy_killed(points):
	GlobalVar.score += points

#womp womp you died
func _on_player_killed():
	print("game over")
	gos.set_score(GlobalVar.score)
	await get_tree().create_timer(2.25).timeout
	$LevelMusic.playing = false
	gos.visible = true
	await get_tree().create_timer(1.25)
	gos.get_node("LevelFailMusic").playing = true

func _on_end_of_wave_timeout():
	waves -= 1
	print("wave finished")
	$EnemySpawnTimer.stop()
	await get_tree().create_timer(1).timeout
	if waves == 2:
		$UI_Layer/HUD/WaveWarning.visible = true
		#same as above, but makes the second wave symbol appear instead of wave one
		$UI_Layer/HUD/Wave2.visible = true
		$UI_Layer/HUD/WaveFlashing.play("WarningFlashing")
		await get_tree().create_timer(wave_warning_timer).timeout
		await $UI_Layer/HUD/WaveFlashing.animation_finished
		$UI_Layer/HUD/WaveWarning.visible = false
		$UI_Layer/HUD/Wave2.visible = false
		$EnemySpawnTimer.start()
	elif waves == 1:
		$UI_Layer/HUD/WaveWarning.visible = true
		#same as above, but makes the third wave symbol appear instead of wave two
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
			lcs.set_score(GlobalVar.score)
			await get_tree().create_timer(3.25).timeout
			$LevelMusic.playing = false
			lcs.visible = true
			await get_tree().create_timer(1.25)
			lcs.get_node("LevelCompleteMusic").playing = true 
