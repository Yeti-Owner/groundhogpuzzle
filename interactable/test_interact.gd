extends Interactable

func get_interaction_text():
	return "[center]Test block! Press E[/center]"

func get_interaction_icon():
	return "res://assets/textures/ui/question.png"

func interact():
	print("interacted with block")
