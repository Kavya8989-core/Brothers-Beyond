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
		GameManager.inside_tunnel = true
		body.get_node("CollisionShape2D").set_deferred("disabled", true)


func _on_tunnel_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.inside_tunnel = false
		body.get_node("CollisionShape2D").set_deferred("disabled", false)
