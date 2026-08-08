extends CharacterBody2D

const walk_SPEED = 100.0
const run_SPEED=200.0

var check_direction: Vector2=Vector2.RIGHT
var if_attacking :=false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func _physics_process(_delta: float) -> void:
	if if_attacking:
		move_and_slide()
		return
	process_animations()
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction!=Vector2.ZERO:
		check_direction=direction
		if Input.is_action_pressed("run"):
			velocity = direction * run_SPEED
		else:
			velocity = direction * walk_SPEED
	
	else:
		velocity=Vector2.ZERO
	if Input.is_action_just_pressed("attack"):
			attack()
	move_and_slide()
		
func attack() -> void:
	if_attacking = true
	velocity=Vector2.ZERO
	play_animations("move_hit",check_direction)
	await animated_sprite_2d.animation_finished
	if_attacking = false





	



func process_animations() -> void:
	if velocity != Vector2.ZERO:
		if Input.is_action_pressed("run"):
			play_animations("run",check_direction)
		else:
			play_animations("move",check_direction)
				
	else:
		play_animations("idle", check_direction)


func play_animations(prefix: String, dir: Vector2) -> void:
	if dir.x > 0:
		animated_sprite_2d.play(prefix + " right")
	elif dir.x < 0:
		animated_sprite_2d.play(prefix + " left")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + " up")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + " down")
		
