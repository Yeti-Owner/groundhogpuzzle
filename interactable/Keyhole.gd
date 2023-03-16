extends Interactable

var Used = false
var Stage:int = 0

func get_interaction_text():
	if Eventbus.HasKey == false:
		return "[center]A normal keyhole, [color=CHARTREUSE]maybe there's a key somewhere[/color][/center]"
	elif Stage == 0:
		return "[center]Press E to [color=ROYAL_BLUE]insert key[/color][/center]"
	elif Stage == 1:
		return "[center]Press E to [color=ROYAL_BLUE]turn key[/color][/center]"

func get_interaction_icon():
	return "res://assets/textures/ui/action.png"

func interact():
	if Eventbus.HasKey == true:
		if not Used:
			Used = true
			if Stage == 0:
				$Timer.start()
				if Eventbus.MachineStage == 3:
					Eventbus.MachineStage = 4
				else:
					Eventbus.emit_signal("NewLoop")
			elif Stage == 1:
				if Eventbus.MachineStage == 5:
					Eventbus.MachineStage = 6
					$CollisionShape3D.disabled = true
				else:
					Eventbus.emit_signal("NewLoop")

func _on_timer_timeout():
	Stage = 1
	Used = false
