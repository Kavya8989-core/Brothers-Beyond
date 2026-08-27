extends AnimatedSprite2D


@onready var coin = $"."
var coin_item : InventoryItem = preload("res://inventory/coins.tres"	)
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") :
		GameManager.add_item(coin_item)
		queue_free()
