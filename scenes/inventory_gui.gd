extends Control
signal opened
signal closed
var isOpen : bool = false
@onready var inventory  : Iventory = preload("res://inventory/player_inventory_resource.tres")
func open():
	visible = true
	isOpen = true
	opened.emit()
func close():
	visible = false
	isOpen = false
	closed.emit()
