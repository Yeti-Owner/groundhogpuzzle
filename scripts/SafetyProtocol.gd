extends Node3D

var CorrectOrder:Array = ["South","North","East","West"]
var Order:Array = []

func _check_order(value):
	Order.append(value)
	if Order.size() == 4:
		if Order == CorrectOrder:
			Eventbus.MachineStage = 2
		else:
			Eventbus.CorrectOrder = false
