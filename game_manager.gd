extends Node
signal inventory_updated

var saved_position : Vector2
var returning_from_house: bool = false
var fox_coming_out : bool = false
var fox_can_follow : bool = false
var save_checkpoint : bool = false
var mc_attacks : bool = false
var enemy_attacks : bool = false
var enemy_blocked : bool = false
var is_mc_died : bool = false
var coin : int = 0
var inventory : Iventory = preload("res://inventory/player_inventory_resource.tres")

func add_coin(amount : int) -> void :
	coin += amount

func add_item(item: InventoryItem):
	for i in range(inventory.items.size()):
		if inventory.items[i] == item:
			inventory.quantity[i] += 1
			print(item.name, " x", inventory.quantity[i])
			return
	for i in range(inventory.items.size()):
		if inventory.items[i] == null:
			inventory.items[i] = item
			inventory.quantity[i]=1
			print("Added: ", item.name)
			inventory_updated.emit()
			return
		
