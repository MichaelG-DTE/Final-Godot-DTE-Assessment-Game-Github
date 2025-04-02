extends Node2D

@onready var screensize = get_viewport_rect().size
@onready var xktsp = $"xar'kan'thra_spawn_pos"
@onready var hud = $CanvasLayer/HUD
@onready var gos = $CanvasLayer/GameOverScreen
@onready var lcs = $CanvasLayer/LevelCompleteScreen
@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var laser_container = $laser_container
@onready var missile_container = $missile_container
@onready var xar_kan_thra = $"Xar'kan'thra"
@export var level = 4
@onready var player_spawn_pos = $PlayerSpawnPos

var boss = null
var player = null

func _ready():
	player = get_tree().get_first_node_in_group("players")
	boss = get_tree().get_first_node_in_group("BOSS")
	assert(boss!=null)
	assert(player!=null)
	GlobalVar.shield_health = 15
	GlobalVar.health = 20
	GlobalVar.is_in_cutscene = true
	player.global_position = Vector2(screensize.x / 2, player_spawn_pos.global_position.y)
	player.laser_shot.connect(_on_player_laser_shot)
	player.missile_shot.connect(_on_player_missile_shot)
	player.killed.connect(_on_player_killed)
	$"CanvasLayer/HUD/Xar'kan'thraApproach".visible = true
	$CanvasLayer/HUD/Approach.visible = true
	$Warning.play("ApproachWarning")
	await $Warning.animation_finished
	$"CanvasLayer/HUD/Xar'kan'thraApproach".visible = false
	$CanvasLayer/HUD/Approach.visible = false

func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

#shootin lasars in dis house
func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	
func _on_player_missile_shot(missile_scene, location):
	var missile = missile_scene.instantiate()
	missile.global_position = location
	missile_container.add_child(missile)

func _on_player_killed():
	print("game over")
	gos.set_score(GlobalVar.score)
	await get_tree().create_timer(2.25).timeout
	gos.visible = true

func _on_start_of_boss_fight_timeout():
	$XarkanthraApproach.play("boss_warp")
	await $XarkanthraApproach.animation_finished
	GlobalVar.is_in_cutscene = false
