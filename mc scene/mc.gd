extends CharacterBody2D
const walk_SPEED = 70.0
const run_SPEED=200.0

var is_in_dialogue = false
var check_direction: Vector2=Vector2.RIGHT
var if_attacking :=false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var _health : int = 100
var _damage : int = 20
var can_attack : bool = true
func _ready() -> void:
	if GameManager.save_checkpoint == true:
		await get_tree().process_frame
		var spawn = get_tree().current_scene.get_node("SPAWN")
		global_position = spawn.global_position
		print("old position assigned")
		GameManager.save_checkpoint = false

	if get_tree().current_scene.scene_file_path == "res://main.tscn":
		if GameManager.returning_from_house:
			await get_tree().process_frame

			var spawn_point = get_tree().current_scene.get_node("spawn_point")

			global_position = spawn_point.global_position

			print("SPAWNED AT HOUSE EXIT: ", global_position)

			GameManager.returning_from_house = false


func _physics_process(_delta: float) -> void:

	if enemy_entered == true and Input.is_action_just_pressed("attack"):
		print("attacked")
		GameManager.mc_attacks = true
		enemy.takes_dmg()

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
	if GameManager.enemy_attacks == true :
		if _health > 0 and can_attack == true:
			can_attack = false
			_health -= 10
			print(_health)
			var direction_name : String
			if abs(direction.x) > abs(direction.y):
				if direction.x > 0:
					direction_name = "right"
				else :
					direction_name = "left"
			else :
				if direction.y > 0:
					direction_name = "down"
				else :
					direction_name = "up"
			animated_sprite_2d.play("hurt" + direction_name)
			
			await get_tree().create_timer(0.6).timeout
			can_attack = true
		if _health == 0 :
			animated_sprite_2d.play("death")
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
		
var enemy  : Node2D
var enemy_entered : bool = false
func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_entered = true
		print("enemy eneterd")
		enemy = body

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body == enemy:
		enemy_entered = false
		print("enemy exited")
		enemy = null
