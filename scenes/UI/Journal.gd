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
			_set_page(load("res://scenes/journalpages/page_1.tscn"), "[center]Entry #1, Order of Events[/center]")
		"audio":
			_set_page(load("res://scenes/journalpages/page_audio.tscn"), "[center]Transcription of Audio Recording:[/center]\n \n[font_size=14][color=AQUA]Hey Greg, what's the point of this again?[/color]\n[color=green]The recordings or the experiment?[/color]\n[color=AQUA ]The experiment. I think there's too much room for error here.[/color]\n[color=green]It'll be find... Mind passing me the South then North, please?[/color]\n[color=AQUA]Sure thing. Even scientifically isn't this wrong?[/color]\n[color=green]I prefer not to think about it. Just focus on the paycheck and the history books.[/color]\n[color=AQUA]I hear ya... Need West and Eat now?[/color]\n[color=green]Other way around but yes please.[/color][/font_size]\n \n[center]End of recording[/center]")
		"note":
			_set_page(load("res://scenes/journalpages/page_stickynote.tscn"), "[center]Sticky note reads:[/center]\n \n Edward you idiot stop forgetting the numbers\n we shouldn't have to write down the numbers for your bird brain\n this is a high security project and I'd prefer not to have a stickynote with the numbers on it\n \n [center]3879498[/center]")

func _set_page(pagescene:PackedScene, text:String):
	var _page:Node = pagescene.instantiate()
	Left.add_child(_page)
	RightText.text = text
