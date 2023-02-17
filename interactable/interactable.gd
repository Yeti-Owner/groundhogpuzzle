extends Node

class_name Interactable

func get_interaction_text():
	return "Interact"

func get_interaction_icon():
	return "res://assets/textures/ui/crosshair.png"

func interact():
	print("Interacted with me")
