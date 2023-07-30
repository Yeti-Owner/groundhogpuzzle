extends Node

@onready var Player := get_parent()
@onready var CamHolder := get_parent().get_node("CameraHolder")
@onready var Cam := get_parent().get_node("CameraHolder/Camera")

# Variables for timeloop, stores position and camera
var PlayerPos:Array = []
var CameraX:Array = []
var CameraY:Array = []

var Mode:bool = true # True = record, False = replay

var SkipFrame:bool = false # Skips every other frame so it speeds up the replay

func _physics_process(_delta):
	SkipFrame = !SkipFrame
	if (Mode == true) and (SkipFrame == true):
		PlayerPos.append(Player.global_transform)
		CameraX.append(Cam.get_rotation())
		CameraY.append(CamHolder.get_rotation())
	elif Mode == false:
		if PlayerPos.size() > 0:
			Player.global_transform = PlayerPos[-1]
			Cam.set_rotation(CameraX[-1])
			CamHolder.set_rotation(CameraY[-1])
			PlayerPos.pop_back()
			CameraX.pop_back()
			CameraY.pop_back()
		else:
			Player._ending_anim()
			set_physics_process(false)
