extends Node

@export var current_state : String = "Idle"

func _process(delta: float) -> void:
	if Input.is_action_pressed("SHIFT"):
		current_state = "RUN"
		
	elif Input.is_action_pressed("CROUCH"):
		current_state = "CROUCH"
		
	if Input.is_action_pressed("LEFT") or Input.is_action_pressed("RIGHT") or Input.is_action_pressed("FWD") or Input.is_action_pressed("BWD"):
		current_state = "WALK"
		
	else:
		current_state = "IDLE"
