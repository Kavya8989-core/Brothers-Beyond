extends Panel

@onready var quantity_label:Label = $QuantityLabel
@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D =$CenterContainer/Panel/item

func update(item : InventoryItem,quantity : int):
	if !item:
		backgroundSprite.frame = 0
		itemSprite.visible = false
	else:
		backgroundSprite.frame = 1
		itemSprite.visible = true
		itemSprite.texture = item.texture
		itemSprite.scale = Vector2(0.035, 0.035)
		quantity_label.visible = true
		quantity_label.text = str(quantity)
