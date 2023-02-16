extends CharacterBody3D

@onready var _camera := $CameraHolder
@onready var Coyote := $CoyoteTimer

const walk_speed: float = 6.0
const sprint_speed: float = 8.5
const jump_speed: float = 8.9
const acceleration_speed: float = 0.7
const gravity: float = -32.0
var _dir := Vector3.ZERO
var _vel := Vector3.ZERO

# States
enum {
	DEAD,
	WALKING,
	RUNNING
}
var state := WALKING

func _physics_process(delta: float):
	# Set State
	
	if Input.is_action_pressed("sprint"):
		state = RUNNING
	if (state != DEAD) and !Input.is_action_pressed("sprint"):
		state = WALKING
	
	# Use State
	match state:
		DEAD:
			pass
		WALKING:
			_movement(delta, walk_speed, 1)
		RUNNING:
			_movement(delta, sprint_speed, 1.25)

func _movement(delta, UsedSpeed, bob_speed):
	var input = Vector2.ZERO
	
	if Input.is_action_pressed("forward"):
		input.y += 1
	if Input.is_action_pressed("backward"):
		input.y -= 1
	if Input.is_action_pressed("right"):
		input.x += 1
	if Input.is_action_pressed("left"):
		input.x -= 1
	input = input.normalized()
	
	
	# Jumping
	if _vel.y <= 0 && (is_on_floor() || !Coyote.is_stopped()):
		if Input.is_action_just_pressed("jump"):
			Coyote.stop()
			_vel.y = jump_speed
	
	
	_vel.y = max(_vel.y + (gravity * delta), -8)
	
	var basis: Basis = _camera.global_transform.basis
	_dir = Vector3.ZERO
	_dir += -basis.z * input.y
	_dir += basis.x * input.x
	_dir = _dir.normalized()
	
	
	var acc := _vel.lerp(_dir * UsedSpeed, acceleration_speed)
	
	var was_on_floor := is_on_floor()
	
	velocity = Vector3(acc.x, _vel.y, acc.z)
	move_and_slide()
	
	if was_on_floor && !is_on_floor():
		Coyote.start()
	
	# If moving play head bob animation
#	if _dir != Vector3():
#		PlayerAnim.playback_speed = bob_speed
#		PlayerAnim.play("Head Bob")
