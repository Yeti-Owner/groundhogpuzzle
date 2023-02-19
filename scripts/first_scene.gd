extends Control

func _ready():
	SceneManager._change_scene("res://scenes/menu.tscn")
	queue_free()
