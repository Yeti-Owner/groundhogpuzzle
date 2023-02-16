extends Node3D

@onready var _camera := $Camera

var mouse_sensitivity = 0.18


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_camera.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		_camera.rotation_degrees.x = clamp(_camera.rotation_degrees.x, -89.9, 89.9)

