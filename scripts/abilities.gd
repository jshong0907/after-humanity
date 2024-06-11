extends Node

var strength: int = 10
var speed: int = 10

func modify_strength(amount: int):
	strength += amount
	print(strength)

func modify_speed(amount: int):
	speed += amount
	print(speed)
