extends Node3D


@onready var music: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var animation_player: AnimationPlayer = $yebaka/AnimationPlayer
@onready var audio_stream_player_3d_2: AudioStreamPlayer3D = $AudioStreamPlayer3D2

func _ready() -> void:
	if !music.playing:
		music.play(104.0)

func _process(delta: float) -> void:
	if !animation_player.is_playing():
		animation_player.speed_scale = 2.0
		animation_player.play("Armature")
	
	if !audio_stream_player_3d_2.playing:
		audio_stream_player_3d_2.playing = true
