extends Node2D
@onready var tunnel_area = $"above tunnel detection/tunnel"
@onready var tunnel_collision = $"above tunnel detection/tunnel/CollisionShape2D"

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
		tunnel_area.monitoring = false
		tunnel_collision.set_deferred("disabled",true)
		body.set_collision_mask_value(3,false)
		print("above tunnel")

func _on_on_tunnel_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("on the tunnel layer")
		tunnel_area.monitoring = true
		tunnel_collision.set_deferred("disabled", false)
