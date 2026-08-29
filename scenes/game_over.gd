extends CanvasLayer
@onready var game_over_vid = $VideoStreamPlayer
@onready var music = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_vid.hide()
func play():
	game_over_vid.show()
	game_over_vid.play()
	music.play()
	await game_over_vid.finished
	music.stream_paused = true
	game_over_vid.hide()
