extends Interactable

var Used = false

func get_interaction_text():
	return "[center]Press E to collect [color=red]audio tape[/color][/center]"

func get_interaction_icon():
	return "res://assets/textures/ui/question.png"

func interact():
	if not Used:
		Used = true
		Eventbus.JournalEntries.append("audio")
		Eventbus.emit_signal("UpdatedJournal")
		self.queue_free()
