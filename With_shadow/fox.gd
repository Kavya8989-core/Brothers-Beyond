extends CharacterBody2D

const walk_SPEED = 100.0
const run_SPEED=200.0

func _process(delta: float) -> void:
	print("fox reading ", DialogueManager.is_dialogue_over)
