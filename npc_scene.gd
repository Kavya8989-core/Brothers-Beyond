extends CharacterBody2D
@onready var raycast = $RayCast2D
@onready var label: Label = $Label

var dialogue = [
	{"speaker": "Kevin", "text": "Hey there!"},
	{"speaker": "Arden", "text": "Hello!"},
	{"speaker": "Kevin", "text": "Oh!! a guest. What brings you here?"},
	{"speaker": "Arden", "text": "I'm looking for a guy maybe five feets tall he's lost here"},
	{"speaker": "Kevin", "text": "Nahh"},
	{"speaker": "Arden", "text": "Actulally he's my little brother I lost him"},
	{"speaker": "Kevin", "text": "A boy.... you say?"},
	{"speaker": "Kevin", "text": "Actully...my wife may have been seen someone you can ask her"},
	{"speaker": "Arden", "text": "Perfect where I can find her"},
	{"speaker": "Kevin", "text": "She is inside the house but please dont' say that I sent you to her she is already mad at me "},
]

const SPEED=70
enum{
	IDLE,
	NEW_DIR,
	MOVE
}
var current_state=IDLE
var is_roaming = true
var is_chatting = false

var player
var player_is_in_chat_zone=false

var dir=Vector2.RIGHT
var direction_prefix="right"
var start_pos



func _ready():
	randomize()
	start_pos = position

	$Area2D.interact = Callable(self, "talk")

	var dialogue_ui = get_tree().get_first_node_in_group("dialogue_ui")

	if dialogue_ui:
		dialogue_ui.dialogue_finished.connect(_on_dialogue_finished)
		
func _on_dialogue_finished():



	is_chatting = false

	if player:
		player.is_in_dialogue = false

	# DO NOT unlock interaction here
	
func talk():

	print("🔥 NPC TALK CALLED")

	is_chatting = true

	if player == null:
		player = get_tree().get_first_node_in_group("player")

	if player:
		player.is_in_dialogue = true
		face_player()

	var dialogue_ui = get_tree().get_first_node_in_group("dialogue_ui")

	if dialogue_ui:
		dialogue_ui.start_dialogue(dialogue)

func face_player():
	if player == null:
		return

	var direction = player.global_position - global_position

	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			direction_prefix = "right"
		else:
			direction_prefix = "left"
	else:
		if direction.y > 0:
			direction_prefix = "down"
		else:
			direction_prefix = "up"

	$AnimatedSprite2D.play("idle" + direction_prefix)
func _process(delta: float) -> void:

	if is_chatting:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("idle " + direction_prefix)
		return

	# Normal animation
	if current_state == IDLE or current_state == NEW_DIR:
		$AnimatedSprite2D.play("idle" + direction_prefix)

	elif current_state == MOVE:

		if dir.x > 0:
			direction_prefix = " right"
		elif dir.x < 0:
			direction_prefix = " left"
		elif dir.y < 0:
			direction_prefix = " up"
		elif dir.y > 0:
			direction_prefix = " down"

		$AnimatedSprite2D.play("walking" + direction_prefix)

	# Normal roaming
	if is_roaming:
		match current_state:
			IDLE:
				pass

			NEW_DIR:
				dir = choose([
					Vector2.RIGHT,
					Vector2.LEFT,
					Vector2.UP,
					Vector2.DOWN
				])

			MOVE:
				move(delta)
				
func choose(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	if is_chatting:
		velocity = Vector2.ZERO
		return

	raycast.target_position = dir * 20

	if raycast.is_colliding():
		velocity = Vector2.ZERO
		dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
		current_state = MOVE
		return

	velocity = dir * SPEED
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		player_is_in_chat_zone = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null
		player_is_in_chat_zone = false
		



func _on_timer_timeout() -> void:
	$Timer.wait_time=choose([0.5,1,1.5])
	current_state=choose([IDLE,NEW_DIR,MOVE])
