extends Node2D

@onready var player_spawn_pos = $PlayerSpawnPos
@onready var laser_container = $laser_container


var player = null
var score := 0:
	set(value):
		score = value 
#spawn da playa, and put him on his spawn pos
func _ready():
	player = get_tree().get_first_node_in_group("players")
	assert(player!=null)
	player.global_position = player_spawn_pos.global_position
	player.laser_shot.connect(_on_player_laser_shot)

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
#kill da enemy, get da points
func _on_enemy_killed(points):
	score += points
	print(score)
