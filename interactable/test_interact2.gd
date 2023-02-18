extends Interactable

func get_interaction_text():
	return "[center]Test block #2! Press E[/center]"

func get_interaction_icon():
	return "res://assets/textures/ui/question.png"

func interact():
	if not Eventbus.JournalEntries.has("- Hullo. Entry 2"):
		Eventbus.JournalEntries["- Hullo. Entry 2"] = 2
		Eventbus.emit_signal("UpdatedJournal")
