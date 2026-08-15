extends Area2D
class_name Interaction_area

@export var action_name: String = "interact"

var interact: Callable


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	print("ENTERED BODY: ", body.name)
	print("BODY POSITION: ", body.global_position)
	print("AREA POSITION: ", global_position)

	if body.is_in_group("player"):
		print("THIS IS PLAYER")
		InteractionManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("PLAYER EXITED")
		InteractionManager.unregister_area(self)
