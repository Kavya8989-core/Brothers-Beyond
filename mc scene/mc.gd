extends CharacterBody2D

const walk_SPEED = 100.0
const run_SPEED=200.0

var is_in_dialogue = false
var check_direction: Vector2=Vector2.RIGHT
var if_attacking :=false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var _health : int = 100
var _damage : int = 20
func _ready() -> void:
	if get_tree().current_scene.scene_file_path == "res://main.tscn":
		if GameManager.returning_from_house:
			await get_tree().process_frame

			var spawn_point = get_tree().current_scene.get_node("Marker2D")

			global_position = spawn_point.global_position

			print("SPAWNED AT HOUSE EXIT: ", global_position)

			GameManager.returning_from_house = false


func _physics_process(_delta: float) -> void:

	if is_in_dialogue:
		velocity = Vector2.ZERO
		return

	if if_attacking:
		move_and_slide()
		return

	process_animations()

	var direction := Input.get_vector("left", "right", "up", "down")

	if direction != Vector2.ZERO:
		check_direction = direction

		if Input.is_action_pressed("run"):
			velocity = direction * run_SPEED
		else:
			velocity = direction * walk_SPEED
	else:
		velocity = Vector2.ZERO

	if Input.is_action_just_pressed("attack"):
		attack()

	move_and_slide()
	
func face_target(target: Node2D):
	var direction = target.global_position - global_position

	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			check_direction = Vector2.RIGHT
		else:
			check_direction = Vector2.LEFT
	else:
		if direction.y > 0:
			check_direction = Vector2.DOWN
		else:
			check_direction = Vector2.UP
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
		
