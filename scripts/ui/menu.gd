extends Control

@onready var title := $Title
@onready var vboxoptions := $VBoxContainer
@onready var InfoPopup := $InfoPopup

func _ready():
	title.position = Vector2(-300, 270)
	vboxoptions.position = Vector2(-300, 179)
	InfoPopup.visible = false
	_intro_anim()

func _intro_anim():
	var tween := get_tree().create_tween()
	tween.tween_property(title, "position", Vector2(0, 135), 2).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(vboxoptions, "position", Vector2(11, 179), 2).set_trans(Tween.TRANS_ELASTIC)

func _on_info_pressed():
	InfoPopup.visible = !InfoPopup.visible

func _on_info_close_pressed():
	InfoPopup.visible = false

func _on_start_pressed():
	SceneManager._change_scene("res://world.tscn")
	SceneManager._swap_hud("res://scenes/UI/gui.tscn")
