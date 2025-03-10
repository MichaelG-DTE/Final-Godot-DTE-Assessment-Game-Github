extends CharacterBody2D

@export var speed = 300
@onready var screensize = get_viewport_rect().size

func _process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	if direction.x > 0:
		$Shiptexture.animation = "Ship_Right"
		$Shiptexture/BankingThrusters.animation= "Thrusters_Right"
		$Shiptexture/BankingThrusters.visible = true 
		$Shiptexture/Thrusters.visible = false
	elif direction.x < 0:
		$Shiptexture.animation = "Ship_Left"
		$Shiptexture/BankingThrusters.animation = "Thrusters_Left"
		$Shiptexture/BankingThrusters.visible = true 
		$Shiptexture/Thrusters.visible = false
	else: 
		$Shiptexture.animation = "Ship"
		$Shiptexture/Thrusters.animation = "Thrusters"
		$Shiptexture/BankingThrusters.visible = false
		$Shiptexture/Thrusters.visible = true
	velocity = direction * speed
	move_and_slide()
