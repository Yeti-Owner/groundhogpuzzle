extends CanvasLayer

@onready var InteractionLabel := $InteractionText
@onready var InteractIcon := $CenterContainer/crosshair
@onready var Clock := $TextureRect/Label
#@onready var Journal := $Journal

var TimeLeft:int = 120

var averageframes:Array

func _ready():
	Eventbus.interaction.connect(_set_interaction)
	Eventbus.JournalCollected.connect(_add_journal)
#	Journal.visible = false

func _process(_delta) -> void:
	if Input.is_action_just_pressed("journal") and Eventbus.FoundJournal:
		get_node("Journal").visible = !get_node("Journal").visible
		if Input.get_mouse_mode() == 0: Input.set_mouse_mode(2)
		else: Input.set_mouse_mode(0)

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
	@warning_ignore("integer_division")
	var minutes = int(TimeLeft / 60)
	var seconds = TimeLeft % 60
	var seconds_string = str(seconds)
	if seconds < 10:
		seconds_string = "0" + seconds_string
	Clock.text = str(minutes) + ":" + seconds_string
	
	# Stop the timer when the time is up
	if TimeLeft == 0:
		$Timer.stop()

func _on_timer_2_timeout():
	var frames = Performance.get_monitor(Performance.TIME_FPS)
	$Label.text = str(frames)
	averageframes.append(frames)

func _on_timer_3_timeout():
#	$Timer2.stop()
	var total:int = 0
	for value in averageframes:
		total += value
	print(str(total/averageframes.size()))
