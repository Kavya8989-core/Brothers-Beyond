extends Node

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

func add_coin(amount : int) -> void :
	coin += amount
