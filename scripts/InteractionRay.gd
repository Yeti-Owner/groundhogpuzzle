extends RayCast3D

var current_collider

func _ready():
	Eventbus.interaction.emit("res://assets/textures/ui/crosshair.png", null)

func _process(_delta) -> void:
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			Eventbus.interaction.emit(collider.get_interaction_icon(),collider.get_interaction_text())
			current_collider = collider
		
		if Input.is_action_just_pressed("interact"):
			collider.interact()
			Eventbus.interaction.emit(collider.get_interaction_icon(), collider.get_interaction_text())
	elif current_collider:
		current_collider = null
		Eventbus.interaction.emit("res://assets/textures/ui/crosshair.png", null)
