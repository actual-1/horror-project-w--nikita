extends CharacterBody3D

@onready var movement_logic: Node = $MovementLogic

var current_speed : float = 0.0
@export var running_speed : float = 6.0
@export var walking_speed : float = 3.0
@export var crouching_speed : float = 1.2
const JUMP_VELOCITY = 4.5


func _process(delta: float) -> void:
	if movement_logic.current_state == "RUN":
		current_speed = running_speed
	elif movement_logic.current_state == "CROUCH":
		current_speed = crouching_speed
	elif movement_logic.current_state == "WALK":
		current_speed = walking_speed
	else:
		current_speed = walking_speed

func _physics_process(delta: float) -> void:
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("SPACE") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("LEFT", "RIGHT", "FWD", "BWD")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = lerpf(velocity.x, direction.x * current_speed, 0.25)
			velocity.z = lerpf(velocity.z, direction.z * current_speed, 0.25)
		else:
			velocity.x = lerpf(velocity.x, move_toward(velocity.x, 0, current_speed), 0.1)
			velocity.z = lerpf(velocity.z, move_toward(velocity.z, 0, current_speed), 0.1)
	else:
		velocity.x = lerpf(velocity.x, direction.x * current_speed, 0.25)
		velocity.z = lerpf(velocity.z, direction.z * current_speed, 0.25)

	move_and_slide()
