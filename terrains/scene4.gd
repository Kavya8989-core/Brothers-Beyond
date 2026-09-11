extends Node2D
@onready var tunnel_area = $tunnel
@onready var tunnel_collision = $tunnel/CollisionShape2D
@onready var inside_tunnel_ar = $"inside tunnel detection"
@onready var inside_tunnel_col = $"inside tunnel detection/CollisionShape2D"
@onready var mc = $CharacterBody2D

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
		body.get_node_and_resource("HealthBar")
		print("boundary")


func _on_above_tunnel_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tunnel_area.monitoring = false
		inside_tunnel_ar.monitoring = false
		mc.z_index = 4
		inside_tunnel_col.set_deferred("disabled",true)
		tunnel_collision.set_deferred("disabled",true)
		body.set_collision_mask_value(3,false)
		print("above tunnel")

func _on_on_tunnel_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		inside_tunnel_ar.monitoring = true
		mc.z_index = 2
		inside_tunnel_col.set_deferred("disabled",false)
		print("on the tunnel layer")
		tunnel_area.monitoring = true
		tunnel_collision.set_deferred("disabled", false)


func _on_inside_tunnel_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("inside the tunnel")


func _on_inside_tunnel_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.get_node("HealthBar").show()


func _on_on_tunnel_area_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		inside_tunnel_ar.monitoring = true
		mc.z_index = 2
		inside_tunnel_col.set_deferred("disabled",false)
		print("on the tunnel layer")
		tunnel_area.monitoring = true
		tunnel_collision.set_deferred("disabled", false)


func _on_above_tunnel_detection_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tunnel_area.monitoring = false
		inside_tunnel_ar.monitoring = false
		mc.z_index = 4
		inside_tunnel_col.set_deferred("disabled",true)
		tunnel_collision.set_deferred("disabled",true)
		body.set_collision_mask_value(3,false)
		print("above tunnel")
