extends CharacterBody2D


var speed : int = 70
var health : int = 50


func takes_dmg() -> void:
	if GameManager.mc_attacks == true:
		health -= 20
		print("function worked")
		print(health)
		GameManager.mc_attacks = false
