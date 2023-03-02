extends Control

@onready var RightText := $RightPage/Right
@onready var Left := $LeftPage

var CurrentPage:int = 0

func _ready():
	Eventbus.UpdatedJournal.connect(_update_journal)
	_update_journal()

func _next_page():
	CurrentPage = min(CurrentPage + 1, Eventbus.JournalEntries.size() - 1)
	_update_journal()

func _last_page():
	CurrentPage = max(CurrentPage - 1, -1)
	_update_journal()

func _update_journal():
	match Eventbus.JournalEntries[CurrentPage]:
		"journal":
			var page:PackedScene = load("res://scenes/journalpages/page_1.tscn")
			var _page:Node = page.instantiate()
			Left.add_child(_page)
			RightText.text = "- Time machine trial #09124\n- Subject's vitals seem alright ig"
		"audio":
			pass
	
	
