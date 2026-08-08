extends CharacterBody2D

const SPEED = 300.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	
	play_animations(direction)
	
	move_and_slide()


func play_animations(dir: Vector2) -> void:
	if dir.x > 0:
		animated_sprite_2d.play("move right")
	elif dir.x < 0:
		animated_sprite_2d.play("move left")
	elif dir.y < 0:
		animated_sprite_2d.play("move up")
	elif dir.y > 0:
		animated_sprite_2d.play("move down")
