extends Node2D

@onready var player_spawn_pos = $PlayerSpawnPos
@onready var laser_container = $laser_container
@onready var screensize = get_viewport_rect().size
@onready var level = 1

var player = null
var score := 0:
	set(value):
		score = value 

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

func _on_enemy_spawn_timer_timeout():
	


#kill da enemy, get da points
func _on_enemy_killed(points):
	score += points
	print(score)
	
func _on_player_killed():
	print("game over")

