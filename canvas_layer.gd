extends CanvasLayer
@onready var inventory = $"inventory gui"

func _ready() -> void:
	inventory.close()
	

func _input(event: InputEvent) -> void:
	if event.is_action("inventory"):
		if inventory.isOpen:
			inventory.close()
		else:
			inventory.open()
	
