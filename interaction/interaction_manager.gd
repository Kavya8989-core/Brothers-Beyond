extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const base_text = "[Y] to "

var active_areas = []
var can_interact = true
var interaction_locked = false


func register_area(area: Interaction_area):
	print("REGISTER:", area)
	
	if not active_areas.has(area):
		active_areas.push_back(area)
	
	print("ACTIVE AREAS:", active_areas.size())


func unregister_area(area: Interaction_area):
	print("UNREGISTER:", area)

	var index = active_areas.find(area)

	print("FOUND INDEX:", index)

	if index != -1:
		active_areas.remove_at(index)

	print("ACTIVE AREAS AFTER REMOVE:", active_areas.size())

	if active_areas.size() == 0:
		can_interact = true
		interaction_locked = false

	print("CAN INTERACT:", can_interact)
	print("LOCKED:", interaction_locked)

func _process(_delta: float) -> void:

	if active_areas.size() > 0 and can_interact and !interaction_locked:

		active_areas.sort_custom(_sort_by_distance_to_player)

		label.text = base_text + active_areas[0].action_name

		label.global_position = active_areas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2

		label.show()

	else:
		label.hide()


func _sort_by_distance_to_player(area1, area2):

	var area1_to_player = player.global_position.distance_to(
		area1.global_position
	)

	var area2_to_player = player.global_position.distance_to(
		area2.global_position
	)

	return area1_to_player < area2_to_player


func _input(event):

	if event.is_action_pressed("interact") and can_interact:

		if active_areas.size() > 0:

			var area = active_areas[0]

			if area.interact.is_valid():

				can_interact = false
				interaction_locked = true
				label.hide()

				area.interact.call()
