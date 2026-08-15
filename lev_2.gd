extends Area2D

@onready var label: Label = $Label

var _is_in_range: bool = false
var player: Node2D = null


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		_is_in_range = true

		print("ENTERED PLAYER = ", player)
		print("ENTERED POSITION = ", player.global_position)

		label.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_is_in_range = false
		player = null

		label.hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and _is_in_range:



		GameManager.player_position = player.global_position
		GameManager.is_position_saved = true

		get_tree().change_scene_to_file("res://level 2.tscn")
