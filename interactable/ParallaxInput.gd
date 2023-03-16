extends Interactable

var Used = false

func _ready():
	$Insert.visible = false
	$Insert/StaticBody3D/CollisionShape3D.disabled = true

func get_interaction_text():
	if Eventbus.ParallaxReducer == false:
		return "[center]A weirdly shaped depression, [color=CHARTREUSE]maybe find something to fit in?[/color][/center]"
	else:
		return "[center]Press E to [color=ROYAL_BLUE]insert Parallax Reducer[/color][/center]"

func get_interaction_icon():
	return "res://assets/textures/ui/action.png"

func interact():
	if not Used:
		Used = true
		$CollisionShape3D.disabled = true
		if Eventbus.MachineStage == 2:
			Eventbus.MachineStage = 3
			$Insert.visible = true
			$Insert/StaticBody3D/CollisionShape3D.disabled = false
		else:
			Eventbus.emit_signal("NewLoop")
