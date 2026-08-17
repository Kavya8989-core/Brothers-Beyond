extends Area2D

@onready var label: Label = $Label
@onready var player = get_tree().get_first_node_in_group("player")

var _is_in_range: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and _is_in_range:
		DialogueManager.close_dialogue()
		get_tree().change_scene_to_file("res://level 2.tscn")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_is_in_range = true
		label.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_is_in_range = false
		label.hide()
