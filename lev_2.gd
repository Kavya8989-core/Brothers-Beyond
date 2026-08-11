extends Area2D

@onready var label: Label = $Label

var level: int = 1
var _is_in_range: bool = false

func _input(event) -> void:
	if event.is_action_pressed("interact") and _is_in_range :
		print("level 2")
		get_tree().change_scene_to_file("res://level 2.tscn")
		

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_is_in_range = true
		print("entered")
		label.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_is_in_range = false
		print("exited")
		label.hide()
