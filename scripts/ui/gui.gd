extends CanvasLayer

@onready var InteractionLabel := $InteractionText
@onready var InteractIcon := $CenterContainer/crosshair

func _ready():
	Eventbus.interaction.connect(_set_interaction)

func _set_interaction(icon, text):
	if icon == null:
		InteractIcon.set_visible(false)
	else:
		InteractIcon.texture = load(icon)
	
	if text == null:
		InteractionLabel.set_text("")
		InteractionLabel.set_visible(false)
	else:
		InteractionLabel.set_text(text)
		InteractionLabel.set_visible(true)
