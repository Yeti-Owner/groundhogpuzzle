extends Interactable

func get_interaction_text():
	return "[center]Test block! Press E[/center]"

func get_interaction_icon():
	return "res://assets/textures/ui/question.png"

func interact():
	if not Eventbus.JournalEntries.has("- This is Entry 1"):
		Eventbus.JournalEntries["- This is Entry 1"] = 1
		Eventbus.emit_signal("UpdatedJournal")
