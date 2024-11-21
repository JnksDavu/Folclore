extends Button

var music: AudioStreamPlayer2D
var pausedPosition: float
var isMusicPlaying = true
var interactionKey = KEY_E




func _ready():
	music = get_node("/root/Quarto/MusicaMenu")
	set_process_input(true)



func _input(event):
	if event.is_action_pressed("interacao"):
		if event.scancode == interactionKey:
			if music.playing:
				pausedPosition = music.get_playback_position()
				music.stop()
				isMusicPlaying = false
			else:
				music.play(pausedPosition)
				isMusicPlaying = true






