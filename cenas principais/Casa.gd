extends Node2D


func _ready():
	$SomLampada.play()	
	$AmbienteCasa.play()
	$SomRelogio.play()
	$robo/AnimationPlayer.play("Roubo")	


func _on_AnimationPlayer_animation_finished(Roubo):
	$Profundidade/Player.set_physics_process(true)
	$robo.set_visible(false)


func _on_AnimationPlayer_animation_started(Roubo):
	$Profundidade/Player.set_physics_process(false)
