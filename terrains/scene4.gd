extends Node2D


func _on_stair_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.stairs_left = true


func _on_stair_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.stairs_left = false


func _on_stair_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.stairs_right = true


func _on_stair_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.stairs_right = false


func _on_stair_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.stairs_left = true


func _on_stair_3_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.stairs_left = false


func _on_tunnel_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_collision_mask_value(1,false)
		print("tunnel")


func _on_tunnel_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_collision_mask_value(3,true)
		body.set_collision_mask_value(1,true)
		print("boundary")


func _on_above_tunnel_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_collision_mask_value(3,false)
