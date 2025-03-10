extends CharacterBody2D

@export var speed = 300
@onready var screensize = get_viewport_rect().size

func _process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	if direction.x > 0:
		$Shiptexture.animation = "Ship_Right"
		$Shiptexture/ThrustersAnimation.play("RightThrusters")
		$Shiptexture/Thrusters_Right.visible = true
		$Shiptexture/Thrusters.visible = false
		$Shiptexture/Thrusters_Left.visible = false 
	elif direction.x < 0:
		$Shiptexture.animation = "Ship_Left"
		$Shiptexture/ThrustersAnimation.play("LeftThrusters")
		$Shiptexture/Thrusters_Left.visible = true
		$Shiptexture/Thrusters.visible = false
		$Shiptexture/Thrusters_Right.visible = false
	else: 
		$Shiptexture.animation = "Ship"
		$Shiptexture/Thrusters.visible = true
		$Shiptexture/Thrusters_Left.visible = false 
		$Shiptexture/Thrusters_Right.visible = false
	velocity = direction * speed
	move_and_slide()
