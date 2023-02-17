extends Node

@onready var TransitionPlayer := $TransitionPlayer
@onready var GameScene := $GameScene
@onready var HUD := $GameScene/HUD
@onready var Game := $GameScene/Game

var SceneToLoad: String
var CurrentScene:Node
#var HudMode:String = "none" setget _init_HUD
var NextTransition:String
var CurrentMode:String

func _change_scene(scene:String, type:String = "normal"):
	match type:
		"normal":
			NextTransition = "fade_in"
			TransitionPlayer.play("fade_out")
			SceneToLoad = scene

func _scene_load():
	if CurrentScene != null:
		CurrentScene.queue_free()
	
	var scene:PackedScene = load(SceneToLoad)
	var _scene:Node = scene.instantiate()
	Game.add_child(_scene, true)
	CurrentScene = _scene
	_fade_in()

func _reload_scene():
	TransitionPlayer.play("fade_out")

func _fade_in():
	if NextTransition != null:
		TransitionPlayer.play(NextTransition)
