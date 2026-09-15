extends Node

const scene_3 = preload("res://scripts gd/scene_3.gd")
@onready var mc  = $"."
var savept : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func save_pos(save_x : float , save_y : float):
	if scene_3.save_pt == true :
		print("checkpoint saved")
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
