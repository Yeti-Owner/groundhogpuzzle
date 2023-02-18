extends CanvasLayer

@onready var InteractionLabel := $InteractionText
@onready var InteractIcon := $CenterContainer/crosshair
@onready var Clock := $TextureRect/Label
@onready var Journal := $Journal

var TimeLeft:int = 120

func _ready():
	Eventbus.interaction.connect(_set_interaction)
	Journal.visible = false

func _process(_delta) -> void:
	if Input.is_action_just_pressed("journal"):
		Journal.visible = !Journal.visible

func _set_interaction(icon, text):
	if icon == null:
		InteractIcon.set_visible(false)
	else:
		InteractIcon.texture = load(icon)
	
	if text == null:
		InteractionLabel.set_text("")
		InteractionLabel.set_visible(false)
	else:
		InteractionLabel.set_text(text)
		InteractionLabel.set_visible(true)

func _on_timer_timeout():
	# Update the time left and the label text
	TimeLeft -= 1
	var minutes = int(TimeLeft / 60)
	var seconds = TimeLeft % 60
	var seconds_string = str(seconds)
	if seconds < 10:
		seconds_string = "0" + seconds_string
	Clock.text = str(minutes) + ":" + seconds_string
	
	# Stop the timer when the time is up
	if TimeLeft == 0:
		$Timer.stop()
