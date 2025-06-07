extends CanvasLayer

var mouse_input : Vector2
@onready var test: Label = $Control/Test

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_input.x = -event.relative.x
		mouse_input.y = -event.relative.y
		test.text = str(mouse_input)
		
func _physics_process(delta: float) -> void:
	offset -= mouse_input/10
	offset = lerp(offset, Vector2(0.0, 0.0), delta*25)
	scale = lerp(scale, Vector2(1.0 - get_parent().velocity.length()/100, 1.0 - get_parent().velocity.length()/100), delta*10)
