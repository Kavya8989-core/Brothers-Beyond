extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const base_text = "[Y] to "

var active_areas = []
var can_interact = true
var interaction_locked = false
func position_label_near_npc(area: Interaction_area) -> void:
	label.global_position = area.global_position + Vector2(-40, -20)
	
func register_area(area: Interaction_area) -> void:
	print("REGISTER CALLED BY: ", area.name)

	if not active_areas.has(area):
		active_areas.append(area)

	print("ACTIVE AREAS: ", active_areas.size())

func unregister_area(area: Interaction_area) -> void:
	if active_areas.has(area):
		active_areas.erase(area)


func unlock_interaction():
	can_interact = true
	interaction_locked = false


func _process(_delta: float) -> void:
	if active_areas.size() > 0:
		position_label_near_npc(active_areas[0])
		label.show()
		label.text = "[Y] to " + active_areas[0].action_name
	else:
		label.hide()

func _input(event):

	if event.is_action_pressed("interact") and can_interact:

		if active_areas.size() > 0:

			var area = active_areas[0]

			if area.interact.is_valid():

				can_interact = false
				interaction_locked = true
				label.hide()

				area.interact.call()
