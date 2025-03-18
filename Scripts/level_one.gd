extends Node2D

@export var enemy_scenes: Array[PackedScene] = []

@onready var player_spawn_pos = $PlayerSpawnPos
@onready var laser_container = $laser_container
@onready var enemy_container = $enemy_container
@onready var hud = $UI_Layer/HUD
@onready var screensize = get_viewport_rect().size
@export var level = 1
@export var waves = 3

var player = null

#spawn da playa, and put him on his spawn pos
func _ready():
	player = get_tree().get_first_node_in_group("players")
	assert(player!=null)
	player.global_position = Vector2(screensize.x / 2, player_spawn_pos.global_position.y)
	player.laser_shot.connect(_on_player_laser_shot)
	player.killed.connect(_on_player_killed)
	
#Why would you quit such an amazing game tho?
func _process(_delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()

#shootin lasars in dis house
func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)

#spawnin enemias in dis house
func _on_enemy_spawn_timer_timeout():
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(50, screensize.x - 50), -50)
	e.killed.connect(_on_enemy_killed)
	enemy_container.add_child(e)

#kill da enemy, get da points
func _on_enemy_killed(points):
	GlobalVar.score += points

#womp womp you died
func _on_player_killed():
	print("game over")

func _on_end_of_wave_timeout():
	waves -= 1
	print("wave finished")
	if waves == 0:
		if level == 1:
			get_tree().change_scene_to_file("res://Scenes/level_two.tscn")
		elif level == 2:
			get_tree().change_scene_to_file("res://Scenes/level_three.tscn")
		else: 
			pass
