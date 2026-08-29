extends CanvasLayer

signal dialogue_finished

@onready var panel = $Panel
@onready var name_label = $Panel/nameLabel
@onready var dialogue_label = $Panel/dialogueLabel

var dialogue = []
var current_line = 0
var is_open = false


func _ready():
	hide()


func start_dialogue(lines: Array):
	dialogue = lines
	current_line = 0
	is_open = true

	show_line()
	show()
func show_line():
	var line = dialogue[current_line]

	name_label.text = line["speaker"]
	dialogue_label.text = line["text"]

	print(line["speaker"], ": ", line["text"])

func _input(event):
	if not is_open:
		return

	if event.is_action_pressed("interact"):
		print("DIALOGUE Y PRESSED")

		current_line += 1

		if current_line >= dialogue.size():
			close_dialogue()
		else:
			show_line()

		get_viewport().set_input_as_handled()


func close_dialogue():
	is_open = false
	hide()
	dialogue_finished.emit()
