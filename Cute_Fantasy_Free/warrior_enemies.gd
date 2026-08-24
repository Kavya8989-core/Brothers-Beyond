extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var speed : int = 70
var health : int = 50
var mc : Node2D
var is_mc_in_range : bool = false
var is_in_attack_range : bool = false

func takes_dmg() -> void:
	if GameManager.mc_attacks == true:
		health -= 20
		GameManager.mc_attacks = false
		if health <= 0 :
			health = 0
			$CollisionShape2D.set_deferred("disabled",true)
			animated_sprite.play("death")
	print(health)

func _ready() -> void:
	animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	if is_mc_in_range:
		if health > 0:
			if is_in_attack_range:
				velocity = Vector2.ZERO
				animated_sprite.play("attack")
				GameManager.enemy_attacks = true
				await get_tree().create_timer(0.1).timeout
				GameManager.enemy_attacks = false
			else:
				var direction = global_position.direction_to(mc.global_position)
				velocity = speed*direction
				animated_sprite.play("run")
				move_and_slide()
		else:
			pass


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_mc_in_range = true
		print("mc in range")
		mc = body


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == mc:
		is_mc_in_range = false
		print("mc exited")
		mc = null

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_in_attack_range = true
		print("is in attack range")
