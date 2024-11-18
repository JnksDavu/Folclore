extends Node2D

 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VideoPlayer.play()
	$MusicaMenu.play()	
	$AmbienteCasa.play()
	$YSort/Player/AnimationPlayer.play("Idle")
	
func _input(event):
	if(Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(BUTTON_LEFT)):
		$Animacao/ColorRect/Camera2D2/Camera.play("camera")
		$MusicaMenu.stop()

func _process(delta):
	pass



func _on_Button_pressed():
	$YSort/Player.set_physics_process(true)
	$Animacao/HBoxContainer2.set_visible(false)
	$Animacao/ColorRect/Camera2D2/Camera.play("ZoomOut")
	$Animacao/ColorRect/Camera2D2.set_limit(MARGIN_TOP, 10)
	


func _on_Exit_pressed():
	get_tree().quit()
	



func _on_VideoPlayer_finished():
	yield(get_tree().create_timer(1), "timeout")
	$Animacao/ColorRect/Camera2D2/Camera.play("camera")
