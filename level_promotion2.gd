extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.saved_position = body.global_position
		print(body.global_position)
		print (GameManager.saved_position)
		get_tree().change_scene_to_file("res://scenes/scene 3.tscn")
