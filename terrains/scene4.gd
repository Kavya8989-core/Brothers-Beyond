extends Node2D


var player_entered : bool = false


func _on_stair_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_entered = true


func _on_stair_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_entered = false
