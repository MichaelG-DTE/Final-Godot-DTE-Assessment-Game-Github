extends CharacterBody2D

@export var speed = 300
@onready var screensize = get_viewport_rect().size

func _process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	if direction.x > 0:
		$Shiptexture.animation = "Ship_Right"
		$Thrusters2.animation = "Thrusters_Right"
	
	elif direction.x < 0:
		$Shiptexture.animation = "Ship_Left"
		$Thrusters2.animation = "Thrusters_Left"
		
	else: 
		$Shiptexture.animation = "Ship"
		$Thrusters.animation = "Thrusters"
	velocity = direction * speed
	move_and_slide()
