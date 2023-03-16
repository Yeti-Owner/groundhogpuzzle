extends Interactable

var Used = false

func get_interaction_text():
	return "[center]Press E to [color=ROYAL_BLUE]push button[/color][/center]"

func get_interaction_icon():
	return "res://assets/textures/ui/action.png"

func interact():
	if not Used:
		Used = true
		if Eventbus.MachineStage == 6 and Eventbus.CorrectOrder == true:
			Eventbus.emit_signal("Complete")
		else:
			Eventbus.emit_signal("NewLoop")
