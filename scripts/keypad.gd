extends Node3D

@onready var Screen := get_node("Screen/Text")
@export var door:NodePath

var NumberCombo = "" : set = _update_code
var CorrectNumbers:String = "3879498"

func _ready():
	Screen.text = ""

func _update_code(new_code:String):
	NumberCombo = new_code
	Screen.text = str(new_code)
	if new_code.length() >= CorrectNumbers.length():
		if new_code == CorrectNumbers:
			Eventbus.MachineStage = 1
			get_node(door).queue_free()
			for child in $Buttons.get_children():
				child.process_mode = Node.PROCESS_MODE_DISABLED
		else:
			NumberCombo = ""
			new_code = ""
