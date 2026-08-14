extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 300.0
var current_direction : String = "left"
var is_in_range : bool =false

func process_animaiton() -> void:
	animated_sprite_2d.play("idle " + current_direction)

func _process(delta: float) -> void:
	process_animaiton()



func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
