extends Node3D
class_name CameraController

@onready var pitch: Node3D = $PITCH
@onready var head: Camera3D = $PITCH/Head

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		
		rotate_y(-event.relative.x * 0.002)
		pitch.rotate_x(-event.relative.y * 0.002)
		pitch.rotation.x = clamp(pitch.rotation.x, deg_to_rad(-90), deg_to_rad(90))
