extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label: Label = $Label

const BASE_TEXT = "[Y] to "

var active_areas = []
var can_interact = true


func _ready() -> void:
	label.hide()


func register_area(area: Interaction_area):
	if not active_areas.has(area):
		active_areas.push_back(area)


func unregister_area(area: Interaction_area):
	var index = active_areas.find(area)

	if index != -1:
		active_areas.remove_at(index)


func _process(delta: float) -> void:
	if player == null:
		return

	if active_areas.size() > 0 and can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)

		label.text = "[Y] to " + active_areas[0].action_name

		# Follow the NPC's interaction area
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

			can_interact = false
			label.hide()

			await active_areas[0].interact()

			can_interact = true
