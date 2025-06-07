extends Node3D
@onready var anim: AnimationPlayer = $yebaka/AnimationPlayer
@onready var piano_menu: AudioStreamPlayer3D = $AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if !anim.is_playing():
		anim.play("Armature")
	if !piano_menu.playing:
		piano_menu.playing = true

func exit_button() -> void:
	get_tree().quit()


func settings_button() -> void:
	pass # Replace with function body.


func play_button() -> void:
	switch_scene()

func switch_scene():
	get_tree().change_scene_to_file("res://Game/UI/Menu/loadingscene.tscn")
