extends Node2D

func _ready():
		$AnimationPlayer.play("EncontraBoto")
	
		


func _on_AnimationPlayer_animation_finished(anim_name):
	$CanvasLayer/Control/TextureRect/DialogueBox.start()
