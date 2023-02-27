extends Control

func _ready():
	SceneManager._swap_hud("res://scenes/menu.tscn")
	queue_free()
