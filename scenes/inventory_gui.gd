extends Control
signal opened
signal closed
var isOpen : bool = false
@onready var inventory  : Iventory = preload("res://inventory/player_inventory_resource.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()
func _ready() -> void:
	GameManager.inventory_updated.connect(update)
	update()
func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(
			inventory.items[i],
			inventory.quantity[i]
		)
func open():
	visible = true
	isOpen = true
	opened.emit()
func close():
	visible = false
	isOpen = false
	closed.emit()
