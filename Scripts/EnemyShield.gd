class_name EnemyShield extends Area2D

@export var EnemyShieldHealth = 4

func take_damage(amount):
	EnemyShieldHealth -= amount
	if EnemyShieldHealth <= 0:
		queue_free()
