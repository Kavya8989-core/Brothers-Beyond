extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label
@onready var player = get_tree().get_first_node_in_group("player")

const SPEED = 300.0
var current_direction : String = "left"
var is_in_range : bool =false
var health : int = 50
func process_animaiton() -> void:
	animated_sprite_2d.play("idle " + current_direction)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_in_range:
		if player.global_position.x > global_position.x:
			current_direction = "right"
		elif player.global_position.x < global_position.x:
			current_direction = "left"
		elif player.global_position.y < global_position.y:
			current_direction = "up"
		elif player.global_position.y > global_position.y:
			current_direction = "down"
		print("interacted")

func _process(delta: float) -> void:
	process_animaiton()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_in_range=true
		print("in range")
		label.show()


func _on_area_2d_body_exited(body: Node2D) -> void:
	label.hide()
	pass
