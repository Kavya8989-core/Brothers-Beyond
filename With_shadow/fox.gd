extends CharacterBody2D
@onready var player = get_tree().get_first_node_in_group("player")
const walk_SPEED = 70.0
const run_SPEED=200.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	animated_sprite_2d.play("idle down")
	if DialogueManager.is_dialogue_over:
		var direction = global_position.direction_to(player.global_position)

		velocity = direction * walk_SPEED

		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				animated_sprite_2d.play("walk right")
			else:
				animated_sprite_2d.play("walk left")
		else:
			if direction.y > 0:
				animated_sprite_2d.play("walk down")
			else:
				animated_sprite_2d.play("walk up")

		move_and_slide()
