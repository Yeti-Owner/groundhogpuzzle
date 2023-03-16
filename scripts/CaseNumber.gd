extends Node3D

@onready var Screen := $Screen/Label3D

var CorrectNums:String = "9834"
var Nums:String = ""

func _ready():
	Screen.text = ""

func _update_code(new_num:String):
	Nums += new_num
	Screen.text = str(Nums)
	
	if Nums.length() >= CorrectNums.length():
		if Eventbus.MachineStage != 4:
			Eventbus.CorrectOrder = false
		
		if Nums == CorrectNums:
			Eventbus.MachineStage = 5
			for child in $Numbers.get_children():
				child.process_mode = Node.PROCESS_MODE_DISABLED
		else:
			Nums = ""
			Screen.text = ""
