extends AnimatedSprite2D


@onready var coin = $"."

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") :
		GameManager.add_coin(100)
		coin.hide()
