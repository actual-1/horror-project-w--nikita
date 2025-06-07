extends CharacterBody3D

@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D

@onready var yaw: CameraController = $YAW
@onready var head: Camera3D = $YAW/PITCH/Head
@onready var head_anim: AnimationPlayer = $AnimationPlayer
@onready var stand: CollisionShape3D = $STAND
@onready var sit: CollisionShape3D = $SIT

@export var is_crouching : bool = false

var current_speed : float = 0.0
@export var running_speed : float = 7.0
@export var walking_speed : float = 4.0
@export var crouching_speed : float = 1.2
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	audio.stream = preload("res://Game/Audio/eventAttention.mp3")
	audio.playing = true
	if !head_anim.is_playing():
		head_anim.play("headbob")

func _physics_process(delta: float) -> void:
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta*2

	if Input.is_action_pressed('SHIFT'):
		head_anim.speed_scale = lerpf(head_anim.speed_scale, 1.55, delta*10)
		current_speed = running_speed
		crouching(delta)
		is_crouching = false
	elif Input.is_action_pressed("CROUCH"):
		is_crouching = true
		head_anim.speed_scale = lerpf(head_anim.speed_scale, 0.5, delta*10)
		current_speed = crouching_speed
		crouching(delta)
	else:
		is_crouching = false
		head_anim.speed_scale = lerpf(head_anim.speed_scale, 1.0, delta*10)
		current_speed = walking_speed
		crouching(delta)

	# Handle jump.
	if Input.is_action_just_pressed("SPACE") and is_on_floor():
		velocity.y = JUMP_VELOCITY*1.5

	var input_dir := Input.get_vector("LEFT", "RIGHT", "FWD", "BWD")
	var direction := (yaw.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	if is_on_floor():
		
		if direction:
			head_anim.play("headbob")
			velocity.x = lerpf(velocity.x, direction.x * current_speed, 0.1)
			velocity.z = lerpf(velocity.z, direction.z * current_speed, 0.1)
		else:
			velocity.x = lerpf(velocity.x, move_toward(velocity.x, 0, current_speed), 0.1)
			velocity.z = lerpf(velocity.z, move_toward(velocity.z, 0, current_speed), 0.1)
	else:
		velocity.x = lerpf(velocity.x, direction.x * current_speed, 0.05)
		velocity.z = lerpf(velocity.z, direction.z * current_speed, 0.05)
	
	
	fov_change(delta)
	move_and_slide()

func fov_change(delta):
	var velocity_clamped = clamp(velocity.length(), 1.0, 10.0)
	head.fov = lerp(head.fov, 75 + velocity_clamped*3, delta*10)

func crouching(_delta):
	if is_crouching:
		stand.disabled = true
		sit.disabled = false
		yaw.global_position.y = lerpf(yaw.global_position.y, 1.0, 0.1)
	else:
		stand.disabled = false
		sit.disabled = true
		yaw.global_position.y = lerpf(yaw.global_position.y, 1.7, 0.1)
