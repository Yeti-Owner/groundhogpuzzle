extends Control

@onready var LeftText := $LeftPage/Left
@onready var RightText := $RightPage/Right

var limit := 3
var list1 := []
var list2 := []
var formatted_text := ""
var formatted_text2 := ""

func _ready():
	Eventbus.UpdatedJournal.connect(_update_journal)

func _update_journal():
	for line in Eventbus.JournalEntries:
		if Eventbus.JournalEntries[line] < limit:
			if line not in list1: list1.append(line)
			continue
		else:
			if line not in list1: list2.append(line)
			continue
	
	formatted_text = ""
	for string in list1:
		formatted_text += string + "\n"
	formatted_text2 = ""
	for string in list2:
		formatted_text2 += string + "\n"
	
	LeftText.set_text(formatted_text)
	RightText.set_text(formatted_text2)
