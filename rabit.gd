extends CharacterBody2D

const SPEED = 35.0
const ROAM_RADIUS = 100.0

enum {
	IDLE,
	MOVE
}

var current_state = IDLE
var dir = Vector2.ZERO
var direction_prefix = "down"

var start_pos: Vector2
var state_timer = 0.0


func _ready():
	randomize()
	start_pos = global_position
	change_state()


func _process(delta):
	state_timer -= delta

	if state_timer <= 0:
		change_state()

	# Direction animation
	if dir.x > 0:
		direction_prefix = "right"
	elif dir.x < 0:
		direction_prefix = "left"
	elif dir.y < 0:
		direction_prefix = "up"
	elif dir.y > 0:
		direction_prefix = "down"

	# Animation
	if current_state == IDLE:
		$AnimatedSprite2D.play("idle " + direction_prefix)
	else:
		$AnimatedSprite2D.play("walk " + direction_prefix)


func _physics_process(delta):
	if current_state == MOVE:
		velocity = dir * SPEED
		move_and_slide()

		# Keep rabbit inside its roaming radius
		if global_position.distance_to(start_pos) > ROAM_RADIUS:
			global_position = start_pos + (
				global_position - start_pos
			).normalized() * ROAM_RADIUS

			# Stop and choose another direction
			velocity = Vector2.ZERO
			dir = Vector2.ZERO
			current_state = IDLE
			state_timer = 1.5
	else:
		velocity = Vector2.ZERO


func change_state():
	# 50% chance to idle
	if randf() < 0.5:
		current_state = IDLE
		dir = Vector2.ZERO

		# Idle for 1–3 seconds
		state_timer = randf_range(1.0, 3.0)

	else:
		current_state = MOVE

		dir = choose([
			Vector2.RIGHT,
			Vector2.LEFT,
			Vector2.UP,
			Vector2.DOWN
		])

		# Walk for 1–3 seconds
		state_timer = randf_range(1.0, 3.0)


func choose(array):
	array.shuffle()
	return array.front()
