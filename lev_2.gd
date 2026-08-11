extends Area2D

@onready var label: Label = $Label

var level: int = 1
var _is_in_range: bool = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_is_in_range = true
		print("entered")
		label.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_is_in_range = false
		print("exited")
		label.hide()
