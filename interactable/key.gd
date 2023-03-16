extends Interactable

var Used = false

func get_interaction_text():
	return "[center]Press E to collect [color=red]key[/color][/center]"

func get_interaction_icon():
	return "res://assets/textures/ui/question.png"

func interact():
	if not Used:
		Used = true
		Eventbus.HasKey = true
		Eventbus.JournalEntries.append("key")
		Eventbus.emit_signal("UpdatedJournal")
		self.queue_free()
