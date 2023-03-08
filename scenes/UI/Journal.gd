extends Control

@onready var RightText := $RightPage/Right
@onready var Left := $LeftPage

var CurrentPage:int = 0

func _ready():
	self.visible = false
	Eventbus.UpdatedJournal.connect(_update_journal)
	_update_journal()

func _next_page():
	CurrentPage = min(CurrentPage + 1, Eventbus.JournalEntries.size() - 1)
	_update_journal()

func _last_page():
	CurrentPage = max(CurrentPage - 1, 0)
	_update_journal()

func _update_journal():
	# Remove current page + text
	for child in Left.get_children():
		child.queue_free()
	RightText.text = ""
	
	# Add new page + text
	match Eventbus.JournalEntries[CurrentPage]:
		"journal":
			_set_page(load("res://scenes/journalpages/page_1.tscn"), "- Time machine trial #09124\n- Subject's vitals seem alright ig")
		"audio":
			pass
		"note":
			_set_page(load("res://scenes/journalpages/page_stickynote.tscn"), "- This is text 2\n - Yup")

func _set_page(pagescene:PackedScene, text:String):
	var _page:Node = pagescene.instantiate()
	Left.add_child(_page)
	RightText.text = text
