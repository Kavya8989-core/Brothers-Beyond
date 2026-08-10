extends CharacterBody2D
@onready var raycast = $RayCast2D

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
func _process(delta: float) -> void:
	if current_state == 0 or current_state ==1:
		$AnimatedSprite2D.play("idle"+ direction_prefix)
		
	elif current_state==2 and !is_chatting:
		
		if dir.x>0 :
			direction_prefix=" right"
		if dir.x<0 :
			direction_prefix=" left"
		if dir.y<0:
			direction_prefix=" up"
		if dir.y>0:
			direction_prefix=" down"
			
		$AnimatedSprite2D.play("walking" + direction_prefix)
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.LEFT,Vector2.UP,Vector2.DOWN])
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
	if body.has_method("player"):
		player=body
		player_is_in_chat_zone=true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		player_is_in_chat_zone=false
		



func _on_timer_timeout() -> void:
	$Timer.wait_time=choose([0.5,1,1.5])
	current_state=choose([IDLE,NEW_DIR,MOVE])
