extends Interactable

@export_enum("North", "South", "East", "West") var Dir:String = "North"

var Used = false

func _ready():
	$Mesh.mesh.material.albedo_color = Color8(255, 255, 255)

func get_interaction_text():
	return "[center]Press E to enter [color=ROYAL_BLUE]%s[/color][/center]" % Dir

func get_interaction_icon():
	return "res://assets/textures/ui/action.png"

func interact():
	if not Used:
		Used = true
		$CollisionShape3D.disabled = true
		$Mesh.mesh.material.albedo_color = Color8(169, 255, 255)
		if Eventbus.MachineStage == 1:
			get_parent()._check_order(Dir)
		else:
			Eventbus.CorrectOrder = false
