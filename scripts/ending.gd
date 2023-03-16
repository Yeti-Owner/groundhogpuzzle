extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_menu_pressed():
	SceneManager._swap_hud("res://scenes/UI/menu.tscn")
