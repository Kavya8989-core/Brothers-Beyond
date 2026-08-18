extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const walk_SPEED = 70.0
const FOLLOW_DISTANCE = 50.0

var player: CharacterBody2D
var last_direction := "down"

func _physics_process(_delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return

	if not GameManager.fox_can_follow:
		velocity = Vector2.ZERO
		animated_sprite_2d.play("idle " + last_direction)
		return

	var follow_distance = global_position.distance_to(player.global_position)

	if follow_distance > FOLLOW_DISTANCE:
		var direction = global_position.direction_to(player.global_position)

		velocity = direction * walk_SPEED

		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				last_direction = "right"
			else:
				last_direction = "left"
		else:
			if direction.y > 0:
				last_direction = "down"
			else:
				last_direction = "up"

		animated_sprite_2d.play("walk " + last_direction)
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		animated_sprite_2d.play("idle " + last_direction)
