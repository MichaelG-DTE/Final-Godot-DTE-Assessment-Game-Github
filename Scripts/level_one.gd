extends Node2D

@onready var player_spawn_pos = $PlayerSpawnPos

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("players")
	assert(player!=null)
	player.global_position = player_spawn_pos.global_position

func _process(_delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
