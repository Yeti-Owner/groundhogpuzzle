extends Control

@onready var title := $Title
@onready var vboxoptions := $VBoxContainer
@onready var InfoPopup := $InfoPopup

func _ready():
	if Eventbus.CanPoll == 1: $VBoxContainer/Poll.visible = true
	else: $VBoxContainer/Poll.visible = false
	title.position = Vector2(-440, 313)
	vboxoptions.position = Vector2(-442, 140)
	InfoPopup.visible = false
	_intro_anim()

func _intro_anim():
	var tween := get_tree().create_tween()
	tween.tween_property(title, "position", Vector2(15, 313), 3).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(vboxoptions, "position", Vector2(58, 140), 3).set_trans(Tween.TRANS_ELASTIC)

func _on_info_pressed():
	InfoPopup.visible = !InfoPopup.visible

func _on_info_close_pressed():
	InfoPopup.visible = false

func _on_start_pressed():
	Eventbus._reset()
	SceneManager._change_scene("res://world.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_poll_pressed():
	SceneManager._swap_hud("res://scenes/UI/poll.tscn")
