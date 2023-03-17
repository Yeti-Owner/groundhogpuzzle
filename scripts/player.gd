extends CharacterBody3D

@onready var _camera := $CameraHolder

const SPEED := 6.0
const JUMP_VELOCITY := 4.5

var gravity:float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Eventbus.NewLoop.connect(_new_loop)
	Eventbus.Complete.connect(_disable)

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Movement
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (_camera.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept"):
		print(Eventbus.CanPoll)


func _new_loop():
	# Disables everything
	_camera.set_process_input(false)
	set_physics_process(false)
	
	# Adds time particles
	var LoopAnim:PackedScene = load("res://scenes/timeloop.tscn")
	var _LoopAnim:Node = LoopAnim.instantiate()
	self.add_child(_LoopAnim)
	
	$Rewind.Mode = false

func _ending_anim():
	# Shrinks FOV basically
	var tween := get_tree().create_tween()
	tween.tween_property($CameraHolder/Camera, "fov", 2, 3).set_trans(Tween.TRANS_LINEAR)
	tween.connect("finished", _restart)

# When ending animation is done this is called
func _restart():
	print("_restart() called")
	Eventbus._reset()
	Eventbus.Restarts += 1
	SceneManager._reload_scene()

func _disable():
	_camera.set_process_input(false)
	set_physics_process(false)
	$Rewind.set_physics_process(false)
