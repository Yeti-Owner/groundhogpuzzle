extends Interactable

@onready var Num:String = self.name
@onready var CaseHolder := get_parent().get_parent()

func get_interaction_text():
	return "[center]Press E to enter [color=ROYAL_BLUE]%s[/color][/center]" % Num

func get_interaction_icon():
	return "res://assets/textures/ui/action.png"

func interact():
	CaseHolder._update_code(Num)
	
