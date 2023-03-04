extends Interactable

@export var Num:int = 1
@onready var Keypad := get_parent().get_parent()

func get_interaction_text():
	return "[center]Press E to enter [color=blue]%s[/color][/center]" % Num

func get_interaction_icon():
	return "res://assets/textures/ui/action.png"

func interact():
	Keypad.NumberCombo = Keypad.NumberCombo + str(Num)
	
