extends CanvasLayer

@onready var InteractionLabel := $InteractionText
@onready var InteractIcon := $CenterContainer/crosshair
@onready var ClockText := $ClockTex/TimeLeft

var TimeLeft:int = 90 # Time in seconds

func _ready():
	Engine.set_max_fps(60)
	Eventbus.interaction.connect(_set_interaction)
	Eventbus.JournalCollected.connect(_add_journal)
	Eventbus.NewLoop.connect(_end_clock)

func _process(_delta) -> void:
	if Input.is_action_just_pressed("journal") and Eventbus.FoundJournal:
		get_node("Journal").visible = !get_node("Journal").visible
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE: Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else: Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

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

func _add_journal():
	var journal:PackedScene = load("res://scenes/UI/journal.tscn")
	var _journal:Node = journal.instantiate()
	self.add_child(_journal)

func _on_timer_timeout():
	# Update the time left and the label text
	TimeLeft -= 1
	@warning_ignore("integer_division") # The point is that it is an integer division lmao
	var minutes = int(TimeLeft / 60)
	var seconds = TimeLeft % 60
	var seconds_string = str(seconds)
	if seconds < 10:
		seconds_string = "0" + seconds_string
	ClockText.text = str(minutes) + ":" + seconds_string
	
	# Stop the timer when the time is up
	if TimeLeft == 0:
		Eventbus.emit_signal("NewLoop")
		$Timer.stop()

func _end_clock():
	$Timer.stop()


