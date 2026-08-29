extends CanvasLayer
@onready var game_over_vid = $VideoStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_vid.hide()
func play():
	game_over_vid.show()
	game_over_vid.play()
	await game_over_vid.finished
	game_over_vid.hide()
