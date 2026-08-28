extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar = $health_bar
@onready var coin = $coin
var speed : int = 70
var health : int = 50
var mc : Node2D
var is_mc_in_range : bool = false
var is_in_attack_range : bool = false
var attack_ready := true
var count_attack : int = 0


func takes_dmg() -> void:
	if GameManager.mc_attacks == true and GameManager.enemy_blocked == false:
		health -= 20
		GameManager.mc_attacks = false
		if health <= 0 :
			health = 0
			$CollisionShape2D.set_deferred("disabled",true)
			animated_sprite.play("death")
			await animated_sprite.animation_finished
			coin.show()
			coin.play("coin")
	print(health)

func _ready() -> void:
	health_bar.value = health
	animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	health_bar.value = health
	if health == 0:
		health_bar.hide()
		visible = false
	if is_mc_in_range:
		if health > 0:
			if is_in_attack_range:
				velocity = Vector2.ZERO
				if GameManager.is_mc_died == true:
						animated_sprite.stop()
						animated_sprite.play("idle")

				if attack_ready:
					attack_ready = false
					GameManager.enemy_blocked = false
					animated_sprite.play("attack")
					count_attack +=1
					GameManager.enemy_attacks = true
					if count_attack == 3 :
						count_attack = 0
						animated_sprite.stop()
						animated_sprite.play("block")
						GameManager.enemy_blocked = true
					

					await get_tree().create_timer(0.1).timeout
					GameManager.enemy_attacks = false

					await get_tree().create_timer(1.0).timeout
					attack_ready = true
			else:
				var direction = global_position.direction_to(mc.global_position)
				velocity = speed * direction
				animated_sprite.play("run")
				move_and_slide()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_mc_in_range = true
		print("mc in range")
		mc = body


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == mc:
		is_mc_in_range = false
		animated_sprite.play("idle")
		print("mc exited")
		mc = null

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_in_attack_range = true
		print("is in attack range")
