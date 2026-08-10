extends Area2D

class_name Interaction_area

@export var action_name: String = "interact"

var interact: Callable = func():
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("PLAYER ENTERED INTERACTION AREA")
		InteractionManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("PLAYER EXITED INTERACTION AREA")
		InteractionManager.unregister_area(self)	
