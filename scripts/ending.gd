extends Control

func _ready():
	if Eventbus.CanPoll == 0: Eventbus.CanPoll += 1
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Tries.text = "It took you %s tries" % Eventbus.Restarts
	Eventbus._save()

func _on_menu_pressed():
	SceneManager._swap_hud("res://scenes/UI/menu.tscn")
