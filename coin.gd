extends AnimatedSprite2D

var coin_recieved : bool = false
@onready var coin = $"."
var coin_item : InventoryItem = preload("res://inventory/coins.tres"	)
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") :
		GameManager.add_item(coin_item)
		coin_recieved = true
		queue_free()
