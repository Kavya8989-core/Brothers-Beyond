extends CharacterBody2D

const SPEED = 100.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED

	process_animations(direction)
	move_and_slide()


func process_animations(direction) -> void:
	if velocity != Vector2.ZERO:
		play_animations("move", direction)
	else:
		play_animations("idle", direction)


func play_animations(prefix: String, dir: Vector2) -> void:
	if dir.x > 0:
		animated_sprite_2d.play(prefix + " right")
	elif dir.x < 0:
		animated_sprite_2d.play(prefix + " left")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + " up")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + " down")
