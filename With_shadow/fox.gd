extends CharacterBody2D
@onready var player = get_tree().get_first_node_in_group("player")
const walk_SPEED = 100.0
const run_SPEED=200.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if DialogueManager.is_dialogue_over:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * walk_SPEED
		animated_sprite_2d.play("walk left")
		move_and_slide()
