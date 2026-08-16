extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label
@onready var player = get_tree().get_first_node_in_group("player")
@onready var dialogue_gd: CanvasLayer = $"dialogue gd"



var dialogue = [
	{"speaker": "Amelia", "text": "You're not from around here... are you?"},
	{"speaker": "Arden", "text": "No. I'm looking for my little brother."},
	{"speaker": "Amelia", "text": "Your little brother..."},
	{"speaker": "Arden", "text": "A man named Kevin told me you might know where he is."},
	{"speaker": "Amelia", "text": "Kevin... I see."},
	{"speaker": "Amelia", "text": "Then you need to listen carefully."},
	{"speaker": "Arden", "text": "What happened to him?"},
	{"speaker": "Amelia", "text": "He was taken by the spirit."},
	{"speaker": "Arden", "text": "The spirit?"},
	{"speaker": "Amelia", "text": "An evil spirit that rules this world. It has taken many people before him."},
	{"speaker": "Arden", "text": "Where is he?"},
	{"speaker": "Amelia", "text": "Beyond the grasslands. But getting there won't be easy."},
	{"speaker": "Amelia", "text": "There are creatures hiding everywhere. Some will attack you. Others will try to lure you into traps."},
	{"speaker": "Arden", "text": "Then I'll deal with them."},
	{"speaker": "Amelia", "text": "It's not only the creatures you should fear."},
	{"speaker": "Amelia", "text": "You don't understand. This world is dangerous."},
	{"speaker": "Amelia", "text": "There are creatures here that I've never seen before. Some places look safe until you get too close."},
	{"speaker": "Amelia", "text": "There are traps hidden in the ruins, strange paths that lead nowhere, and places where even the ground isn't safe."},
	{"speaker": "Arden", "text": "I don't care how dangerous it is. He's my brother."},
	{"speaker": "Amelia", "text": "I thought you might say that."},
	{"speaker": "Arden", "text": "Then tell me what I need to know."},
	{"speaker": "Amelia", "text": "I can't show you the way. I've never traveled that far."},
	{"speaker": "Amelia", "text": "But perhaps he can."},
	{"speaker": "Arden", "text": "A fox?"},
	{"speaker": "Amelia", "text": "Don't underestimate him."},
	{"speaker": "Amelia", "text": "He's been with me for years. He's traveled farther into this world than I ever could."},
	{"speaker": "Amelia", "text": "He knows the paths, the dangers... even some of the creatures."},
	{"speaker": "Arden", "text": "And you want me to take him with me?"},
	{"speaker": "Amelia", "text": "He'll know this world better than I ever will."},
	{"speaker": "Amelia", "text": "Keep him close. He may be the reason you find your brother."},
	{"speaker": "Arden", "text": "Alright. Come on, little guy."},
	{"speaker": "Amelia", "text": "And Arden..."},
	{"speaker": "Arden", "text": "Yeah?"},
	{"speaker": "Amelia", "text": "Stay alert. Not everything in this world is what it seems."},
	{"speaker": "Arden", "text": "I'll find him."},
]

const SPEED = 300.0
var current_direction : String = "left"
var is_in_range : bool =false
var health : int = 50
func process_animaiton() -> void:
	animated_sprite_2d.play("idle " + current_direction)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_in_range and not dialogue_gd.is_dialogue_active:

		if player.global_position.x > global_position.x:
			current_direction = "right"
		elif player.global_position.x < global_position.x:
			current_direction = "left"
		elif player.global_position.y < global_position.y:
			current_direction = "up"
		elif player.global_position.y > global_position.y:
			current_direction = "down"

		print("Starting dialogue")

		dialogue_gd.start_dialogue(dialogue)
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
