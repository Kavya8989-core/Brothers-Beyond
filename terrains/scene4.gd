extends Node2D


var stairs_left : bool = false
var stairs_right : bool = false

func _on_stair_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		stairs_left = true


func _on_stair_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		stairs_left = false


func _on_stair_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		stairs_right = true


func _on_stair_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		stairs_right = false


func _on_stair_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		stairs_left = true


func _on_stair_3_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		stairs_left = false


func _on_tunnel_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			print("in tunnel")


func _on_tunnel_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
