extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var speed : int = 70
var health : int = 50


func takes_dmg() -> void:
	if GameManager.mc_attacks == true:
		health -= 20
		GameManager.mc_attacks = false
		if health <= 0 :
			health = 0
			animated_sprite.play("death")
	print(health)

func _ready() -> void:
	animated_sprite.play("idle")
	
