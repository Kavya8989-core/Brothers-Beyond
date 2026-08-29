extends Area2D

@onready var label: Label = $Label

var _is_in_range: bool = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and _is_in_range:
		GameManager.returning_from_house = true
		DialogueManager.close_dialogue()
		GameManager.fox_coming_out = true
		DialogueManager.is_dialogue_active == false
		get_tree().change_scene_to_file("res://main.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.save_checkpoint = true
		_is_in_range = true
		label.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_is_in_range = false
		label.hide()
