extends Interactable

@export var door:NodePath

var Used = false

func get_interaction_text():
	return "[center]Press E to collect [color=red]scientific journal[/color][/center]"

func get_interaction_icon():
	return "res://assets/textures/ui/question.png"

func interact():
	if not Used:
		Used = true
		Eventbus.JournalEntries.append("journal")
		Eventbus.emit_signal("UpdatedJournal")
		Eventbus.emit_signal("JournalCollected")
		Eventbus.FoundJournal = true
		get_node(door).queue_free()
		self.queue_free()
