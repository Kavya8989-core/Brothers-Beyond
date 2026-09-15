extends Node2D
func _on_inventory_gui_closed() -> void:
	get_tree().paused = false


func _on_inventory_gui_opened() -> void:
	get_tree().paused = true


func _on_lev_4_promotion_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file('res://scenes/terrain.tscn')


func _on_save_progress_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.save_pt = true
		GameManager.saved_loc(body.global_position.x , body.global_position.y)
