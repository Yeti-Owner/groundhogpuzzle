extends Control

@onready var Left := $Left
@onready var Right := $Right

var limit := 3
var list1 := []
var list2 := []
var formatted_text := ""
var formatted_text2 := ""

func _ready():
	Eventbus.UpdatedJournal.connect(_update_journal)

func _update_journal():
	for str in Eventbus.JournalEntries:
		if Eventbus.JournalEntries[str] < limit:
			if str not in list1: list1.append(str)
			continue
		else:
			if str not in list1: list2.append(str)
			continue
	
	formatted_text = ""
	for string in list1:
		formatted_text += string + "\n"
	formatted_text2 = ""
	for string in list2:
		formatted_text2 += string + "\n"
	
	Left.set_text(formatted_text)
	Right.set_text(formatted_text2)
