class_name EnemyShield extends Area2D

@export var EnemyShieldHealth = 3

func take_damage(amount):
	EnemyShieldHealth -= 1
	if EnemyShieldHealth <= 0:
		queue_free()
