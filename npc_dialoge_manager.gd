extends CanvasLayer

@onready var speaker_label: Label = $PanelContainer/VBoxContainer/speakerLabel
@onready var dialogue_label: Label = $PanelContainer/VBoxContainer/dialogueLabel

var is_dialogue_over : bool =false
var dialogue = []
var current_line: int = 0
var is_dialogue_active: bool = false


func _ready() -> void:
	hide()


func start_dialogue(new_dialogue: Array) -> void:
	dialogue = new_dialogue
	current_line = 0
	is_dialogue_active = true
	is_dialogue_over = false
	print("start line is called")
	speaker_label.show()
	dialogue_label.show()

	show()
	display_line()


func display_line() -> void:
	print("Speaker Label: ", speaker_label)
	print("Dialogue Label: ", dialogue_label)

	speaker_label.text = dialogue[current_line]["speaker"]
	dialogue_label.text = dialogue[current_line]["text"]


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_dialogue_active:
		current_line += 1
		get_viewport().set_input_as_handled()
		if current_line >= dialogue.size():
			print("last line reached")
			end_dialogue()
		else:
			display_line()


func end_dialogue() -> void:
	is_dialogue_active = false
	is_dialogue_over = true
	print("is_dialogue over ", is_dialogue_over)
	hide()
	speaker_label.hide()
	dialogue_label.hide()
