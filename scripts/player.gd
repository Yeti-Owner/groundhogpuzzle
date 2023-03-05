extends CharacterBody3D

@onready var _camera := $CameraHolder

const SPEED := 5.0
const JUMP_VELOCITY := 4.5

var gravity:float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Eventbus.NewLoop.connect(_new_loop)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (_camera.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func _new_loop():
	set_physics_process(false)
	var LoopAnim:PackedScene = load("res://scenes/timeloop.tscn")
	var _LoopAnim:Node = LoopAnim.instantiate()
	self.add_child(_LoopAnim)
	
	var Temptimer := Timer.new()
	self.add_child(Temptimer)
	Temptimer.wait_time = 3
	Temptimer.connect("timeout", _temp_timer)
	Temptimer.one_shot = true
	Temptimer.start()

func _temp_timer():
	var tween := get_tree().create_tween()
	tween.tween_property($CameraHolder/Camera, "fov", 10, 3).set_trans(Tween.TRANS_LINEAR)
	
