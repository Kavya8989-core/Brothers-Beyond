extends CanvasLayer


@onready var name_label: Label = $"PanelContainer/VBoxContainer/name Label"
@onready var dialoge_label: Label = $"PanelContainer/VBoxContainer/dialoge Label"

var dialogue = []
var is_dialogue_active : bool = false
var current_line : int = 0

func start_convo(new_dialogue) -> void:
	dialogue=new_dialogue
	current_line=0
	is_dialogue_active=true
	show()
	display_line()
	print("visible")
	
func display_line() -> void:
	name_label.text=dialogue[current_line]["speaker"]
	dialoge_label.text = dialogue[current_line]["text"]
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_dialogue_active:
		current_line +=1
		
		if current_line>dialogue.size():
			end_dialogue()
		else:
			display_line()
			
func end_dialogue() -> void:
	is_dialogue_active=false
	hide()
