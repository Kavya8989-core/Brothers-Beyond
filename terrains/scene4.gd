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


func _on_bondaries_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_collision_mask_value(1,true)
		print("boundary")
