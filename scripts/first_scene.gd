extends Control

func _ready():
	SceneManager._change_scene("res://world.tscn")
	queue_free()
