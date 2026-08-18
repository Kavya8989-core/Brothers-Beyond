extends Node2D


func _ready() -> void:
	if GameManager.fox_coming_out:
		var fox = preload("res://With_shadow/fox.tscn").instantiate()
		add_child(fox)

		fox.global_position = $FoxSpawnPoint.global_position

		GameManager.fox_coming_out = false
