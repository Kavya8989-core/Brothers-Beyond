extends Area2D
@onready var player = get_tree().get_first_node_in_group("player")
var is_at_promotion : bool = false

func _input(event: InputEvent) -> void:
	if is_at_promotion :
		print("input called")
		get_tree().change_scene_to_file("res://scene 3.tscn")

func _on_body_entered(body: Node2D) -> void:
	if is_in_group("player"):
		is_at_promotion = true
		print("promotion occured")
