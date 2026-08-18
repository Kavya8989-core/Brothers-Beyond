extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const walk_SPEED = 70.0

var player: CharacterBody2D


func _ready() -> void:
	print("🦊 FOX CREATED: ", get_path())


func _physics_process(_delta: float) -> void:

	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return

	# FOX STAYS STILL UNTIL DIALOGUE IS FINISHED
	if not DialogueManager.is_dialogue_over:
		velocity = Vector2.ZERO
		animated_sprite_2d.play("idle down")
		return

	# FOLLOW MC AFTER DIALOGUE
	var follow_distance = global_position.distance_to(player.global_position)

	if follow_distance > 50:
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
	else:
		velocity = Vector2.ZERO
		animated_sprite_2d.play("idle down")
