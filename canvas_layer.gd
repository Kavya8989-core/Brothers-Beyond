extends CanvasLayer
@onready var inventory = $"inventory gui"

func _ready() -> void:
	inventory.close()
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		inventory.open()
	elif event.is_action_pressed("close"):
		inventory.close()
		print("close")
	
